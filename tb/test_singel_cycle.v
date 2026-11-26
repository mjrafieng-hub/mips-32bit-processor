`timescale 1ns / 1ps

module Test1;

    // Inputs
    reg clk;
    reg rst;

    // Outputs
    wire [31:0] inst;
    wire [31:0] pcout;
    wire [31:0] memory;

    // Instantiate the Unit Under Test (UUT)
    TopModule uut (
        .clk(clk), 
        .rst(rst), 
        .inst(inst), 
        .pcout(pcout), 
        .memory(memory)
    );

    // تولید پالس کلاک با دوره تناوب 20ns
    always #10 clk = ~clk;

    initial begin
        // مقداردهی اولیه و ریست
        clk = 0;
        rst = 1;
        #25;
        rst = 0; // آزاد کردن ریست بعد از اولین لبه مثبت کلاک
        
        #300;
        $finish;
    end
      
endmodule
