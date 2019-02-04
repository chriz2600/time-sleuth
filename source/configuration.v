`include "defines.v"

module configuration(
    input clock,
    input [2:0] config_in,
    output reg [7:0] config_data,
    output config_changed
);
    reg [7:0] prev_config_data;

    always @(posedge clock) begin
        prev_config_data <= config_data;
        case (config_in)
            3'b001: config_data <= `MODE_VGA;
            3'b011: config_data <= `MODE_VGA;
            3'b010: config_data <= `MODE_720p;
            3'b100: config_data <= `MODE_1080p;
            3'b110: config_data <= `MODE_1080p;
            default: config_data <= `MODE_VGA;
        endcase
    end

    assign config_changed = (prev_config_data != config_data);

endmodule