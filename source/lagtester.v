module lagtester(
    input clock,

    input [2:0] RES_CONFIG,

    inout wire SDA,
    inout wire SCL,

    output [7:0] DVI_RED,
    output [7:0] DVI_GREEN,
    output [7:0] DVI_BLUE,
    output DVI_DE,
    output DVI_HSYNC,
    output DVI_VSYNC,

    output DVI_CLOCK
);

    wire control_clock;
    wire internal_clock;
    wire pll_locked;
    wire tfp410_ready;

    osc control_clock_gen(
        .oscena(1'b1),
        .clkout(control_clock)
    );

    pll_main pll(
        .clock(clock),
        .control_clock(control_clock),
        .reset(1'b0),
        .data({ 5'd0, RES_CONFIG }),

        .clock_out(internal_clock),
        .clock_out_video(DVI_CLOCK),
        .locked(pll_locked)
    );

    video video(
        .clock(internal_clock),
        .red(DVI_RED),
        .green(DVI_GREEN),
        .blue(DVI_BLUE),
        .de(DVI_DE),
        .hsync(DVI_HSYNC),
        .vsync(DVI_VSYNC)
    );

    TFP410 tfp410(
        .clk(control_clock),
        .reset(1'b1),
        .output_ready(pll_locked),
        .sda(SDA),
        .scl(SCL),
        .ready(tfp410_ready)/*,
        input ADV7513Config adv7513Config*/
    );
endmodule