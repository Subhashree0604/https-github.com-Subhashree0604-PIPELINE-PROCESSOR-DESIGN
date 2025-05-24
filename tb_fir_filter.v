`timescale 1ns/1ps
module tb_fir_filter;

    reg clk;
    reg reset;
    reg signed [15:0] x_in;
    wire signed [31:0] y_out;

    fir_filter uut (
        .clk(clk),
        .reset(reset),
        .x_in(x_in),
        .y_out(y_out)
    );

    initial begin
        $dumpfile("fir_wave.vcd");
        $dumpvars(0, tb_fir_filter);

        clk = 0;
        reset = 1;
        x_in = 0;
        #20;
        reset = 0;

        // Apply input samples
        x_in = 16'd1; #10;
        x_in = 16'd2; #10;
        x_in = 16'd3; #10;
        x_in = 16'd4; #10;
        x_in = 16'd5; #10;
        x_in = 16'd6; #10;
        x_in = 16'd7; #10;
        x_in = 16'd8; #10;
        x_in = 16'd0; #100;

        $finish;
    end

    always #5 clk = ~clk;

endmodule
