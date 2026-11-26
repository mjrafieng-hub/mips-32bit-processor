`timescale 1ns / 1ps

module ALU (
    input [3:0] ALUOp,
    input [31:0] ALU_in_1, ALU_in_2,
    input [5:0] funct,
    output reg Zero,
    output reg [31:0] ALU_result
);

    always @(*) begin
        Zero = 1'b0;
        ALU_result = 32'b0;
        
        if (ALUOp == 4'b0000) begin
            case (funct)
                6'b000000: ALU_result = ALU_in_1 & ALU_in_2;
                6'b000001: ALU_result = ALU_in_1 | ALU_in_2;
                6'b000010: ALU_result = ALU_in_1 + ALU_in_2;
                6'b000011: ALU_result = ALU_in_1 >> ALU_in_2;
                6'b000100: ALU_result = ALU_in_1 << ALU_in_2;
                6'b100001: ALU_result = ALU_in_1 - ALU_in_2;
                6'b000110: ALU_result = (ALU_in_1 < ALU_in_2) ? 32'd1 : 32'd0;
                default:   ALU_result = 32'b0;
            endcase
        end
        else if (ALUOp == 4'b0001) ALU_result = ALU_in_1 + ALU_in_2; // addi
        else if (ALUOp == 4'b0010) ALU_result = ALU_in_1 & ALU_in_2; // andi
        else if (ALUOp == 4'b0011) ALU_result = ALU_in_1 | ALU_in_2; // ori
        else if (ALUOp == 4'b0100) ALU_result = (ALU_in_1 < ALU_in_2) ? 32'd1 : 32'd0; // slti
        else if (ALUOp == 4'b0101) ALU_result = ALU_in_1 + ALU_in_2; // lw
        else if (ALUOp == 4'b0110) ALU_result = ALU_in_1 + ALU_in_2; // sw
        else if (ALUOp == 4'b0111) Zero = (ALU_in_1 == ALU_in_2) ? 1'b1 : 1'b0; // beq
        else if (ALUOp == 4'b1000) Zero = (ALU_in_1 != ALU_in_2) ? 1'b1 : 1'b0; // bne
        else                       ALU_result = 32'b0;
    end

endmodule
