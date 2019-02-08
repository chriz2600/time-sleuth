`include "defines.v"

module configuration(
    input clock,
    input [4:0] config_in,
    output reg [7:0] config_data,
    output config_changed
);
    reg [7:0] prev_config_data;

    always @(posedge clock) begin
        prev_config_data <= config_data;
        case (config_in)
            5'b_00001: config_data <= `MODE_1080p; // switch 1
            5'b_00011: config_data <= `MODE_1080p; // switch 1 legacy
            5'b_00010: config_data <= `MODE_1080i; // switch 2
            5'b_00100: config_data <= `MODE_720p;  // switch 3
            5'b_00110: config_data <= `MODE_720p;  // switch 3 legacy
            5'b_01000: config_data <= `MODE_480p;  // switch 4
            5'b_10000: config_data <= `MODE_480i;  // switch 5
            default: config_data <= `DEFAULT_FB_MODE;
        endcase
    end

    assign config_changed = (prev_config_data != config_data);

endmodule