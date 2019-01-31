module video(
    input clock,
    input [7:0] config_data,
    input [23:0] bcdcount,
    output [7:0] red,
    output [7:0] green,
    output [7:0] blue,
    output de,
    output hsync,
    output vsync,
    output starttrigger
);

    reg [11:0] counterX = 0;
    reg [11:0] counterY = 0;

    reg [11:0] counterX_delayed = 0;
    reg [11:0] counterY_delayed = 0;

    reg [11:0] visible_counterX = 0;
    reg [11:0] visible_counterY = 0;

    reg [11:0] visible_counterX_delayed = 0;
    reg [11:0] visible_counterY_delayed = 0;

    delayline #(
        .CYCLES(2),
        .WIDTH(24)
    ) counter_delay (
        .clock(clock),
        .in({ counterX, counterY }),
        .out({ counterX_delayed, counterY_delayed })
    );

    VideoMode videoMode;

    video_config video_config(
        .clock(clock),
        .data_in(config_data),
        .videoMode(videoMode)
    );

    resolution resolution(
        .clock(clock),
        .videoMode(videoMode),
        .addr(resolution_addr),
        .q(resolution_line)
    );

    lagdisplay lagdisplay(
        .clock(clock),
        .addr(lagdisplay_addr),
        .q(lagdisplay_line)
    );

    reg [23:0] data_reg;
    reg de_reg;
    reg hsync_reg;
    reg vsync_reg;

    reg [23:0] data_reg_q;
    reg de_reg_q;
    reg hsync_reg_q;
    reg vsync_reg_q;

    reg [31:0] frameCounter = 0;
    reg displayFields = 0;
    reg starttrigger_reg = 0;
    
    localparam FRAME_COUNTER = 6;

    reg [3:0] resolution_addr;
    reg [39:0] resolution_line /* synthesis noprune */;
    reg [11:0] resolution_end_pos;
    reg [11:0] resolution_counterX;

    reg [3:0] lagdisplay_addr;
    reg [111:0] lagdisplay_line;
    reg [111:0] lagdisplay_line_out;
    reg [111:0] lagdisplay_line_out_2;
    reg [11:0] lagdisplay_start_pos;
    reg [11:0] lagdisplay_end_pos;
    reg [11:0] lagdisplay_counterX;

    reg [10:0] char_addr;
    reg [10:0] char_addr_base;
    reg [7:0] char_data;
    char_rom char_rom_inst(
        .clock(clock),
        .address(char_addr),
        .q(char_data)
    );

    /*
        H_SYNC  H_BACK_PORCH  H_ACTIVE H_FRONT_PORCH
        V_SYNC  V_BACK_PORCH  V_ACTIVE V_FRONT_PORCH
    */

    /* generate counter */
    always @(posedge clock) begin
        if (counterX < videoMode.h_total - 1) begin
            counterX <= counterX + 1'b1;
        end else begin
            counterX <= 0;
            if (counterY < videoMode.v_total - 1) begin
                counterY <= counterY + 1'b1;
            end else begin
                counterY <= 0;
            end
        end
    end 

    /* bcdcount */
    always @(posedge clock) begin
        case (counterX)
            0: begin
                // addr for resolution_line
                resolution_addr <= (visible_counterY + 1'b1) >> videoMode.res_divider;
                lagdisplay_addr <= (visible_counterY + 1'b1 - videoMode.v_lag_start) >> videoMode.lag_divider;
            end
            1: begin
                resolution_end_pos <= (12'd16 << videoMode.res_divider);
                lagdisplay_start_pos <= videoMode.v_lag_start;
                lagdisplay_end_pos <= (videoMode.v_lag_start + (12'd16 << videoMode.lag_divider));
                char_addr_base <= lagdisplay_addr + (8'h_30 << 4);
            end
            2: lagdisplay_line_out <= lagdisplay_line;
            
            3: char_addr <= char_addr_base + (bcdcount[7:4] << 4);
            4: char_addr <= char_addr_base + (bcdcount[11:8] << 4);
            5: char_addr <= char_addr_base + (bcdcount[15:12] << 4);

            6: begin 
                lagdisplay_line_out[31:24] <= char_data;
                char_addr <= char_addr_base + (bcdcount[19:16] << 4);
            end
            7: begin 
                lagdisplay_line_out[39:32] <= char_data;
                char_addr <= char_addr_base + (bcdcount[23:20] << 4);
            end
            8: lagdisplay_line_out[55:48] <= char_data;
            9: lagdisplay_line_out[63:56] <= char_data;
            10: lagdisplay_line_out[71:64] <= char_data;
            
            11: lagdisplay_line_out_2 <= lagdisplay_line_out;
        endcase
    end

    /* visible area counter */
    always @(posedge clock) begin
        visible_counterX <= counterX - (videoMode.h_sync + videoMode.h_back_porch);
        visible_counterY <= counterY - (videoMode.v_sync + videoMode.v_back_porch);
        visible_counterX_delayed <= visible_counterX;
        visible_counterY_delayed <= visible_counterY;
        // special counter(s)
        resolution_counterX <= 12'd_39 - ((visible_counterX >> videoMode.res_divider) - videoMode.h_res_start);
        lagdisplay_counterX <= 12'd_111 - ((visible_counterX >> videoMode.lag_divider) - videoMode.h_lag_start);
    end

    /* frame counter */
    always @(posedge clock) begin
        if (counterX_delayed == videoMode.h_sync + videoMode.h_back_porch
         && counterY_delayed == videoMode.v_sync + videoMode.v_back_porch) begin
            if (frameCounter < FRAME_COUNTER - 1) begin
                frameCounter <= frameCounter + 1'b1;
            end else begin
                frameCounter <= 0;
                displayFields <= ~displayFields;
                starttrigger_reg <= ~displayFields;
            end
        end else begin
            starttrigger_reg <= 0;
        end
    end

    /* generate hsync */
    always @(posedge clock) begin
        if (counterX_delayed < videoMode.h_sync) begin
            hsync_reg <= videoMode.h_sync_pol;
        end else begin
            hsync_reg <= ~videoMode.h_sync_pol;
        end
    end

    /* generate vsync */
    always @(posedge clock) begin
        if (counterY_delayed < videoMode.v_sync) begin
            vsync_reg <= videoMode.v_sync_pol;
        end else begin
            vsync_reg <= ~videoMode.v_sync_pol;
        end
    end

    /* generate DE */
    always @(posedge clock) begin
        if (counterX_delayed >= videoMode.h_sync + videoMode.h_back_porch
         && counterY_delayed >= videoMode.v_sync + videoMode.v_back_porch
         && counterX_delayed < videoMode.h_sync + videoMode.h_back_porch + videoMode.h_active
         && counterY_delayed < videoMode.v_sync + videoMode.v_back_porch + videoMode.v_active)
        begin
            de_reg <= 1'b1;
            doOutputValue(visible_counterX_delayed, visible_counterY_delayed);
        end else begin
            de_reg <= 0;
            data_reg <= 0;
        end
    end

    task doOutputValue;
        input [11:0] xpos;
        input [11:0] ypos;
        begin
            if (displayFields && 
                (xpos >= videoMode.h_field_start && xpos < videoMode.h_field_end && 
                   ((ypos >= videoMode.v_field1_start && ypos < videoMode.v_field1_end)
                 || (ypos >= videoMode.v_field2_start && ypos < videoMode.v_field2_end)
                 || (ypos >= videoMode.v_field3_start && ypos < videoMode.v_field3_end))))
            begin
                data_reg <= 24'h_FF_FF_FF;
            end else if (
                    ypos < resolution_end_pos 
                && (xpos >> videoMode.res_divider) >= videoMode.h_res_start
            ) begin // resolution info
                if (resolution_line[resolution_counterX]) begin
                    data_reg <= 24'h_FF_FF_FF;
                end else begin
                    data_reg <= 0;
                end
            end else if (
                   ypos >= lagdisplay_start_pos 
                && ypos < lagdisplay_end_pos 
                && (xpos >> videoMode.lag_divider) >= videoMode.h_lag_start
                && (xpos >> videoMode.lag_divider) < videoMode.h_lag_end
            ) begin
                if (lagdisplay_line_out_2[lagdisplay_counterX]) begin
                    data_reg <= 24'h_FF_FF_FF;
                end else begin
                    data_reg <= 0;
                end
            end else begin
                data_reg <= 0;
            end
        end
    endtask

    delayline #(
        .CYCLES(2),
        .WIDTH(27)
    ) vout_delay (
        .clock(clock),
        .in({ de_reg, hsync_reg, vsync_reg, data_reg }),
        .out({ de_reg_q, hsync_reg_q, vsync_reg_q, data_reg_q })
    );

    assign de = de_reg_q;
    assign hsync = hsync_reg_q;
    assign vsync = vsync_reg_q;
    assign red = data_reg_q[23:16];
    assign green = data_reg_q[15:8];
    assign blue = data_reg_q[7:0];
    assign starttrigger = starttrigger_reg;

endmodule