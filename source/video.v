module video(
    input clock,
    output [7:0] red,
    output [7:0] green,
    output [7:0] blue,
    output de,
    output hsync,
    output vsync
);

    localparam H_TOTAL = 800;
    localparam H_ACTIVE = 640;
    localparam H_FRONT_PORCH = 16;
    localparam H_SYNC = 96;
    localparam H_BACK_PORCH = 48;
    localparam H_SYNC_POL = 1'b0;

    localparam V_TOTAL = 525;
    localparam V_ACTIVE = 480;
    localparam V_FRONT_PORCH = 10;
    localparam V_SYNC = 2;
    localparam V_BACK_PORCH = 33;
    localparam V_SYNC_POL = 1'b0;

    reg [10:0] counterX = 0;
    reg [10:0] counterY = 0;

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
        if (counterX < H_TOTAL) begin
            counterX <= counterX + 1'b1;
        end else begin
            counterX <= 0;
            if (counterY <= V_TOTAL) begin
                counterY <= counterY + 1'b1;
            end else begin
                counterY <= 0;
            end
        end
    end 

    /* generate hsync */
    always @(posedge clock) begin
        if (counterX < H_SYNC) begin
            hsync_reg <= H_SYNC_POL;
        end else begin
            hsync_reg <= ~H_SYNC_POL;
        end
    end

    /* generate vsync */
    always @(posedge clock) begin
        if (counterY < V_SYNC) begin
            vsync_reg <= V_SYNC_POL;
        end else begin
            vsync_reg <= ~V_SYNC_POL;
        end
    end

    /* generate DE */
    always @(posedge clock) begin
        if (counterX >= H_SYNC + H_BACK_PORCH
         && counterY >= V_SYNC + V_BACK_PORCH
         && counterX < H_SYNC + H_BACK_PORCH + H_ACTIVE
         && counterY < V_SYNC + V_BACK_PORCH + V_ACTIVE)
        begin
            de_reg <= 1'b1;
            doOutputValue(counterX - (H_SYNC + H_BACK_PORCH), 8'd255);
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