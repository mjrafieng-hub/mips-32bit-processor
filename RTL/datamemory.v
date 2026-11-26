`timescale 1ns / 1ps

module DataMemory( 
    output [31:0] Read_data,
    input [31:0] Write_data,
    input [31:0] Address,
    input MemWrite, MemRead, clk
);

    reg [31:0] data_mem [255:0];

    always @(posedge clk) begin
        if (MemWrite) begin
            data_mem[Address[7:0]] <= Write_data;
        end
    end

    // خواندن ترکیبی برای معماری Single-Cycle
    assign Read_data = (MemRead) ? data_mem[Address[7:0]] : 32'b0;
     
endmodule
