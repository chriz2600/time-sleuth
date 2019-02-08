`define MODE_1080p 8'b_0000_0010
`define MODE_1080i 8'b_0000_0011
`define MODE_720p  8'b_0000_0100
`define MODE_480p  8'b_0000_1000
`define MODE_480i  8'b_0000_1001
`define MAX_BCDCOUNT 20'h_9_99_99
// clock.frquency / CLOCK_DIVIDER = 1MHz
`define CLOCK_DIVIDER 27
`define FRAME_COUNTER 6
`define LAGLINE_SIZE 512
`define RESLINE_SIZE 12'd_136
// averaging
`define AVERAGE_BITS 4
`define AVERAGE_SIZE (2 ** `AVERAGE_BITS)
// ...
`define DEFAULT_FB_MODE `MODE_1080p
