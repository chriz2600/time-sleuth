module video(
    input clock,
    output reg [7:0] red,
    output reg [7:0] green,
    output reg [7:0] blue,
    output reg de,
    output reg hsync,
    output reg vsync
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
            hsync <= H_SYNC_POL;
        end else begin
            hsync <= ~H_SYNC_POL;
        end
    end

    /* generate vsync */
    always @(posedge clock) begin
        if (counterY < V_SYNC) begin
            vsync <= V_SYNC_POL;
        end else begin
            vsync <= ~V_SYNC_POL;
        end
    end

    /* generate DE */
    always @(posedge clock) begin
        if (counterX >= H_SYNC + H_BACK_PORCH
         && counterY >= V_SYNC + V_BACK_PORCH
         && counterX < H_SYNC + H_BACK_PORCH + H_ACTIVE
         && counterY < V_SYNC + V_BACK_PORCH + V_ACTIVE)
        begin
            de <= 1'b1;
            doOutputValue(counterX - (H_SYNC + H_BACK_PORCH), 8'd255);
        end else begin
            de <= 1'b0;
        end
    end


    task doOutputValue;
        input [11:0] xpos;
        input [7:0] val;
        begin
            if (xpos < 80) begin
                red <= val;
                green <= 8'd0;
                blue <= 8'd0;
            end else if (xpos < 160) begin
                red <= 8'd0;
                green <= val;
                blue <= 8'd0;
            end else if (xpos < 240) begin
                red <= 8'd0;
                green <= 8'd0;
                blue <= val;
            end else if (xpos < 320) begin
                red <= val;
                green <= val;
                blue <= val;
            end else if (xpos < 400) begin
                red <= 8'd0;
                green <= 8'd0;
                blue <= 8'd0;
            end else if (xpos < 480) begin
                red <= 8'd0;
                green <= val;
                blue <= val;
            end else if (xpos < 560) begin
                red <= val;
                green <= val;
                blue <= 8'd0;
            end else begin
                red <= val;
                green <= 8'd0;
                blue <= val;
            end
        end
    endtask

endmodule