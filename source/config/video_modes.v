
`include "../defines.v"

const VideoMode VIDEO_MODE_VGA = {
    `MODE_VGA,   // id
    12'd_800,   // h_total
    12'd_640,   // h_active
    12'd_16,    // h_front_porch
    12'd_96,    // h_sync
    12'd_48,    // h_back_porch
    1'b_0,      // h_sync_pol
    12'd_525,   // v_total
    12'd_480,   // v_active
    12'd_10,    // v_front_porch
    12'd_2,     // v_sync
    12'd_33,    // v_back_porch
    1'b_0,       // v_sync_pol

    12'd_40,    // h_field_start
    12'd_200,   // h_field_end
    12'd_0,     // v_field1_start
    12'd_40,    // v_field1_end
    12'd_220,   // v_field2_start
    12'd_260,   // v_field2_end
    12'd_440,   // v_field3_start
    12'd_480,   // v_field3_end

    4'd_0,      // h_res_divider
    4'd_0,      // h_res_divider
    12'd_560,   // h_res_start

    4'd_1,      // h_lag_divider
    4'd_1,      // v_lag_divider
    12'd_20,    // h_lag_start
    12'd_300,   // h_lag_end
    12'd_84     // v_lag_start
};

const VideoMode VIDEO_MODE_720P = {
    `MODE_720p,  // id
    12'd_1650,  // h_total
    12'd_1280,  // h_active
    12'd_110,   // h_front_porch
    12'd_40,    // h_sync
    12'd_220,   // h_back_porch
    1'b_1,      // h_sync_pol
    12'd_750,   // v_total
    12'd_720,   // v_active
    12'd_5,     // v_front_porch
    12'd_5,     // v_sync
    12'd_20,    // v_back_porch
    1'b_1,      // v_sync_pol

    12'd_80,    // h_field_start
    12'd_400,   // h_field_end
    12'd_0,     // v_field1_start
    12'd_60,    // v_field1_end
    12'd_330,   // v_field2_start
    12'd_390,   // v_field2_end
    12'd_660,   // v_field3_start
    12'd_720,   // v_field3_end

    4'd_1,      // h_res_divider
    4'd_1,      // v_res_divider
    12'd_560,   // h_res_start

    4'd_2,      // h_lag_divider
    4'd_2,      // v_lag_divider
    12'd_20,    // h_lag_start
    12'd_300,   // h_lag_end
    12'd_142    // v_lag_start
};

const VideoMode VIDEO_MODE_1080P = {
    `MODE_1080p, // id
    12'd_1100,  // h_total
    12'd_960,   // h_active
    12'd_44,    // h_front_porch
    12'd_22,    // h_sync
    12'd_74,    // h_back_porch
    1'b_1,      // h_sync_pol
    12'd_1125,  // v_total
    12'd_1080,  // v_active
    12'd_4,     // v_front_porch
    12'd_5,     // v_sync
    12'd_36,    // v_back_porch
    1'b_1,      // v_sync_pol

    12'd_60,   // h_field_start
    12'd_300,   // h_field_end
    12'd_0,     // v_field1_start
    12'd_90,    // v_field1_end
    12'd_495,   // v_field2_start
    12'd_585,   // v_field2_end
    12'd_990,   // v_field3_start
    12'd_1080,  // v_field3_end

    4'd_0,      // h_res_divider
    4'd_1,      // v_res_divider
    12'd_880,   // h_res_start

    4'd_1,      // h_lag_divider
    4'd_2,      // v_lag_divider
    12'd_30,    // h_lag_start (px / 4)
    12'd_310,   // h_lag_end
    12'd_240    // v_lag_start
};
