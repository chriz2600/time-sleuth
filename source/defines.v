`ifndef DEFINES_VH
`define DEFINES_VH

////////////////////////////////
`define MODE_SIZE  20
`define MODE_1080p60 `MODE_SIZE'b_0000_0000_0000_0000_0001
`define MODE_1080i60 `MODE_SIZE'b_0000_0000_0000_0000_0010
`define MODE_720p60  `MODE_SIZE'b_0000_0000_0000_0000_0100
`define MODE_480p60  `MODE_SIZE'b_0000_0000_0000_0000_1000
`define MODE_480i60  `MODE_SIZE'b_0000_0000_0000_0001_0000
`define MODE_240p60  `MODE_SIZE'b_0000_0000_0000_0010_0000
`define MODE_VGA     `MODE_SIZE'b_0000_0000_0000_0100_0000
`define MODE_960p60  `MODE_SIZE'b_0000_0000_0000_1000_0000
`define MODE_576p50  `MODE_SIZE'b_0000_0000_0001_0000_0000
`define MODE_576i50  `MODE_SIZE'b_0000_0000_0010_0000_0000
`define MODE_288p50  `MODE_SIZE'b_0000_0000_0100_0000_0000
`define MODE_WUXGA   `MODE_SIZE'b_0000_0000_1000_0000_0000
`define MODE_UXGA    `MODE_SIZE'b_0000_0001_0000_0000_0000
`define MODE_1080p50 `MODE_SIZE'b_0000_0010_0000_0000_0000
`define MODE_1080i50 `MODE_SIZE'b_0000_0100_0000_0000_0000
`define MODE_720p50  `MODE_SIZE'b_0000_1000_0000_0000_0000
`define MODE_900p60  `MODE_SIZE'b_0001_0000_0000_0000_0000
`define MODE_540p60  `MODE_SIZE'b_0010_0000_0000_0000_0000
`define MODE_1080p30 `MODE_SIZE'b_0100_0000_0000_0000_0000
`define MODE_1080p24 `MODE_SIZE'b_1000_0000_0000_0000_0000
////////////////////////////////
`define MAX_BCDCOUNT 20'h_9_99_99
// clock.frquency / CLOCK_DIVIDER = 100kHz
`define CLOCK_DIVIDER 270

`define FRAME_COUNTER60 6'd_20
`define FRAME_ON_COUNT60 6'd_15
`define FRAME_COUNTER50 6'd_17
`define FRAME_ON_COUNT50 6'd_12
`define FRAME_COUNTER30 6'd_10
`define FRAME_ON_COUNT30 6'd_7
`define FRAME_COUNTER24 6'd_8
`define FRAME_ON_COUNT24 6'd_5
// `define FRAME_COUNTER60 6'd_20
// `define FRAME_ON_COUNT60 6'd_15
// `define FRAME_COUNTER50 6'd_20
// `define FRAME_ON_COUNT50 6'd_15
// `define FRAME_COUNTER30 6'd_20
// `define FRAME_ON_COUNT30 6'd_15
// `define FRAME_COUNTER24 6'd_20
// `define FRAME_ON_COUNT24 6'd_15

`define LAGLINE_FILE "font/predef/lagdisplay2.v"
`define LAGLINE_SIZE 400
`define LL_END1 12'd_64
`define LL_END2 12'd_88
`define LL_END3 12'd_160
`define LL_END4 12'd_88
`define RESLINE_SIZE 12'd_80
`define RESLINE_SPACER 12'd_80
// averaging
`define AVERAGE_BITS 4
`define AVERAGE_SIZE (2 ** `AVERAGE_BITS)

// define slots

`include "generated/slots.v"

`endif
