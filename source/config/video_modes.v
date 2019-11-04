
`include "../defines.v"

const VideoMode VIDEO_MODE_VGA = {
    `MODE_VGA, // id
    12'd_800,   // h_total
    12'd_640,   // h_active
    12'd_16,    // h_front_porch
    12'd_96,    // h_sync
    12'd_48,    // h_back_porch
    1'b_0,      // h_sync_pol

    12'd_480,   // v_active
    12'd_10,    // v_front_porch
    12'd_2,     // v_sync

    12'd_525,   // v_total_1
    12'd_33,    // v_back_porch_1
    12'd_0,     // v_pxl_offset_1

    12'd_525,   // v_total_2
    12'd_33,    // v_back_porch_2
    12'd_0,     // v_pxl_offset_2

    1'b_0,      // v_sync_pol

    12'd_40,    // h_field_start
    12'd_200,   // h_field_end
    12'd_0,     // v_field1_start
    12'd_40,    // v_field1_end
    12'd_220,   // v_field2_start
    12'd_260,   // v_field2_end
    12'd_440,   // v_field3_start
    12'd_480,   // v_field3_end

    4'd_0,      // h_res_divider
    4'd_0,      // v_res_divider
    12'd_640 - `RESLINE_SIZE,   // h_res_start
    12'd16,     // v_res_end (16 << videoMode.v_res_divider)

    4'd_1,      // h_lag_divider
    4'd_1,      // v_lag_divider
    12'd_110,   // h_lag_start
    12'd_110 + `LL_END1, // h_lag_end1
    12'd_110 + `LL_END2, // h_lag_end2
    12'd_110 + `LL_END3, // h_lag_end3
    12'd_110 + `LL_END4, // h_lag_end4

    12'd_50,   // v_lag_start
    12'd_50 + (12'd_16 << 1),   // v_lag_line1
    12'd_50 + (12'd_32 << 1),   // v_lag_line2
    12'd_50 + (12'd_48 << 1),   // v_lag_line3
    12'd_50 + (12'd_64 << 1)    // v_lag_line4
};

const VideoMode VIDEO_MODE_480P60 = {
    `MODE_480p60, // id
    12'd_858,   // h_total
    12'd_720,   // h_active
    12'd_16,    // h_front_porch
    12'd_62,    // h_sync
    12'd_60,    // h_back_porch
    1'b_0,      // h_sync_pol

    12'd_480,   // v_active
    12'd_9,     // v_front_porch
    12'd_6,     // v_sync

    12'd_525,   // v_total_1
    12'd_30,    // v_back_porch_1
    12'd_0,     // v_pxl_offset_1

    12'd_525,   // v_total_2
    12'd_30,    // v_back_porch_2
    12'd_0,     // v_pxl_offset_2

    1'b_0,      // v_sync_pol

    12'd_40,    // h_field_start
    12'd_200,   // h_field_end
    12'd_0,     // v_field1_start
    12'd_40,    // v_field1_end
    12'd_220,   // v_field2_start
    12'd_260,   // v_field2_end
    12'd_440,   // v_field3_start
    12'd_480,   // v_field3_end

    4'd_0,      // h_res_divider
    4'd_0,      // v_res_divider
    12'd_720 - `RESLINE_SIZE,   // h_res_start
    12'd16,     // v_res_end (16 << videoMode.v_res_divider)

    4'd_1,      // h_lag_divider
    4'd_1,      // v_lag_divider
    12'd_110,   // h_lag_start
    12'd_110 + `LL_END1, // h_lag_end1
    12'd_110 + `LL_END2, // h_lag_end2
    12'd_110 + `LL_END3, // h_lag_end3
    12'd_110 + `LL_END4, // h_lag_end4

    12'd_50,   // v_lag_start
    12'd_50 + (12'd_16 << 1),   // v_lag_line1
    12'd_50 + (12'd_32 << 1),   // v_lag_line2
    12'd_50 + (12'd_48 << 1),   // v_lag_line3
    12'd_50 + (12'd_64 << 1)    // v_lag_line4
};

const VideoMode VIDEO_MODE_480I60 = {
    `MODE_480i60, // id
    12'd_1716,  // h_total
    12'd_1440,  // h_active
    12'd_38,    // h_front_porch
    12'd_124,   // h_sync
    12'd_114,   // h_back_porch
    1'b_0,      // h_sync_pol

    12'd_240,   // v_active
    12'd_4,     // v_front_porch
    12'd_3,     // v_sync

    12'd_262,   // v_total_1
    12'd_15,    // v_back_porch_1
    12'd_0,     // v_pxl_offset_1

    12'd_263,   // v_total_2
    12'd_16,    // v_back_porch_2
    12'd_858,   // v_pxl_offset_2

    1'b_0,      // v_sync_pol

    12'd_80,    // h_field_start
    12'd_400,   // h_field_end
    12'd_0,     // v_field1_start
    12'd_20,    // v_field1_end
    12'd_110,   // v_field2_start
    12'd_130,   // v_field2_end
    12'd_220,   // v_field3_start
    12'd_240,   // v_field3_end

    4'd_1,      // h_res_divider
    4'd_0,      // v_res_divider
    12'd_720 - `RESLINE_SIZE,   // h_res_start
    12'd16,     // v_res_end (16 << videoMode.v_res_divider)

    4'd_2,      // h_lag_divider
    4'd_0,      // v_lag_divider
    12'd_110,   // h_lag_start
    12'd_110 + `LL_END1, // h_lag_end1
    12'd_110 + `LL_END2, // h_lag_end2
    12'd_110 + `LL_END3, // h_lag_end3
    12'd_110 + `LL_END4, // h_lag_end4

    12'd_25,   // v_lag_start
    12'd_25 + (12'd_16 << 0),   // v_lag_line1
    12'd_25 + (12'd_32 << 0),   // v_lag_line2
    12'd_25 + (12'd_48 << 0),   // v_lag_line3
    12'd_25 + (12'd_64 << 0)    // v_lag_line4
};

const VideoMode VIDEO_MODE_240P60 = {
    `MODE_240p60, // id
    12'd_1716,  // h_total
    12'd_1440,  // h_active
    12'd_38,    // h_front_porch
    12'd_124,   // h_sync
    12'd_114,   // h_back_porch
    1'b_0,      // h_sync_pol

    12'd_240,   // v_active
    12'd_5,     // v_front_porch
    12'd_3,     // v_sync

    12'd_263,   // v_total_1
    12'd_15,    // v_back_porch_1
    12'd_0,     // v_pxl_offset_1

    12'd_263,   // v_total_2
    12'd_15,    // v_back_porch_2
    12'd_0,     // v_pxl_offset_2

    1'b_0,      // v_sync_pol

    12'd_80,    // h_field_start
    12'd_400,   // h_field_end
    12'd_0,     // v_field1_start
    12'd_20,    // v_field1_end
    12'd_110,   // v_field2_start
    12'd_130,   // v_field2_end
    12'd_220,   // v_field3_start
    12'd_240,   // v_field3_end

    4'd_1,      // h_res_divider
    4'd_0,      // v_res_divider
    12'd_720 - `RESLINE_SIZE, // h_res_start
    12'd16,     // v_res_end (16 << videoMode.v_res_divider)

    4'd_2,      // h_lag_divider
    4'd_0,      // v_lag_divider
    12'd_110,   // h_lag_start
    12'd_110 + `LL_END1, // h_lag_end1
    12'd_110 + `LL_END2, // h_lag_end2
    12'd_110 + `LL_END3, // h_lag_end3
    12'd_110 + `LL_END4, // h_lag_end4

    12'd_25,   // v_lag_start
    12'd_25 + (12'd_16 << 0),   // v_lag_line1
    12'd_25 + (12'd_32 << 0),   // v_lag_line2
    12'd_25 + (12'd_48 << 0),   // v_lag_line3
    12'd_25 + (12'd_64 << 0)    // v_lag_line4
};

const VideoMode VIDEO_MODE_720P60 = {
    `MODE_720p60,  // id
    12'd_1650,  // h_total
    12'd_1280,  // h_active
    12'd_110,   // h_front_porch
    12'd_40,    // h_sync
    12'd_220,   // h_back_porch
    1'b_1,      // h_sync_pol

    12'd_720,   // v_active
    12'd_5,     // v_front_porch
    12'd_5,     // v_sync

    12'd_750,   // v_total_1
    12'd_20,    // v_back_porch_1
    12'd_0,     // v_pxl_offset_1

    12'd_750,   // v_total_2
    12'd_20,    // v_back_porch_2
    12'd_0,     // v_pxl_offset_2

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
    12'd_640 - `RESLINE_SIZE,   // h_res_start
    12'd32,     // v_res_end (16 << videoMode.v_res_divider)

    4'd_2,      // h_lag_divider
    4'd_2,      // v_lag_divider
    12'd_110,   // h_lag_start
    12'd_110 + `LL_END1, // h_lag_end1
    12'd_110 + `LL_END2, // h_lag_end2
    12'd_110 + `LL_END3, // h_lag_end3
    12'd_110 + `LL_END4, // h_lag_end4

    12'd_60,   // v_lag_start
    12'd_60 + (12'd_16 << 2),   // v_lag_line1
    12'd_60 + (12'd_32 << 2),   // v_lag_line2
    12'd_60 + (12'd_48 << 2),   // v_lag_line3
    12'd_60 + (12'd_64 << 2)    // v_lag_line4
};

const VideoMode VIDEO_MODE_720P50 = {
    `MODE_720p50,  // id
    12'd_1980,  // h_total
    12'd_1280,  // h_active
    12'd_440,   // h_front_porch
    12'd_40,    // h_sync
    12'd_220,   // h_back_porch
    1'b_1,      // h_sync_pol

    12'd_720,   // v_active
    12'd_5,     // v_front_porch
    12'd_5,     // v_sync

    12'd_750,   // v_total_1
    12'd_20,    // v_back_porch_1
    12'd_0,     // v_pxl_offset_1

    12'd_750,   // v_total_2
    12'd_20,    // v_back_porch_2
    12'd_0,     // v_pxl_offset_2

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
    12'd_640 - `RESLINE_SIZE,   // h_res_start
    12'd32,     // v_res_end (16 << videoMode.v_res_divider)

    4'd_2,      // h_lag_divider
    4'd_2,      // v_lag_divider
    12'd_110,   // h_lag_start
    12'd_110 + `LL_END1, // h_lag_end1
    12'd_110 + `LL_END2, // h_lag_end2
    12'd_110 + `LL_END3, // h_lag_end3
    12'd_110 + `LL_END4, // h_lag_end4

    12'd_60,   // v_lag_start
    12'd_60 + (12'd_16 << 2),   // v_lag_line1
    12'd_60 + (12'd_32 << 2),   // v_lag_line2
    12'd_60 + (12'd_48 << 2),   // v_lag_line3
    12'd_60 + (12'd_64 << 2)    // v_lag_line4
};

const VideoMode VIDEO_MODE_1080P60 = {
    `MODE_1080p60, // id
    12'd_1100,  // h_total
    12'd_960,   // h_active
    12'd_44,    // h_front_porch
    12'd_22,    // h_sync
    12'd_74,    // h_back_porch
    1'b_1,      // h_sync_pol

    12'd_1080,  // v_active
    12'd_4,     // v_front_porch
    12'd_5,     // v_sync

    12'd_1125,  // v_total_1
    12'd_36,    // v_back_porch_1
    12'd_0,     // v_pxl_offset_1

    12'd_1125,  // v_total_2
    12'd_36,    // v_back_porch_2
    12'd_0,     // v_pxl_offset_2

    1'b_1,      // v_sync_pol

    12'd_60,    // h_field_start
    12'd_300,   // h_field_end
    12'd_0,     // v_field1_start
    12'd_90,    // v_field1_end
    12'd_495,   // v_field2_start
    12'd_585,   // v_field2_end
    12'd_990,   // v_field3_start
    12'd_1080,  // v_field3_end

    4'd_0,      // h_res_divider
    4'd_1,      // v_res_divider
    12'd_960 - `RESLINE_SIZE,   // h_res_start
    12'd32,     // v_res_end (16 << videoMode.v_res_divider)

    4'd_1,      // h_lag_divider
    4'd_2,      // v_lag_divider
    12'd_180,    // h_lag_start
    12'd_180 + `LL_END1, // h_lag_end1
    12'd_180 + `LL_END2, // h_lag_end2
    12'd_180 + `LL_END3, // h_lag_end3
    12'd_180 + `LL_END4, // h_lag_end4

    12'd_120,   // v_lag_start
    12'd_120 + (12'd_16 << 2),   // v_lag_line1
    12'd_120 + (12'd_32 << 2),   // v_lag_line2
    12'd_120 + (12'd_48 << 2),   // v_lag_line3
    12'd_120 + (12'd_64 << 2)    // v_lag_line4
};

const VideoMode VIDEO_MODE_1080P50 = {
    `MODE_1080p50, // id
    12'd_1320,  // h_total
    12'd_960,   // h_active
    12'd_264,   // h_front_porch
    12'd_22,    // h_sync
    12'd_74,    // h_back_porch
    1'b_1,      // h_sync_pol

    12'd_1080,  // v_active
    12'd_4,     // v_front_porch
    12'd_5,     // v_sync

    12'd_1125,  // v_total_1
    12'd_36,    // v_back_porch_1
    12'd_0,     // v_pxl_offset_1

    12'd_1125,  // v_total_2
    12'd_36,    // v_back_porch_2
    12'd_0,     // v_pxl_offset_2

    1'b_1,      // v_sync_pol

    12'd_60,    // h_field_start
    12'd_300,   // h_field_end
    12'd_0,     // v_field1_start
    12'd_90,    // v_field1_end
    12'd_495,   // v_field2_start
    12'd_585,   // v_field2_end
    12'd_990,   // v_field3_start
    12'd_1080,  // v_field3_end

    4'd_0,      // h_res_divider
    4'd_1,      // v_res_divider
    12'd_960 - `RESLINE_SIZE,   // h_res_start
    12'd32,     // v_res_end (16 << videoMode.v_res_divider)

    4'd_1,      // h_lag_divider
    4'd_2,      // v_lag_divider
    12'd_180,    // h_lag_start
    12'd_180 + `LL_END1, // h_lag_end1
    12'd_180 + `LL_END2, // h_lag_end2
    12'd_180 + `LL_END3, // h_lag_end3
    12'd_180 + `LL_END4, // h_lag_end4

    12'd_120,   // v_lag_start
    12'd_120 + (12'd_16 << 2),   // v_lag_line1
    12'd_120 + (12'd_32 << 2),   // v_lag_line2
    12'd_120 + (12'd_48 << 2),   // v_lag_line3
    12'd_120 + (12'd_64 << 2)    // v_lag_line4
};

const VideoMode VIDEO_MODE_1080I60 = {
    `MODE_1080i60, // id
    12'd_2200,  // h_total
    12'd_1920,  // h_active
    12'd_88,    // h_front_porch
    12'd_44,    // h_sync
    12'd_148,   // h_back_porch
    1'b_1,      // h_sync_pol

    12'd_540,   // v_active
    12'd_2,     // v_front_porch
    12'd_5,     // v_sync

    12'd_562,   // v_total_1
    12'd_15,    // v_back_porch_1
    12'd_0,     // v_pxl_offset_1

    12'd_563,   // v_total_2
    12'd_16,    // v_back_porch_2
    12'd_1100,  // v_pxl_offset_2

    1'b_1,      // v_sync_pol

    12'd_120,   // h_field_start
    12'd_600,   // h_field_end
    12'd_0,     // v_field1_start
    12'd_45,    // v_field1_end
    12'd_247,   // v_field2_start
    12'd_292,   // v_field2_end
    12'd_495,   // v_field3_start
    12'd_540,  // v_field3_end

    4'd_1,      // h_res_divider
    4'd_0,      // v_res_divider
    12'd_960 - `RESLINE_SIZE,   // h_res_start
    12'd16,     // v_res_end (16 << videoMode.v_res_divider)

    4'd_2,      // h_lag_divider
    4'd_1,      // v_lag_divider
    12'd_180,    // h_lag_start
    12'd_180 + `LL_END1, // h_lag_end1
    12'd_180 + `LL_END2, // h_lag_end2
    12'd_180 + `LL_END3, // h_lag_end3
    12'd_180 + `LL_END4, // h_lag_end4

    12'd_60,   // v_lag_start
    12'd_60 + (12'd_16 << 1),   // v_lag_line1
    12'd_60 + (12'd_32 << 1),   // v_lag_line2
    12'd_60 + (12'd_48 << 1),   // v_lag_line3
    12'd_60 + (12'd_64 << 1)    // v_lag_line4
};

const VideoMode VIDEO_MODE_1080I50 = {
    `MODE_1080i50, // id
    12'd_2640,  // h_total
    12'd_1920,  // h_active
    12'd_528,   // h_front_porch
    12'd_44,    // h_sync
    12'd_148,   // h_back_porch
    1'b_1,      // h_sync_pol

    12'd_540,   // v_active
    12'd_2,     // v_front_porch
    12'd_5,     // v_sync

    12'd_562,   // v_total_1
    12'd_15,    // v_back_porch_1
    12'd_0,     // v_pxl_offset_1

    12'd_563,   // v_total_2
    12'd_16,    // v_back_porch_2
    12'd_1320,  // v_pxl_offset_2

    1'b_1,      // v_sync_pol

    12'd_120,   // h_field_start
    12'd_600,   // h_field_end
    12'd_0,     // v_field1_start
    12'd_45,    // v_field1_end
    12'd_247,   // v_field2_start
    12'd_292,   // v_field2_end
    12'd_495,   // v_field3_start
    12'd_540,  // v_field3_end

    4'd_1,      // h_res_divider
    4'd_0,      // v_res_divider
    12'd_960 - `RESLINE_SIZE,   // h_res_start
    12'd16,     // v_res_end (16 << videoMode.v_res_divider)

    4'd_2,      // h_lag_divider
    4'd_1,      // v_lag_divider
    12'd_180,    // h_lag_start
    12'd_180 + `LL_END1, // h_lag_end1
    12'd_180 + `LL_END2, // h_lag_end2
    12'd_180 + `LL_END3, // h_lag_end3
    12'd_180 + `LL_END4, // h_lag_end4

    12'd_60,   // v_lag_start
    12'd_60 + (12'd_16 << 1),   // v_lag_line1
    12'd_60 + (12'd_32 << 1),   // v_lag_line2
    12'd_60 + (12'd_48 << 1),   // v_lag_line3
    12'd_60 + (12'd_64 << 1)    // v_lag_line4
};

const VideoMode VIDEO_MODE_960P60 = {
    `MODE_960p60, // id
    12'd_900,  // h_total
    12'd_640,   // h_active
    12'd_48,    // h_front_porch
    12'd_56,    // h_sync
    12'd_156,   // h_back_porch
    1'b_1,      // h_sync_pol

    12'd_960,   // v_active
    12'd_1,     // v_front_porch
    12'd_3,     // v_sync

    12'd_1000,  // v_total_1
    12'd_36,    // v_back_porch_1
    12'd_0,     // v_pxl_offset_1

    12'd_1000,  // v_total_2
    12'd_36,    // v_back_porch_2
    12'd_0,     // v_pxl_offset_2

    1'b_1,      // v_sync_pol

    12'd_40,    // h_field_start
    12'd_200,   // h_field_end
    12'd_0,     // v_field1_start
    12'd_80,    // v_field1_end
    12'd_440,   // v_field2_start
    12'd_520,   // v_field2_end
    12'd_880,   // v_field3_start
    12'd_960,   // v_field3_end

    4'd_0,      // h_res_divider
    4'd_1,      // v_res_divider
    12'd_640 - `RESLINE_SIZE, // h_res_start
    12'd32,     // v_res_end (16 << videoMode.v_res_divider)

    4'd_1,      // h_lag_divider
    4'd_2,      // v_lag_divider
    12'd_110,   // h_lag_start
    12'd_110 + `LL_END1, // h_lag_end1
    12'd_110 + `LL_END2, // h_lag_end2
    12'd_110 + `LL_END3, // h_lag_end3
    12'd_110 + `LL_END4, // h_lag_end4

    12'd_100,   // v_lag_start
    12'd_100 + (12'd_16 << 2),   // v_lag_line1
    12'd_100 + (12'd_32 << 2),   // v_lag_line2
    12'd_100 + (12'd_48 << 2),   // v_lag_line3
    12'd_100 + (12'd_64 << 2)    // v_lag_line4
};

const VideoMode VIDEO_MODE_576P50 = {
    `MODE_576p50, // id
    12'd_864,   // h_total
    12'd_720,   // h_active
    12'd_12,    // h_front_porch
    12'd_64,    // h_sync
    12'd_68,    // h_back_porch
    1'b_0,      // h_sync_pol

    12'd_576,   // v_active
    12'd_5,     // v_front_porch
    12'd_5,     // v_sync

    12'd_625,   // v_total_1
    12'd_39,    // v_back_porch_1
    12'd_0,     // v_pxl_offset_1

    12'd_625,   // v_total_2
    12'd_39,    // v_back_porch_2
    12'd_0,     // v_pxl_offset_2

    1'b_0,      // v_sync_pol

    12'd_40,    // h_field_start
    12'd_200,   // h_field_end
    12'd_0,     // v_field1_start
    12'd_48,    // v_field1_end
    12'd_264,   // v_field2_start
    12'd_312,   // v_field2_end
    12'd_528,   // v_field3_start
    12'd_576,   // v_field3_end

    4'd_0,      // h_res_divider
    4'd_0,      // v_res_divider
    12'd_720 - `RESLINE_SIZE,   // h_res_start
    12'd16,     // v_res_end (16 << videoMode.v_res_divider)

    4'd_1,      // h_lag_divider
    4'd_1,      // v_lag_divider
    12'd_110,   // h_lag_start
    12'd_110 + `LL_END1, // h_lag_end1
    12'd_110 + `LL_END2, // h_lag_end2
    12'd_110 + `LL_END3, // h_lag_end3
    12'd_110 + `LL_END4, // h_lag_end4

    12'd_50,   // v_lag_start
    12'd_50 + (12'd_16 << 1),   // v_lag_line1
    12'd_50 + (12'd_32 << 1),   // v_lag_line2
    12'd_50 + (12'd_48 << 1),   // v_lag_line3
    12'd_50 + (12'd_64 << 1)    // v_lag_line4
};

const VideoMode VIDEO_MODE_576I50 = {
    `MODE_576i50, // id
    12'd_1728,  // h_total
    12'd_1440,  // h_active
    12'd_24,    // h_front_porch
    12'd_126,   // h_sync
    12'd_138,   // h_back_porch
    1'b_0,      // h_sync_pol

    12'd_288,   // v_active
    12'd_2,     // v_front_porch
    12'd_3,     // v_sync

    12'd_312,   // v_total_1
    12'd_19,    // v_back_porch_1
    12'd_0,     // v_pxl_offset_1

    12'd_313,   // v_total_2
    12'd_20,    // v_back_porch_2
    12'd_864,   // v_pxl_offset_2

    1'b_0,      // v_sync_pol

    12'd_80,    // h_field_start
    12'd_400,   // h_field_end
    12'd_0,     // v_field1_start
    12'd_24,    // v_field1_end
    12'd_132,   // v_field2_start
    12'd_156,   // v_field2_end
    12'd_264,   // v_field3_start
    12'd_288,   // v_field3_end

    4'd_1,      // h_res_divider
    4'd_0,      // v_res_divider
    12'd_720 - `RESLINE_SIZE,   // h_res_start
    12'd16,     // v_res_end (16 << videoMode.v_res_divider)

    4'd_2,      // h_lag_divider
    4'd_0,      // v_lag_divider
    12'd_110,   // h_lag_start
    12'd_110 + `LL_END1, // h_lag_end1
    12'd_110 + `LL_END2, // h_lag_end2
    12'd_110 + `LL_END3, // h_lag_end3
    12'd_110 + `LL_END4, // h_lag_end4

    12'd_25,   // v_lag_start
    12'd_25 + (12'd_16 << 0),   // v_lag_line1
    12'd_25 + (12'd_32 << 0),   // v_lag_line2
    12'd_25 + (12'd_48 << 0),   // v_lag_line3
    12'd_25 + (12'd_64 << 0)    // v_lag_line4
};

const VideoMode VIDEO_MODE_288P50 = {
    `MODE_288p50, // id
    12'd_1728,  // h_total
    12'd_1440,  // h_active
    12'd_24,    // h_front_porch
    12'd_126,   // h_sync
    12'd_138,   // h_back_porch
    1'b_0,      // h_sync_pol

    12'd_288,   // v_active
    12'd_2,     // v_front_porch
    12'd_3,     // v_sync

    12'd_313,   // v_total_1
    12'd_19,    // v_back_porch_1
    12'd_0,     // v_pxl_offset_1

    12'd_313,   // v_total_2
    12'd_19,    // v_back_porch_2
    12'd_0,     // v_pxl_offset_2

    1'b_0,      // v_sync_pol

    12'd_80,    // h_field_start
    12'd_400,   // h_field_end
    12'd_0,     // v_field1_start
    12'd_24,    // v_field1_end
    12'd_132,   // v_field2_start
    12'd_156,   // v_field2_end
    12'd_264,   // v_field3_start
    12'd_288,   // v_field3_end

    4'd_1,      // h_res_divider
    4'd_0,      // v_res_divider
    12'd_720 - `RESLINE_SIZE,   // h_res_start
    12'd16,     // v_res_end (16 << videoMode.v_res_divider)

    4'd_2,      // h_lag_divider
    4'd_0,      // v_lag_divider
    12'd_110,   // h_lag_start
    12'd_110 + `LL_END1, // h_lag_end1
    12'd_110 + `LL_END2, // h_lag_end2
    12'd_110 + `LL_END3, // h_lag_end3
    12'd_110 + `LL_END4, // h_lag_end4

    12'd_25,   // v_lag_start
    12'd_25 + (12'd_16 << 0),   // v_lag_line1
    12'd_25 + (12'd_32 << 0),   // v_lag_line2
    12'd_25 + (12'd_48 << 0),   // v_lag_line3
    12'd_25 + (12'd_64 << 0)    // v_lag_line4
};

const VideoMode VIDEO_MODE_WUXGA = {
    `MODE_WUXGA, // id
    12'd_1040,  // h_total
    12'd_960,   // h_active
    12'd_24,    // h_front_porch
    12'd_16,    // h_sync
    12'd_40,    // h_back_porch
    1'b_1,      // h_sync_pol

    12'd_1200,  // v_active
    12'd_3,     // v_front_porch
    12'd_6,     // v_sync

    12'd_1235,  // v_total_1
    12'd_26,    // v_back_porch_1
    12'd_0,     // v_pxl_offset_1

    12'd_1235,  // v_total_2
    12'd_26,    // v_back_porch_2
    12'd_0,     // v_pxl_offset_2

    1'b_0,      // v_sync_pol

    12'd_60,    // h_field_start
    12'd_300,   // h_field_end
    12'd_0,     // v_field1_start
    12'd_90,    // v_field1_end
    12'd_555,   // v_field2_start
    12'd_645,   // v_field2_end
    12'd_1110,  // v_field3_start
    12'd_1200,  // v_field3_end

    4'd_0,      // h_res_divider
    4'd_1,      // v_res_divider
    12'd_960 - `RESLINE_SIZE,   // h_res_start
    12'd32,     // v_res_end (16 << videoMode.v_res_divider)

    4'd_1,      // h_lag_divider
    4'd_2,      // v_lag_divider
    12'd_180,    // h_lag_start
    12'd_180 + `LL_END1, // h_lag_end1
    12'd_180 + `LL_END2, // h_lag_end2
    12'd_180 + `LL_END3, // h_lag_end3
    12'd_180 + `LL_END4, // h_lag_end4

    12'd_125,   // v_lag_start
    12'd_125 + (12'd_16 << 2),   // v_lag_line1
    12'd_125 + (12'd_32 << 2),   // v_lag_line2
    12'd_125 + (12'd_48 << 2),   // v_lag_line3
    12'd_125 + (12'd_64 << 2)    // v_lag_line4
};

const VideoMode VIDEO_MODE_UXGA = {
    `MODE_UXGA, // id
    12'd_1080,  // h_total
    12'd_800,   // h_active
    12'd_32,    // h_front_porch
    12'd_96,    // h_sync
    12'd_152,    // h_back_porch
    1'b_1,      // h_sync_pol

    12'd_1200,  // v_active
    12'd_1,     // v_front_porch
    12'd_3,     // v_sync

    12'd_1250,  // v_total_1
    12'd_46,    // v_back_porch_1
    12'd_0,     // v_pxl_offset_1

    12'd_1250,  // v_total_2
    12'd_46,    // v_back_porch_2
    12'd_0,     // v_pxl_offset_2

    1'b_1,      // v_sync_pol

    12'd_50,    // h_field_start
    12'd_250,   // h_field_end
    12'd_0,     // v_field1_start
    12'd_90,    // v_field1_end
    12'd_555,   // v_field2_start
    12'd_645,   // v_field2_end
    12'd_1110,  // v_field3_start
    12'd_1200,  // v_field3_end

    4'd_0,      // h_res_divider
    4'd_1,      // v_res_divider
    12'd_800 - `RESLINE_SIZE,   // h_res_start
    12'd32,     // v_res_end (16 << videoMode.v_res_divider)

    4'd_1,      // h_lag_divider
    4'd_2,      // v_lag_divider
    12'd_150,    // h_lag_start
    12'd_150 + `LL_END1, // h_lag_end1
    12'd_150 + `LL_END2, // h_lag_end2
    12'd_150 + `LL_END3, // h_lag_end3
    12'd_150 + `LL_END4, // h_lag_end4

    12'd_125,   // v_lag_start
    12'd_125 + (12'd_16 << 2),   // v_lag_line1
    12'd_125 + (12'd_32 << 2),   // v_lag_line2
    12'd_125 + (12'd_48 << 2),   // v_lag_line3
    12'd_125 + (12'd_64 << 2)    // v_lag_line4
};

const VideoMode VIDEO_MODE_900P60 = {
    `MODE_900p60, // id
    12'd_900,   // h_total
    12'd_800,   // h_active
    12'd_12,    // h_front_porch
    12'd_40,    // h_sync
    12'd_48,    // h_back_porch
    1'b_1,      // h_sync_pol

    12'd_900,   // v_active
    12'd_1,     // v_front_porch
    12'd_3,     // v_sync

    12'd_1000,  // v_total_1
    12'd_96,    // v_back_porch_1
    12'd_0,     // v_pxl_offset_1

    12'd_1000,  // v_total_2
    12'd_96,    // v_back_porch_2
    12'd_0,     // v_pxl_offset_2

    1'b_1,      // v_sync_pol

    12'd_50,    // h_field_start
    12'd_250,   // h_field_end
    12'd_0,     // v_field1_start
    12'd_72,    // v_field1_end
    12'd_414,   // v_field2_start
    12'd_486,   // v_field2_end
    12'd_828,   // v_field3_start
    12'd_900,   // v_field3_end

    4'd_0,      // h_res_divider
    4'd_1,      // v_res_divider
    12'd_800 - `RESLINE_SIZE,   // h_res_start
    12'd32,     // v_res_end (16 << videoMode.v_res_divider)

    4'd_1,      // h_lag_divider
    4'd_2,      // v_lag_divider
    12'd_150,    // h_lag_start
    12'd_150 + `LL_END1, // h_lag_end1
    12'd_150 + `LL_END2, // h_lag_end2
    12'd_150 + `LL_END3, // h_lag_end3
    12'd_150 + `LL_END4, // h_lag_end4

    12'd_95,   // v_lag_start
    12'd_95 + (12'd_16 << 2),   // v_lag_line1
    12'd_95 + (12'd_32 << 2),   // v_lag_line2
    12'd_95 + (12'd_48 << 2),   // v_lag_line3
    12'd_95 + (12'd_64 << 2)    // v_lag_line4
};
