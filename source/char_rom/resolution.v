
`include "../defines.v"

module resolution(
    input clock,
    input VideoMode videoMode,
    input [3:0] addr,
    output [`RESLINE_SIZE-1:0] q
);
    reg [`RESLINE_SIZE-1:0] q_reg;

    always @(posedge clock) begin
        case (videoMode.id)
            `MODE_1080p: begin `include "font/predef/1080p.v" end
            `MODE_1080i: begin `include "font/predef/1080i.v" end
            `MODE_720p: begin `include "font/predef/720p.v" end
            `MODE_480p: begin `include "font/predef/480p.v" end
            `MODE_480i: begin `include "font/predef/480i.v" end
            `MODE_240p: begin `include "font/predef/240p.v" end
            `MODE_VGA: begin `include "font/predef/VGA.v" end
            `MODE_960p: begin `include "font/predef/960p.v" end
            `MODE_576p: begin `include "font/predef/576p.v" end
            `MODE_576i: begin `include "font/predef/576i.v" end
            `MODE_288p: begin `include "font/predef/288p.v" end
            `MODE_WUXGA: begin `include "font/predef/WUXGA.v" end
            `MODE_UXGA: begin `include "font/predef/UXGA.v" end
        endcase
    end

    assign q = q_reg;

endmodule 


