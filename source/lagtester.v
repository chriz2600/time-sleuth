module lagtester(
    input clock
);

    pll pll_main(
        .areset(1'b0),
        .configupdate(),
        .inclk0(clock),
        .scanclk(),
        scanclkena,
        scandata,
        c0,
        c1,
        locked,
        scandataout,
        scandone
    );


endmodule