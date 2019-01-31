`include "defines.v"

module lagtester(
    input clock,

    input [2:0] RES_CONFIG,

    inout wire SDA,
    inout wire SCL,

    input SENSOR,
    output [7:0] DVI_RED,
    output [7:0] DVI_GREEN,
    output [7:0] DVI_BLUE,
    output DVI_DE,
    output DVI_HSYNC,
    output DVI_VSYNC,
    output DVI_CLOCK,

    output TFP410_reset,
    output LED
);
    wire internal_clock;
    wire pll_locked;
    wire tfp410_ready;
    wire hpd_detected;
    wire starttrigger;
    wire [7:0] config_data_crossed;

    reg [7:0] config_data;
    reg prev_sensor_input = 0 /* synthesis noprune */;
    reg sensor_input = 0 /* synthesis noprune */;
    VideoMode videoMode;
    
    localparam CLOCK_DIVIDER = 27;
    
    reg waiting;
    reg reset_counter;
    reg [8:0] counter;
    reg [24:0] raw_counter /* synthesis noprune */;
    reg counter_trigger = 0 /* synthesis noprune */;
    reg reset_bcdcounter = 0 /* synthesis noprune */;
    wire [23:0] bcdcount /* synthesis keep */;
    reg [23:0] bcdcount_out = 0 /* synthesis noprune */;
    wire [23:0] bcdcount_crossed /* synthesis keep */;

    always @(posedge clock) begin
        case (RES_CONFIG)
            3'b001: config_data <= `MODE_VGA;
            3'b011: config_data <= `MODE_VGA;
            3'b010: config_data <= `MODE_720p;
            3'b100: config_data <= `MODE_1080p;
            3'b110: config_data <= `MODE_1080p;
            default: config_data <= `MODE_VGA;
        endcase
        sensor_input <= ~SENSOR;
        prev_sensor_input <= sensor_input;
    end

    Flag_CrossDomain reset_control(
        .clkA(internal_clock),
        .FlagIn_clkA(starttrigger),
        .clkB(clock),
        .FlagOut_clkB(reset_counter)
    );

    /* 
        create trigger for the bcd counter,
        27MHz / 270, so trigger every 0.01 ms
    */
    always @(posedge clock) begin
        if (reset_counter) begin
            raw_counter <= 0;
            counter <= 0;
            counter_trigger <= 0;
            reset_bcdcounter <= 1;
        end else begin
            raw_counter <= raw_counter + 1'b1;
            reset_bcdcounter <= 0;
            if (counter < CLOCK_DIVIDER - 1) begin
                counter <= counter + 1'b1;
                counter_trigger <= 0;
            end else begin
                counter <= 0;
                counter_trigger <= 1;
            end
        end
    end

    bcdcounter bcdcounter(
        .trigger(counter_trigger),
        .reset(reset_bcdcounter),
        .bcdcount(bcdcount)
    );

    always @(posedge clock) begin
        if (reset_counter) begin
            waiting <= 1;
        end else if (waiting && ~prev_sensor_input && sensor_input) begin
            bcdcount_out <= bcdcount;
            waiting <= 0;
        end
    end

    ///////////////////////////////////////////
    // clocks
    pll_main pll(
        .clock(clock),
        .reset(1'b0),
        .data(config_data),

        .clock_out(internal_clock),
        .clock_out_video(DVI_CLOCK),
        .locked(pll_locked)
    );

    ///////////////////////////////////////////
    // video generator
    data_cross #(
        .WIDTH(8)
    ) video_data_cross (
        .clkIn(clock),
        .clkOut(internal_clock),
        .dataIn(config_data),
        .dataOut(config_data_crossed)
    );

    data_cross #(
        .WIDTH(24)
    ) bcdcounter_cross (
        .clkIn(clock),
        .clkOut(internal_clock),
        .dataIn(bcdcount_out),
        .dataOut(bcdcount_crossed)
    );

    video video(
        .clock(internal_clock),
        .config_data(config_data_crossed),
        .bcdcount(bcdcount_crossed),
        .red(DVI_RED),
        .green(DVI_GREEN),
        .blue(DVI_BLUE),
        .de(DVI_DE),
        .hsync(DVI_HSYNC),
        .vsync(DVI_VSYNC),
        .starttrigger(starttrigger)
    );
    ///////////////////////////////////////////

    ///////////////////////////////////////////
    // dvi transmitter
    TFP410 tfp410(
        .clk(clock),
        .reset(1'b1),
        .output_ready(pll_locked),
        .sda(SDA),
        .scl(SCL),
        .ready(tfp410_ready),
        .hpd_detected(hpd_detected)
    );
    ///////////////////////////////////////////

    assign LED = sensor_input;
    assign TFP410_reset = 1'b1;

endmodule