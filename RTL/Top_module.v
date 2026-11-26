`timescale 1ns / 1ps

module TopModule(
    input clk, rst,
    output reg [31:0] inst,
    output reg [31:0] pcout,
    output reg [31:0] memory
);

    wire [3:0] ALUOp;
    wire RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
    wire Zero, PCSrc;

    reg  [31:0] PC_out;
    wire [31:0] PC_in, PC_plus_1, Branch_Target, Jump_Address, Branch_Mux_Out;
    wire [31:0] Instruction;
    wire [4:0]  Write_register;
    wire [31:0] Read_data_1, Read_data_2, Write_data;
    wire [31:0] Sign_extend_out, ALU_in_2, ALU_result, Read_data;

    // 1. Instruction Memory
    InstructionMemory IM (
        .Read_address(PC_out),
        .Instruction(Instruction)
    );

    // 2. Control Unit
    ControlUnit CU (
        .opcode(Instruction[31:26]),
        .ALUOp(ALUOp),
        .Branch(Branch),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemtoReg(MemtoReg),
        .ALUSrc(ALUSrc),
        .RegDst(RegDst),
        .Jump(Jump)
    );

    assign Write_register = (RegDst) ? Instruction[15:11] : Instruction[20:16];

    // 3. Register File
    RegisterFile RF (
        .Read_data_1(Read_data_1),
        .Read_data_2(Read_data_2),
        .Write_data(Write_data),
        .Read_register_1(Instruction[25:21]),
        .Read_register_2(Instruction[20:16]),
        .Write_register(Write_register),
        .RegWrite(RegWrite),
        .clk(clk)
    );

    assign Sign_extend_out = {{16{Instruction[15]}}, Instruction[15:0]};
    assign ALU_in_2 = (ALUSrc) ? Sign_extend_out : Read_data_2;

    // 4. ALU
    ALU alu_unit (
        .ALUOp(ALUOp),
        .ALU_in_1(Read_data_1),
        .ALU_in_2(ALU_in_2),
        .funct(Instruction[5:0]),
        .Zero(Zero),
        .ALU_result(ALU_result)
    );

    // 5. Data Memory
    DataMemory DM (
        .Read_data(Read_data),
        .Write_data(Read_data_2),
        .Address(ALU_result),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .clk(clk)
    );

    assign Write_data = (MemtoReg) ? Read_data : ALU_result;
    and Branch_AND (PCSrc, Branch, Zero);

    assign PC_plus_1      = PC_out + 32'd1;
    assign Branch_Target  = PC_plus_1 + Sign_extend_out;
    assign Branch_Mux_Out = (PCSrc) ? Branch_Target : PC_plus_1;
    assign Jump_Address   = {PC_plus_1[31:26], Instruction[25:0]};
    assign PC_in          = (Jump) ? Jump_Address : Branch_Mux_Out;

    always @(posedge clk or posedge rst) begin
        if (rst)
            PC_out <= 32'b0;
        else
            PC_out <= PC_in;
    end

    always @(negedge clk) begin
        pcout  <= PC_out;
        memory <= Write_data;
        inst   <= Instruction;
    end

endmodule
