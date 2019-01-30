
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

    4'd_0,      // res_divider
    12'd_600,   // h_res_start

    4'd_1,      // lag_divider
    12'd_40,    // h_lag_start
    12'd_152,   // h_lag_end
    12'd_82     // v_lag_start
};

// const VideoMode VIDEO_MODE_480P = {
//     `MODE_480p,  // id
//     12'd_858,   // h_total
//     12'd_720,   // h_active
//     12'd_16,    // h_front_porch
//     12'd_62,    // h_sync
//     12'd_60,    // h_back_porch
//     1'b_0,      // h_sync_pol
//     12'd_525,   // v_total
//     12'd_480,   // v_active
//     12'd_9,     // v_front_porch
//     12'd_6,     // v_sync
//     12'd_30,    // v_back_porch
//     1'b_0,      // v_sync_pol

//     12'd_40,    // h_field_start
//     12'd_200,   // h_field_end
//     12'd_0,     // v_field1_start
//     12'd_40,    // v_field1_end
//     12'd_220,   // v_field2_start
//     12'd_260,   // v_field2_end
//     12'd_440,   // v_field3_start
//     12'd_480,   // v_field3_end
//     4'd_0,      // res_divider
//     12'd_600,   // h_res_start
//     4'd_1,      // lag_divider
//     12'd_40,    // h_lag_start
//     12'd_152,   // h_lag_end
//     12'd_82     // v_lag_start
// };

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

    4'd_1,      // res_divider
    12'd_600,   // h_res_start

    4'd_2,      // lag_divider
    12'd_80,    // h_lag_start
    12'd_192,   // h_lag_end
    12'd_127    // v_lag_start
};

const VideoMode VIDEO_MODE_1080P = {
    `MODE_1080p, // id
    12'd_2200,  // h_total
    12'd_1920,  // h_active
    12'd_88,    // h_front_porch
    12'd_44,    // h_sync
    12'd_148,   // h_back_porch
    1'b_1,      // h_sync_pol
    12'd_1125,  // v_total
    12'd_1080,  // v_active
    12'd_4,     // v_front_porch
    12'd_5,     // v_sync
    12'd_36,    // v_back_porch
    1'b_1,      // v_sync_pol

    12'd_120,   // h_field_start
    12'd_600,   // h_field_end
    12'd_0,     // v_field1_start
    12'd_90,    // v_field1_end
    12'd_495,   // v_field2_start
    12'd_585,   // v_field2_end
    12'd_990,   // v_field3_start
    12'd_1080,  // v_field3_end

    4'd_1,      // res_divider
    12'd_920,   // h_res_start

    4'd_2,      // lag_divider
    12'd_30,    // h_lag_start (px / 4)
    12'd_142,   // h_lag_end
    12'd_240    // v_lag_start
};
