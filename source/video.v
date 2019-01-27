module video(
    input clock,
    input VideoMode videoMode,
    output [7:0] red,
    output [7:0] green,
    output [7:0] blue,
    output de,
    output hsync,
    output vsync
);

    reg [11:0] counterX = 0;
    reg [11:0] counterY = 0;

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

    /* frame counter */
    always @(posedge clock) begin
        if (counterX == 0 && counterY == 0) begin
            if (frameCounter < 6 - 1) begin
                frameCounter <= frameCounter + 1'b1;
            end else begin
                frameCounter <= 0;
                displayFields <= ~displayFields;
            end
        end
    end

    /* generate hsync */
    always @(posedge clock) begin
        if (counterX < videoMode.h_sync) begin
            hsync_reg <= videoMode.h_sync_pol;
        end else begin
            hsync_reg <= ~videoMode.h_sync_pol;
        end
    end

    /* generate vsync */
    always @(posedge clock) begin
        if (counterY < videoMode.v_sync) begin
            vsync_reg <= videoMode.v_sync_pol;
        end else begin
            vsync_reg <= ~videoMode.v_sync_pol;
        end
    end

    /* generate DE */
    always @(posedge clock) begin
        if (counterX >= videoMode.h_sync + videoMode.h_back_porch
         && counterY >= videoMode.v_sync + videoMode.v_back_porch
         && counterX < videoMode.h_sync + videoMode.h_back_porch + videoMode.h_active
         && counterY < videoMode.v_sync + videoMode.v_back_porch + videoMode.v_active)
        begin
            de_reg <= 1'b1;
            doOutputValue(
                counterX - (videoMode.h_sync + videoMode.h_back_porch), 
                counterY - (videoMode.v_sync + videoMode.v_back_porch)
            );
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
                (xpos > videoMode.h_field_start && xpos < videoMode.h_field_end && 
                   ((ypos > videoMode.v_field1_start && ypos < videoMode.v_field1_end)
                 || (ypos > videoMode.v_field2_start && ypos < videoMode.v_field2_end)
                 || (ypos > videoMode.v_field3_start && ypos < videoMode.v_field3_end)))) 
            begin
                data_reg <= 24'h_FF_FF_FF;
            // end else TEXT
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

endmodule