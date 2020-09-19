`ifndef DEFINES_VH
`define DEFINES_VH

////////////////////////////////
`define MODE_SIZE  17
`define MODE_1080p60 `MODE_SIZE'b_0_0000_0000_0000_0001
`define MODE_1080i60 `MODE_SIZE'b_0_0000_0000_0000_0010
`define MODE_720p60  `MODE_SIZE'b_0_0000_0000_0000_0100
`define MODE_480p60  `MODE_SIZE'b_0_0000_0000_0000_1000
`define MODE_480i60  `MODE_SIZE'b_0_0000_0000_0001_0000
`define MODE_240p60  `MODE_SIZE'b_0_0000_0000_0010_0000
`define MODE_VGA     `MODE_SIZE'b_0_0000_0000_0100_0000
`define MODE_960p60  `MODE_SIZE'b_0_0000_0000_1000_0000
`define MODE_576p50  `MODE_SIZE'b_0_0000_0001_0000_0000
`define MODE_576i50  `MODE_SIZE'b_0_0000_0010_0000_0000
`define MODE_288p50  `MODE_SIZE'b_0_0000_0100_0000_0000
`define MODE_WUXGA   `MODE_SIZE'b_0_0000_1000_0000_0000
`define MODE_UXGA    `MODE_SIZE'b_0_0001_0000_0000_0000
`define MODE_1080p50 `MODE_SIZE'b_0_0010_0000_0000_0000
`define MODE_1080i50 `MODE_SIZE'b_0_0100_0000_0000_0000
`define MODE_720p50  `MODE_SIZE'b_0_1000_0000_0000_0000
`define MODE_900p60  `MODE_SIZE'b_1_0000_0000_0000_0000
////////////////////////////////
`define MAX_BCDCOUNT 20'h_9_99_99
// clock.frquency / CLOCK_DIVIDER = 100kHz
`define CLOCK_DIVIDER 270
`define FRAME_COUNTER 20
`define FRAME_ON_COUNT 15
// `define LAGLINE_FILE "font/predef/lagdisplay.v"
// `define LAGLINE_SIZE 512
// `define LL_END1 12'd_80
// `define LL_END2 12'd_120
// `define LL_END3 12'd_192
// `define LL_END4 12'd_120
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
