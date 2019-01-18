module lagtester(
    input clock,
    output DVI_CLOCK
);

    wire control_clock;
    wire internal_clock;
    wire pll_locked;

    osc control_clock_gen(
        .oscena(1'b1),
        .clkout(control_clock)
    );

    pll_main pll(
        .clock(clock),
        .control_clock(control_clock),
        .reset(1'b0),
        .data(8'd0), 

        .clock_out(internal_clock),
        .clock_out_video(DVI_CLOCK),
        .locked(pll_locked)
    );


endmodule