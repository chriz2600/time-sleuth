
module bcdcounter(
    input trigger,
    input reset,
    output [19:0] bcdcount
);

    reg [3:0] first;
    reg [3:0] second;
    reg [3:0] third;
    reg [3:0] fourth;
    reg [3:0] fifth;

    always @(posedge trigger or posedge reset) begin
        if (reset) begin
            first <= 0;
            second <= 0;
            third <= 0;
            fourth <= 0;
            fifth <= 0;
        end else if (first == 4'd9) begin // xxxx9 reached
            first <= 0;
            if (second == 4'd9) begin // xxx99 reached
                second <= 0;
                if (third == 4'd9) begin // xx999 reached
                    third <= 0;
                    if (fourth == 4'd9) begin // x9999 reached
                        fourth <= 0;
                        if (fifth == 4'd9) begin // 99999 reached
                            fifth <= 0;
                        end else begin
                            fifth <= fifth + 1'b1;
                        end
                    end else begin
                        fourth <= fourth + 1'b1;
                    end
                end else begin
                    third <= third + 1'b1;
                end
            end else begin
                second <= second + 1'b1;
            end
        end else begin
            first <= first + 1'b1;
        end
    end

    assign bcdcount = { fifth, fourth, third, second, first };
endmodule