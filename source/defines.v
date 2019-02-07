`define MODE_1080p 8'b00000100
`define MODE_720p 8'b00000010
`define MODE_480i 8'b00000001
`define MAX_BCDCOUNT 20'h_9_99_99
// clock.frquency / CLOCK_DIVIDER = 1MHz
`define CLOCK_DIVIDER 27
`define FRAME_COUNTER 6
`define LAGLINE_SIZE 512
// averaging
`define AVERAGE_BITS 4
`define AVERAGE_SIZE (2 ** `AVERAGE_BITS)
