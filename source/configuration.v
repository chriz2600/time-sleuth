`include "defines.v"

module configuration(
    input clock,
    input [4:0] config_in,
    output reg [`MODE_SIZE-1:0] config_data,
    output config_changed
);
    reg [`MODE_SIZE-1:0] prev_config_data;

    always @(posedge clock) begin
        prev_config_data <= config_data;
        case (config_in)
            5'b_00001: config_data <= `SLOT1; // switch 1
            5'b_00010: config_data <= `SLOT2; // switch 2
            5'b_00100: config_data <= `SLOT3; // switch 3
            5'b_01000: config_data <= `SLOT4; // switch 4
            5'b_10000: config_data <= `SLOT5; // switch 5
            5'b_11110: config_data <= `SLOT1; // switch 1
            5'b_11101: config_data <= `SLOT2; // switch 2
            5'b_11011: config_data <= `SLOT3; // switch 3
            5'b_10111: config_data <= `SLOT4; // switch 4
            5'b_01111: config_data <= `SLOT5; // switch 5
        endcase
    end

    assign config_changed = (prev_config_data != config_data);

endmodule