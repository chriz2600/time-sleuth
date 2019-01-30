module lagdisplay(
    input clock,
    input [3:0] addr,
    output [111:0] q
);

    reg [111:0] q_reg;

    always @(posedge clock) begin
        `include "font/predef/lagdisplay.v";
    end

    assign q = q_reg;

endmodule 
