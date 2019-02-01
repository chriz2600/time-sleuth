module lagdisplay(
    input clock,
    input [3:0] addr,
    output [WIDTH-1:0] q
);
    parameter WIDTH = 112;

    reg [WIDTH-1:0] q_reg;

    always @(posedge clock) begin
        `include "font/predef/lagdisplay.v";
    end

    assign q = q_reg;

endmodule 
