`include "../defines.v"

module textgen(
    input clock,
    input VideoMode videoMode,
    input [11:0] counterX,
    input [11:0] visible_counterX,
    input [11:0] visible_counterY,
    input [79:0] bcdcount,
    output [`RESLINE_SIZE-1:0] resolution_line,
    output reg [`LAGLINE_SIZE-1:0] lagdisplay_line_out
);
    wire [`LAGLINE_SIZE-1:0] lagdisplay_line;

    reg trigger_write_lag;
    reg [5:0] write_lag_counter;

    reg [3:0] resolution_addr;
    reg [3:0] lagdisplay_addr;

    reg [7:0] char_addr;
    reg [7:0] char_data;

    char_rom char_rom_inst(
        .clock(clock),
        .address(char_addr),
        .q(char_data)
    );

    resolution resolution(
        .clock(clock),
        .videoMode(videoMode),
        .addr(resolution_addr),
        .q(resolution_line)
    );

    lagdisplay lagdisplay(
        .clock(clock),
        .addr(lagdisplay_addr),
        .q(lagdisplay_line)
    );

    /* bcdcount */
    always @(posedge clock) begin
        case (counterX)
            0: begin
                // addr for resolution_line
                resolution_addr <= (visible_counterY + 1'b1 - videoMode.v_lag_start) >> videoMode.v_lag_divider;
                lagdisplay_addr <= (visible_counterY + 1'b1 - videoMode.v_lag_start) >> videoMode.v_lag_divider;
            end
            2: begin
                trigger_write_lag <= 1;
            end
            3: begin
                trigger_write_lag <= 0;
            end
        endcase
    end

    task idwc;
        begin
            write_lag_counter <= write_lag_counter + 1'b1;
        end
    endtask

    always @(posedge clock) begin
        if (trigger_write_lag) begin
            write_lag_counter <= 0;
        end else begin
            case (write_lag_counter)
                0: begin
                    lagdisplay_line_out <= lagdisplay_line;
                    idwc();
                end
                // bcdcount
                1: begin
                    if (bcdcount[19:0] == `MAX_BCDCOUNT) begin
                        write_lag_counter <= write_lag_counter + 6'd9;
                    end else begin
                        idwc();
                    end
                end
                2: begin
                    char_addr <= lagdisplay_addr + (bcdcount[3:0] << 4);
                    idwc();
                end
                3: begin
                    char_addr <= lagdisplay_addr + (bcdcount[7:4] << 4);
                    idwc();
                end
                4: begin
                    char_addr <= lagdisplay_addr + (bcdcount[11:8] << 4);
                    idwc();
                end
                5: begin
                    lagdisplay_line_out[7+`LL_END4+`LL_END3:0+`LL_END4+`LL_END3] <= char_data;
                    char_addr <= lagdisplay_addr + (bcdcount[15:12] << 4);
                    idwc();
                end
                6: begin
                    lagdisplay_line_out[15+`LL_END4+`LL_END3:8+`LL_END4+`LL_END3] <= char_data;
                    char_addr <= lagdisplay_addr + (bcdcount[19:16] << 4);
                    idwc();
                end
                7: begin
                    lagdisplay_line_out[31+`LL_END4+`LL_END3:24+`LL_END4+`LL_END3] <= char_data;
                    idwc();
                end
                8: begin
                    lagdisplay_line_out[39+`LL_END4+`LL_END3:32+`LL_END4+`LL_END3] <= char_data;
                    idwc();
                end
                9: begin
                    lagdisplay_line_out[47+`LL_END4+`LL_END3:40+`LL_END4+`LL_END3] <= char_data;
                    idwc();
                end
                // bcdcount_min
                10: begin
                    if (bcdcount[39:20] == `MAX_BCDCOUNT) begin
                        write_lag_counter <= write_lag_counter + 6'd9;
                    end else begin
                        idwc();
                    end
                end
                11: begin
                    char_addr <= lagdisplay_addr + (bcdcount[23:20] << 4);
                    idwc();
                end
                12: begin
                    char_addr <= lagdisplay_addr + (bcdcount[27:24] << 4);
                    idwc();
                end
                13: begin
                    char_addr <= lagdisplay_addr + (bcdcount[31:28] << 4);
                    idwc();
                end
                14: begin
                    lagdisplay_line_out[79+`LL_END4:72+`LL_END4] <= char_data;
                    char_addr <= lagdisplay_addr + (bcdcount[35:32] << 4);
                    idwc();
                end
                15: begin
                    lagdisplay_line_out[87+`LL_END4:80+`LL_END4] <= char_data;
                    char_addr <= lagdisplay_addr + (bcdcount[39:36] << 4);
                    idwc();
                end
                16: begin
                    lagdisplay_line_out[103+`LL_END4:96+`LL_END4] <= char_data;
                    idwc();
                end
                17: begin
                    lagdisplay_line_out[111+`LL_END4:104+`LL_END4] <= char_data;
                    idwc();
                end
                18: begin
                    lagdisplay_line_out[119+`LL_END4:112+`LL_END4] <= char_data;
                    idwc();
                end

                // bcdcount_max
                19: begin
                    if (bcdcount[59:40] == 0) begin
                        write_lag_counter <= write_lag_counter + 6'd9;
                    end else begin
                        idwc();
                    end
                end
                20: begin
                    char_addr <= lagdisplay_addr + (bcdcount[43:40] << 4);
                    idwc();
                end
                21: begin
                    char_addr <= lagdisplay_addr + (bcdcount[47:44] << 4);
                    idwc();
                end
                22: begin
                    char_addr <= lagdisplay_addr + (bcdcount[51:48] << 4);
                    idwc();
                end
                23: begin
                    lagdisplay_line_out[7+`LL_END4:0+`LL_END4] <= char_data;
                    char_addr <= lagdisplay_addr + (bcdcount[55:52] << 4);
                    idwc();
                end
                24: begin
                    lagdisplay_line_out[15+`LL_END4:8+`LL_END4] <= char_data;
                    char_addr <= lagdisplay_addr + (bcdcount[59:56] << 4);
                    idwc();
                end
                25: begin
                    lagdisplay_line_out[31+`LL_END4:24+`LL_END4] <= char_data;
                    idwc();
                end
                26: begin
                    lagdisplay_line_out[39+`LL_END4:32+`LL_END4] <= char_data;
                    idwc();
                end
                27: begin
                    lagdisplay_line_out[47+`LL_END4:40+`LL_END4] <= char_data;
                    idwc();
                end

                // avg_counter
                28: begin
                    if (bcdcount[79:60] == `MAX_BCDCOUNT) begin
                        write_lag_counter <= write_lag_counter + 6'd9;
                    end else begin
                        idwc();
                    end
                end
                29: begin
                    char_addr <= lagdisplay_addr + (bcdcount[63:60] << 4);
                    idwc();
                end
                30: begin
                    char_addr <= lagdisplay_addr + (bcdcount[67:64] << 4);
                    idwc();
                end
                31: begin
                    char_addr <= lagdisplay_addr + (bcdcount[71:68] << 4);
                    idwc();
                end
                32: begin
                    lagdisplay_line_out[7:0] <= char_data;
                    char_addr <= lagdisplay_addr + (bcdcount[75:72] << 4);
                    idwc();
                end
                33: begin
                    lagdisplay_line_out[15:8] <= char_data;
                    char_addr <= lagdisplay_addr + (bcdcount[79:76] << 4);
                    idwc();
                end
                34: begin
                    lagdisplay_line_out[31:24] <= char_data;
                    idwc();
                end
                35: begin
                    lagdisplay_line_out[39:32] <= char_data;
                    idwc();
                end
                36: begin
                    lagdisplay_line_out[47:40] <= char_data;
                    idwc();
                end
            endcase
        end
    end 
endmodule