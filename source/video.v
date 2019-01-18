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
    localparam H_SYNC_POL = 0;

    localparam V_TOTAL = 525;
    localparam V_ACTIVE = 480;
    localparam V_FRONT_PORCH = 10;
    localparam V_SYNC = 2;
    localparam V_BACK_PORCH = 33;
    localparam V_SYNC_POL = 0;

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

    end


endmodule