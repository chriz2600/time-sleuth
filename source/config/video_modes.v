
const VideoMode VIDEO_MODE_VGA = {
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
    1'b_0       // v_sync_pol
};

const VideoMode VIDEO_MODE_480P = {
    12'd_858,   // h_total
    12'd_720,   // h_active
    12'd_16,    // h_front_porch
    12'd_62,    // h_sync
    12'd_60,    // h_back_porch
    1'b_0,      // h_sync_pol
    12'd_525,   // v_total
    12'd_480,   // v_active
    12'd_9,     // v_front_porch
    12'd_6,     // v_sync
    12'd_30,    // v_back_porch
    1'b_0       // v_sync_pol
};

const VideoMode VIDEO_MODE_720P = {
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
    1'b_1       // v_sync_pol
};

const VideoMode VIDEO_MODE_1080P = {
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
    1'b_1       // v_sync_pol
};
