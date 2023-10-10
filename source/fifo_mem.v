`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.09.2023 17:49:25
// Design Name: 
// Module Name: fifo_mem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fifo_mem
    #(parameter DATASIZE = 8, ADDRSIZE = 4)(
    output [DATASIZE-1:0] rdata,
    input [DATASIZE-1:0] wdata,
    input [ADDRSIZE-1:0] waddr,raddr,
    input wclken,wfull,wclk
    );
    
    reg [DATASIZE-1:0] mem [0:(2**ADDRSIZE)-1];
    
    assign rdata = mem[raddr];
    
    always@(posedge wclk) begin
        if(wclken && !wfull) begin
            mem[waddr] <= wdata;
        end
        else mem[waddr] <= mem[waddr];
    end
    
endmodule
