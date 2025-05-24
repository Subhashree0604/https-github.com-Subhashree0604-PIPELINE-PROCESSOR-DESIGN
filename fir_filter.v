module fir_filter(
    input clk,
    input reset,
    input signed [15:0] x_in,
    output reg signed [31:0] y_out
);
    parameter N = 4;

    reg signed [15:0] h [0:N-1];
    reg signed [15:0] shift_reg [0:N-1];
    integer i;

    initial begin
        // Example coefficients: h = [1, 2, 3, 4]
        h[0] = 16'sd1;
        h[1] = 16'sd2;
        h[2] = 16'sd3;
        h[3] = 16'sd4;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            y_out <= 0;
            for (i = 0; i < N; i = i + 1)
                shift_reg[i] <= 0;
        end else begin
            // Shift input samples
            for (i = N-1; i > 0; i = i - 1)
                shift_reg[i] <= shift_reg[i-1];
            shift_reg[0] <= x_in;

            // Compute FIR output
            y_out <= 0;
            for (i = 0; i < N; i = i + 1)
                y_out <= y_out + shift_reg[i] * h[i];
        end
    end
endmodule
