typedef struct packed {
    reg [11:0] h_total;
    reg [11:0] h_active;
    reg [11:0] h_front_porch;
    reg [11:0] h_sync;
    reg [11:0] h_back_porch;
    reg h_sync_pol;

    reg [11:0] v_total;
    reg [11:0] v_active;
    reg [11:0] v_front_porch;
    reg [11:0] v_sync;
    reg [11:0] v_back_porch;
    reg v_sync_pol;

    reg [11:0] h_field_start;
    reg [11:0] h_field_end;

    reg [11:0] v_field1_start;
    reg [11:0] v_field1_end;

    reg [11:0] v_field2_start;
    reg [11:0] v_field2_end;

    reg [11:0] v_field3_start;
    reg [11:0] v_field3_end;
} VideoMode;

