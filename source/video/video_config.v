`include "../defines.v"

module video_config(
    input clock,
    input [`MODE_SIZE-1:0] data_in,
    output VideoMode videoMode
);
    `include "../config/video_modes.v"

    reg [`MODE_SIZE-1:0] data_in_reg;

    VideoMode videoMode_reg;
    assign videoMode = videoMode_reg;

    always @(posedge clock) begin
        data_in_reg <= data_in;

        if (data_in_reg != data_in) begin
            case (data_in)
                `include "../generated/video-modes.v"
            endcase
        end
    end

endmodule
