
`include "../defines.v"

module resolution(
    input clock,
    input VideoMode videoMode,
    input [3:0] addr,
    output [191:0] q
);

    reg [191:0] q_reg;

    always @(posedge clock) begin
        case (videoMode.id)
            `MODE_1080p: begin `include "font/predef/1080p.v" end
            `MODE_720p: begin `include "font/predef/720p.v" end
            `MODE_480i: begin `include "font/predef/480i.v" end
        endcase
    end

    assign q = q_reg;

endmodule 


