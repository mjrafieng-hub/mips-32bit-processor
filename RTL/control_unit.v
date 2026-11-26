`timescale 1ns / 1ps

module ControlUnit(
    input [5:0] opcode,
    output [3:0] ALUOp,
    output Branch, RegWrite, MemRead, MemWrite, MemtoReg, ALUSrc, RegDst, Jump
);
    
    reg [11:0] Control_Signal;
    
    always @(*) begin
        case (opcode)
            6'b000000 : Control_Signal = 12'b000001000010; // R-type
            6'b000001 : Control_Signal = 12'b000101000100; // addi
            6'b000010 : Control_Signal = 12'b001001000100; // andi
            6'b000011 : Control_Signal = 12'b001101000100; // ori
            6'b000100 : Control_Signal = 12'b010001000100; // slti
            6'b000101 : Control_Signal = 12'b010101101100; // lw 
            6'b000110 : Control_Signal = 12'b011000010100; // sw
            6'b000111 : Control_Signal = 12'b011110000100; // beq
            6'b001000 : Control_Signal = 12'b100010000100; // bne
            6'b001001 : Control_Signal = 12'b100100000001; // j
            default   : Control_Signal = 12'b000000000000;
        endcase
    end

    assign {ALUOp, Branch, RegWrite, MemRead, MemWrite, MemtoReg, ALUSrc, RegDst, Jump} = Control_Signal;

endmodule
