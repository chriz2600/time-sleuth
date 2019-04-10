`include "../defines.v"

module pll_reconf_rom (
    input clock,
    input [7:0] address,
    input read_ena,
    input [`MODE_SIZE-1:0] data,
    input pll_reconf_busy,

    output q,
    output reconfig,
    output reg trigger_read
);

    reg _read_ena = 0;
    reg q_reg;
    reg q_reg_2;
    reg doReconfig;
    reg doReconfig_2;
    reg doReconfig_3;

    reg [`MODE_SIZE-1:0] data_req = 0;

    assign q = q_reg_2;
    assign reconfig = doReconfig_3;

    always @(posedge clock) begin
        _read_ena <= read_ena;

        if (_read_ena && ~read_ena) begin
            doReconfig <= 1;
        end else begin
            doReconfig <= 0;
        end

        if (~pll_reconf_busy && data != data_req) begin
            data_req <= data;
            trigger_read <= 1'b1;
        end else begin
            trigger_read <= 1'b0;
        end

        // RECONF
        case (data_req)
            // RECONF
            `MODE_1080p: begin `include "config/148_5_Mhz.v" end
            `MODE_1080i: begin `include "config/74_25_MHz.v" end
            `MODE_720p: begin `include "config/74_25_MHz.v" end
            `MODE_480p: begin `include "config/27_MHz.v" end
            `MODE_480i: begin `include "config/27_MHz.v" end
            `MODE_240p: begin `include "config/27_MHz.v" end
            `MODE_VGA: begin `include "config/25_2_MHz.v" end
            `MODE_960p: begin `include "config/108_MHz.v" end
            `MODE_576p: begin `include "config/27_MHz.v" end
            `MODE_576i: begin `include "config/27_MHz.v" end
            `MODE_288p: begin `include "config/27_MHz.v" end
            `MODE_WUXGA: begin `include "config/154_MHz.v" end
            `MODE_UXGA: begin `include "config/162_MHz.v" end
        endcase

        // delay output, to match ROM based timing
        q_reg_2 <= q_reg;
        doReconfig_2 <= doReconfig;
        doReconfig_3 <= doReconfig_2;
    end

endmodule
