`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.09.2023 17:30:21
// Design Name: 
// Module Name: sync_r2w
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


module sync_r2w
    #(parameter ADDRSIZE = 4)(
    output reg [ADDRSIZE:0] wq2_rptr,
    input [ADDRSIZE:0] rptr,
    input wclk,wrst_n
    );
    
    reg [ADDRSIZE:0] wq1_rptr;
    
    always@(posedge wclk, negedge wrst_n) begin
        if(!wrst_n) begin
            {wq2_rptr,wq1_rptr} <= 0;
        end
        else begin
            {wq2_rptr,wq1_rptr}<={wq1_rptr,rptr};
        end
    end
endmodule
