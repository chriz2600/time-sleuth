
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
            `MODE_1080p60: begin `include "font/predef/1080p60.v" end
            `MODE_1080i60: begin `include "font/predef/1080i60.v" end
            `MODE_720p60: begin `include "font/predef/720p60.v" end
            `MODE_480p60: begin `include "font/predef/480p60.v" end
            `MODE_480i60: begin `include "font/predef/480i60.v" end
            `MODE_240p60: begin `include "font/predef/240p60.v" end
            `MODE_VGA: begin `include "font/predef/VGA.v" end
            `MODE_960p60: begin `include "font/predef/960p60.v" end
            `MODE_576p50: begin `include "font/predef/576p50.v" end
            `MODE_576i50: begin `include "font/predef/576i50.v" end
            `MODE_288p50: begin `include "font/predef/288p50.v" end
            `MODE_WUXGA: begin `include "font/predef/WUXGA.v" end
            `MODE_UXGA: begin `include "font/predef/UXGA.v" end
            `MODE_1080p50: begin `include "font/predef/1080p50.v" end
            `MODE_1080i50: begin `include "font/predef/1080i50.v" end
            `MODE_720p50: begin `include "font/predef/720p50.v" end
            `MODE_900p60: begin `include "font/predef/900p60.v" end
            `MODE_540p60: begin `include "font/predef/540p60.v" end
        endcase
    end

    assign q = q_reg;

endmodule 


