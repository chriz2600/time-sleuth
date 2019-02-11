
`include "../defines.v"

module lagdisplay(
    input clock,
    input [3:0] addr,
    output [`LAGLINE_SIZE-1:0] q
);
    reg [`LAGLINE_SIZE-1:0] q_reg;

    always @(posedge clock) begin
        `include `LAGLINE_FILE;
    end

    assign q = q_reg;

endmodule 
