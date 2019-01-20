module video_config(
    input clock,
    input [7:0] data_in,
    output VideoMode videoMode
);
    `include "config/video_modes.v"

    reg [7:0] data_in_reg = 0;

    VideoMode _videoMode_reg;
    VideoMode videoMode_reg;
    initial begin
        _videoMode_reg = VIDEO_MODE_VGA;
        videoMode_reg = VIDEO_MODE_VGA;
    end
    assign videoMode = videoMode_reg;

    always @(posedge clock) begin
        data_in_reg <= data_in;

        if (data_in_reg != data_in) begin
            case (data_in[2:0])
                // RECONF
                3'b001: _videoMode_reg <= VIDEO_MODE_VGA;
                3'b010: _videoMode_reg <= VIDEO_MODE_720P;
                3'b100: _videoMode_reg <= VIDEO_MODE_1080P;
                default: _videoMode_reg <= VIDEO_MODE_VGA;
            endcase
        end

        videoMode_reg <= _videoMode_reg;
    end
endmodule