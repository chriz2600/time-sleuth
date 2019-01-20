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

    reg [7:0] red_reg;
    reg [7:0] green_reg;
    reg [7:0] blue_reg;
    reg de_reg;
    reg hsync_reg;
    reg vsync_reg;

    reg [7:0] red_reg_q;
    reg [7:0] green_reg_q;
    reg [7:0] blue_reg_q;
    reg de_reg_q;
    reg hsync_reg_q;
    reg vsync_reg_q;

    /*
        H_SYNC  H_BACK_PORCH  H_ACTIVE H_FRONT_PORCH
        V_SYNC  V_BACK_PORCH  V_ACTIVE V_FRONT_PORCH
    */

    /* generate counter */
    always @(posedge clock) begin
        if (counterX < videoMode.h_total) begin
            counterX <= counterX + 1'b1;
        end else begin
            counterX <= 0;
            if (counterY <= videoMode.v_total) begin
                counterY <= counterY + 1'b1;
            end else begin
                counterY <= 0;
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
            doOutputValue(counterX - (videoMode.h_sync + videoMode.h_back_porch), 8'd255);
        end else begin
            de_reg <= 1'b0;
            red_reg <= 1'b0;
            green_reg <= 1'b0;
            blue_reg <= 1'b0;
        end
    end


    task doOutputValue;
        input [11:0] xpos;
        input [7:0] val;
        begin
            if (xpos < 80) begin
                red_reg <= val;
                green_reg <= 8'd0;
                blue_reg <= 8'd0;
            end else if (xpos < 160) begin
                red_reg <= 8'd0;
                green_reg <= val;
                blue_reg <= 8'd0;
            end else if (xpos < 240) begin
                red_reg <= 8'd0;
                green_reg <= 8'd0;
                blue_reg <= val;
            end else if (xpos < 320) begin
                red_reg <= val;
                green_reg <= val;
                blue_reg <= val;
            end else if (xpos < 400) begin
                red_reg <= 8'd0;
                green_reg <= 8'd0;
                blue_reg <= 8'd0;
            end else if (xpos < 480) begin
                red_reg <= 8'd0;
                green_reg <= val;
                blue_reg <= val;
            end else if (xpos < 560) begin
                red_reg <= val;
                green_reg <= val;
                blue_reg <= 8'd0;
            end else begin
                red_reg <= val;
                green_reg <= 8'd0;
                blue_reg <= val;
            end
        end
    endtask

    delayline #(
        .CYCLES(2),
        .WIDTH(27)
    ) vout_delay (
        .clock(clock),
        .in({ de_reg, hsync_reg, vsync_reg, red_reg, green_reg, blue_reg }),
        .out({ de_reg_q, hsync_reg_q, vsync_reg_q, red_reg_q, green_reg_q, blue_reg_q })
    );

    assign de = de_reg_q;
    assign hsync = hsync_reg_q;
    assign vsync = vsync_reg_q;
    assign red = red_reg_q;
    assign green = green_reg_q;
    assign blue = blue_reg_q;

endmodule