`timescale 1ns / 1ps
module tb_universal_code_converter;
reg  [3:0] data_in;
reg  [2:0] sel;
wire [7:0] data_out;

universal_code_converter uut (
    .data_in(data_in),
    .sel(sel),
    .data_out(data_out)
);

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1, tb_universal_code_converter);

    $display("Universal Code Converter");
    $display("-----------------------------------------");
    $display("Time | SEL | INPUT | OUTPUT    | Note");

    // 000: Binary to Gray (1010 -> 0000_1111)
    sel = 3'b000; data_in = 4'b1010; #10;
    $display("%3tns | %b | %b  | %b | Bin->Gray", $time, sel, data_in, data_out);

    // 001: Gray to Binary (1111 -> 0000_1010)
    sel = 3'b001; data_in = 4'b1111; #10;
    $display("%3tns | %b | %b  | %b | Gray->Bin", $time, sel, data_in, data_out);

    // 010: Binary to Excess-3 (0101 -> 0000_1000)
    sel = 3'b010; data_in = 4'b0101; #10;
    $display("%3tns | %b | %b  | %b | Bin->XS3", $time, sel, data_in, data_out);

    // 011: Excess-3 to Binary (1000 -> 0000_0101)
    sel = 3'b011; data_in = 4'b1000; #10;
    $display("%3tns | %b | %b  | %b | XS3->Bin", $time, sel, data_in, data_out);

    // 100: Binary to 2-Digit Packed BCD (1101 -> 0001_0011)
    sel = 3'b100; data_in = 4'b1101; #10;
    $display("%3tns | %b | %b  | %b | Bin->BCD (2-digit)", $time, sel, data_in, data_out);

    // 101: BCD to Binary (1001 -> 0000_1001)
    sel = 3'b101; data_in = 4'b1001; #10;
    $display("%3tns | %b | %b  | %b | BCD->Bin", $time, sel, data_in, data_out);

    // Edge cases: Invalid XS-3 (<0011) and Invalid BCD (>1001)
    sel = 3'b011; data_in = 4'b0001; #10;
    $display("%3tns | %b | %b  | %b | Invalid XS3 (8'hFF)", $time, sel, data_in, data_out);

    sel = 3'b101; data_in = 4'b1100; #10;
    $display("%3tns | %b | %b  | %b | Invalid BCD (8'hFF)", $time, sel, data_in, data_out);

    // Unused modes: 110 and 111 -> Default (00000000)
    sel = 3'b110; data_in = 4'b0111; #10;
    $display("%3tns | %b | %b  | %b | Default 110 (00)", $time, sel, data_in, data_out);

    sel = 3'b111; data_in = 4'b0111; #10;
    $display("%3tns | %b | %b  | %b | Default 111 (00)", $time, sel, data_in, data_out);

    $finish;
end
endmodule
