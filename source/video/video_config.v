`include "../defines.v"

module video_config(
    input clock,
    input [7:0] data_in,
    output VideoMode videoMode
);
    `include "../config/video_modes.v"

    reg [7:0] data_in_reg;

    VideoMode videoMode_reg;
    assign videoMode = videoMode_reg;

    always @(posedge clock) begin
        data_in_reg <= data_in;

        if (data_in_reg != data_in) begin
            case (data_in)
                `MODE_480i: videoMode_reg <= VIDEO_MODE_480i;
                `MODE_720p: videoMode_reg <= VIDEO_MODE_720P;
                `MODE_1080p: videoMode_reg <= VIDEO_MODE_1080P;
            endcase
        end
    end

endmodule