`ifndef DEFINES_VH
`define DEFINES_VH

////////////////////////////////
`define MODE_SIZE  8
`define MODE_1080p `MODE_SIZE'b_0000_0001
`define MODE_1080i `MODE_SIZE'b_0000_0010
`define MODE_720p  `MODE_SIZE'b_0000_0100
`define MODE_480p  `MODE_SIZE'b_0000_1000
`define MODE_480i  `MODE_SIZE'b_0001_0000
`define MODE_240p  `MODE_SIZE'b_0010_0000
`define MODE_VGA   `MODE_SIZE'b_0100_0000
`define MODE_960p  `MODE_SIZE'b_1000_0000
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
`define RESLINE_SIZE 12'd_136
// averaging
`define AVERAGE_BITS 4
`define AVERAGE_SIZE (2 ** `AVERAGE_BITS)
// define slots
`ifndef SLOT1
    `define SLOT1 `MODE_1080p
`endif
`ifndef SLOT2
    `define SLOT2 `MODE_1080i
`endif
`ifndef SLOT3
    `define SLOT3 `MODE_720p
`endif
`ifndef SLOT4
    `define SLOT4 `MODE_480p
`endif
`ifndef SLOT5
    `define SLOT5 `MODE_480i
`endif

`endif
