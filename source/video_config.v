`include "defines.v"

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
        _videoMode_reg = VIDEO_MODE_1080P;
        videoMode_reg = VIDEO_MODE_1080P;
    end
    assign videoMode = videoMode_reg;

    always @(posedge clock) begin
        data_in_reg <= data_in;

        if (data_in_reg != data_in) begin
            case (data_in)
                // RECONF
                `MODE_VGA: _videoMode_reg <= VIDEO_MODE_VGA;
                `MODE_720p: _videoMode_reg <= VIDEO_MODE_720P;
                `MODE_1080p: _videoMode_reg <= VIDEO_MODE_1080P;
            endcase
        end

        videoMode_reg <= _videoMode_reg;
    end

endmodule