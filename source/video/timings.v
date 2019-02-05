module timings(
    input clock,
    input VideoMode videoMode,
    output reg [11:0] counterX,
    output reg [11:0] counterY,
    output reg [11:0] visible_counterX,
    output reg [11:0] visible_counterY,
    output reg hsync,
    output reg vsync,
    output reg de
);
    /*
        H_SYNC  H_BACK_PORCH  H_ACTIVE H_FRONT_PORCH
        V_SYNC  V_BACK_PORCH  V_ACTIVE V_FRONT_PORCH
    */

    /* generate counter */
    always @(posedge clock) begin
        if (counterX < videoMode.h_total - 1) begin
            counterX <= counterX + 1'b1;
        end else begin
            counterX <= 0;
            if (counterY < videoMode.v_total - 1) begin
                counterY <= counterY + 1'b1;
            end else begin
                counterY <= 0;
            end
        end
    end 

    /* generate visible area timings */
    always @(posedge clock) begin
        visible_counterX <= counterX + 1'b1 - (videoMode.h_sync + videoMode.h_back_porch);
        visible_counterY <= counterY - (videoMode.v_sync + videoMode.v_back_porch);
    end

    /* generate hsync */
    always @(posedge clock) begin
        if (counterX < videoMode.h_sync) begin
            hsync <= videoMode.h_sync_pol;
        end else begin
            hsync <= ~videoMode.h_sync_pol;
        end
    end

    /* generate vsync */
    always @(posedge clock) begin
        if (counterY < videoMode.v_sync) begin
            vsync <= videoMode.v_sync_pol;
        end else begin
            vsync <= ~videoMode.v_sync_pol;
        end
    end

    /* generate DE */
    always @(posedge clock) begin
        if (counterX >= videoMode.h_sync + videoMode.h_back_porch
         && counterY >= videoMode.v_sync + videoMode.v_back_porch
         && counterX < videoMode.h_sync + videoMode.h_back_porch + videoMode.h_active
         && counterY < videoMode.v_sync + videoMode.v_back_porch + videoMode.v_active)
        begin
            de <= 1'b1;
        end else begin
            de <= 0;
        end
    end
endmodule