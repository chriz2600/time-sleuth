// 1080i 50Hz
case (addr)
00: q_reg <= 80'b_00000000000000000000000000000000000000000000000000000000000000000000000000000000;
01: q_reg <= 80'b_00000000000000000000000000000000000000000000000000000000000000000000000000000000;
02: q_reg <= 80'b_00011000001111000011110000111100000100000000000001111110001111000100001000000000;
03: q_reg <= 80'b_00101000010000100100001001000010000000000000000001000000010000100100001000000000;
04: q_reg <= 80'b_00001000010000100100001001000010000000000000000001000000010000100100001000000000;
05: q_reg <= 80'b_00001000010001100100001001000110001100000000000001000000010001100100001001111100;
06: q_reg <= 80'b_00001000010010100011110001001010000100000000000001111100010010100111111000000100;
07: q_reg <= 80'b_00001000010100100100001001010010000100000000000000000010010100100100001000000100;
08: q_reg <= 80'b_00001000011000100100001001100010000100000000000000000010011000100100001000001000;
09: q_reg <= 80'b_00001000010000100100001001000010000100000000000000000010010000100100001000010000;
10: q_reg <= 80'b_00001000010000100100001001000010000100000000000000000010010000100100001000100000;
11: q_reg <= 80'b_00001000010000100100001001000010000100000000000001000010010000100100001001000000;
12: q_reg <= 80'b_00111110001111000011110000111100001110000000000000111100001111000100001001111100;
13: q_reg <= 80'b_00000000000000000000000000000000000000000000000000000000000000000000000000000000;
14: q_reg <= 80'b_00000000000000000000000000000000000000000000000000000000000000000000000000000000;
15: q_reg <= 80'b_00000000000000000000000000000000000000000000000000000000000000000000000000000000;
endcase
