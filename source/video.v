module video(
    input clock,
    input [7:0] config_data,
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

    resolution_line resolution_line(
        .clock(clock),
        .videoMode(videoMode),
        .addr(res_line_addr),
        .q(res_line)
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

    reg [3:0] res_line_addr;
    reg [39:0] res_line /* synthesis noprune */;

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
            // addr for res_line
            res_line_addr <= counterY - (videoMode.v_sync + videoMode.v_back_porch);
        end
    end 

    /* visible area counter */
    always @(posedge clock) begin
        visible_counterX <= counterX - (videoMode.h_sync + videoMode.h_back_porch);
        visible_counterY <= counterY - (videoMode.v_sync + videoMode.v_back_porch);
        visible_counterX_delayed <= visible_counterX;
        visible_counterY_delayed <= visible_counterY;
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

    // wire [10:0] char_addr;
    // wire [7:0] char_data;
    // char_rom char_rom_inst(
    //     .address(char_addr),
    //     .clock(clock),
    //     .q(char_data)
    // );

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
            end else if (ypos < 16 && xpos >= 1024) begin // resolution info
                if (res_line[xpos - 1024]) begin
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