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
    wire internal_clock2;
    wire pll_locked;
    wire tfp410_ready;
    wire hpd_detected;
    wire starttrigger;
    wire [7:0] config_data_crossed;

    reg [7:0] prev_config_data;
    reg [7:0] config_data;
    reg prev_sensor_input = 0;
    reg sensor_input = 0;
    VideoMode videoMode;
    
    localparam CLOCK_DIVIDER = 27;
    localparam MAX_BCDCOUNT = 20'h_9_99_99;
    
    reg waiting;
    reg reset_counter;
    reg [8:0] counter;
    reg [24:0] raw_counter;
    reg counter_trigger = 0;
    reg reset_bcdcounter = 0;
    wire [23:0] bcdcount;
    reg [19:0] bcdcount_out = MAX_BCDCOUNT;
    reg [19:0] bcdcount_min = MAX_BCDCOUNT;
    reg [19:0] bcdcount_max = 0;
    wire [79:0] bcdcount_crossed;

    always @(posedge clock) begin
        prev_config_data <= config_data;
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
        27MHz / 27, so trigger every 0.001 ms
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

    ///////////////////////////////////////////////////////
    reg [19:0] avg_counter;
    reg [31:0] avg_counter_reg;
    reg [31:0] avg_counter_reg_avg;
    reg [23:0] avg_counter_bcd;
    reg [19:0] avg_counter_bcd_reg = MAX_BCDCOUNT;
    reg avg_counter_start;
    reg avg_counter_ready;
    reg [4:0] avg_loop;
    always @(posedge counter_trigger or posedge reset_bcdcounter) begin
        if (reset_bcdcounter) begin
            avg_counter <= 0;
        end else begin
            avg_counter <= avg_counter + 1'b1;
        end
    end

    Binary_to_BCD #(
        .INPUT_WIDTH(20),
        .DECIMAL_DIGITS(6)
    ) Binary_to_BCD (
        .i_Clock(clock),
        .i_Start(avg_counter_start),
        .i_Binary(avg_counter_reg_avg[19:0]),
        .o_BCD(avg_counter_bcd),
        .o_DV(avg_counter_ready)
    );
    ///////////////////////////////////////////////////////

    always @(posedge clock) begin
        if (reset_counter) begin
            waiting <= 1;
        end else if (prev_config_data != config_data) begin
            bcdcount_out <= MAX_BCDCOUNT;
            bcdcount_max <= 0;
            bcdcount_min <= MAX_BCDCOUNT;
            avg_counter_reg_avg <= 0;
            avg_counter_reg <= 0;
            avg_loop <= 0;
            avg_counter_bcd_reg <= MAX_BCDCOUNT;
        end else if (waiting && ~prev_sensor_input && sensor_input) begin
            bcdcount_out <= bcdcount[23:4];
            if (bcdcount[23:4] < bcdcount_min) begin
                bcdcount_min <= bcdcount[23:4];
            end
            if (bcdcount[23:4] > bcdcount_max) begin
                bcdcount_max <= bcdcount[23:4];
            end
            if (avg_counter != 0) begin
                if (avg_loop == 31) begin
                    avg_counter_reg_avg <= avg_counter_reg >> 5;
                    avg_counter_reg <= 0;
                    avg_loop <= 0;
                    avg_counter_start <= 1'b1;
                end else begin
                    avg_counter_reg <= avg_counter_reg + avg_counter;
                    avg_loop <= avg_loop + 1'b1;
                    avg_counter_start <= 1'b0;
                end
            end
            waiting <= 0;
        end
        if (avg_counter_ready) begin
            avg_counter_bcd_reg <= avg_counter_bcd[23:4];
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
        .WIDTH(80)
    ) bcdcounter_cross (
        .clkIn(clock),
        .clkOut(internal_clock),
        .dataIn({ avg_counter_bcd_reg, bcdcount_max, bcdcount_min, bcdcount_out }),
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