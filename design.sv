`timescale 1ns / 1ps
module universal_code_converter (
    input  [3:0] data_in,
    input  [2:0] sel,
    output reg [7:0] data_out
);
always @(*) begin
    case (sel)
        // 000: Binary to Gray
        3'b000: begin
            data_out = {4'b0000, data_in ^ (data_in >> 1)};
        end
        // 001: Gray to Binary
        3'b001: begin
            data_out[3]   = data_in[3];
            data_out[2]   = data_out[3] ^ data_in[2];
            data_out[1]   = data_out[2] ^ data_in[1];
            data_out[0]   = data_out[1] ^ data_in[0];
            data_out[7:4] = 4'b0000;
        end
        // 010: Binary to Excess-3 (valid for 0000..1001)
        3'b010: begin
            if (data_in <= 4'b1001)
                data_out = {4'b0000, data_in + 4'b0011};
            else
                data_out = 8'b11111111;
        end
        // 011: Excess-3 to Binary (valid for 0011..1100)
        3'b011: begin
            if (data_in >= 4'b0011 && data_in <= 4'b1100)
                data_out = {4'b0000, data_in - 4'b0011};
            else
                data_out = 8'b11111111;
        end
        // 100: Binary to 2-Digit Packed BCD (0000..1111)
        3'b100: begin
            if (data_in >= 4'b1010)
                data_out = {4'b0001, data_in - 4'b1010};
            else
                data_out = {4'b0000, data_in};
        end
        // 101: BCD to Binary (valid for 0000..1001)
        3'b101: begin
            if (data_in <= 4'b1001)
                data_out = {4'b0000, data_in};
            else
                data_out = 8'b11111111;
        end
        // 110 & 111: Unused modes -> Default (00000000)
        3'b110,
        3'b111:  data_out = 8'b00000000;
        default: data_out = 8'b00000000;
    endcase
end
endmodule
