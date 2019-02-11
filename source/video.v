`include "defines.v"

module video(
    input clock,
    input [`MODE_SIZE-1:0] config_data,
    input [79:0] bcdcount,
    output [7:0] red,
    output [7:0] green,
    output [7:0] blue,
    output de,
    output hsync,
    output vsync,
    output starttrigger
);
    wire [11:0] counterX;
    wire [11:0] counterY;
    wire [11:0] visible_counterX;
    wire [11:0] visible_counterY;
    wire _de;
    wire [`RESLINE_SIZE-1:0] resolution_line;
    wire [`LAGLINE_SIZE-1:0] lagdisplay_line;
    wire state;

    VideoMode videoMode;

    video_config video_config(
        .clock(clock),
        .data_in(config_data),
        .videoMode(videoMode)
    );

    timingsgen timingsgen(
        .clock(clock),
        .videoMode(videoMode),
        .counterX(counterX),
        .counterY(counterY),
        .visible_counterX(visible_counterX),
        .visible_counterY(visible_counterY),
        .hsync(hsync),
        .vsync(vsync),
        .de(_de),
        .state(state)
    );

    textgen textgen(
        .clock(clock),
        .videoMode(videoMode),
        .counterX(counterX),
        .visible_counterX(visible_counterX),
        .visible_counterY(visible_counterY),
        .bcdcount(bcdcount),
        .resolution_line(resolution_line),
        .lagdisplay_line_out(lagdisplay_line)
    );

    videogen videogen(
        .clock(clock),
        .videoMode(videoMode),
        .counterX(counterX),
        .counterY(counterY),
        .visible_counterX(visible_counterX),
        .visible_counterY(visible_counterY),
        .de(_de),
        .resolution_line(resolution_line),
        .lagdisplay_line(lagdisplay_line),
        .state(state),
        .starttrigger(starttrigger),
        .data({ red, green, blue })
    );

    assign de = _de;

endmodule