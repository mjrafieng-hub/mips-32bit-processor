`timescale 1ns / 1ps

module RegisterFile(
    output [31:0] Read_data_1, Read_data_2,
    input [31:0] Write_data,
    input [4:0] Read_register_1, Read_register_2, Write_register,
    input RegWrite, clk
);

    reg [31:0] registers [31:0];

    always @(posedge clk) begin
        if (RegWrite) begin
            if (Write_register != 5'b0)
                registers[Write_register] <= Write_data;
        end
    end
    
    assign Read_data_1 = (Read_register_1 == 5'b0) ? 32'b0 : registers[Read_register_1];
    assign Read_data_2 = (Read_register_2 == 5'b0) ? 32'b0 : registers[Read_register_2];
    
initial begin
    registers[0]  = 32'd0;
    registers[1]  = 32 me= 32'd5;
    registers[2]  = 32'd5;
    registers[10] = 32'd2; 
end


endmodule
