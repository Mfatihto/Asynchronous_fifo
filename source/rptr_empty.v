`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.09.2023 15:48:35
// Design Name: 
// Module Name: rptr_empty
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


module rptr_empty
    #(parameter ADDRSIZE = 4)
    (
    output reg rempty,
    output [ADDRSIZE-1:0] raddr,
    output reg [ADDRSIZE:0] rptr,
    input [ADDRSIZE:0] rq2_wptr,
    input rinc,rclk,rrst_n
    );
    
    reg [ADDRSIZE:0] rbin;
    wire [ADDRSIZE:0] rgraynext,rbinnext;    
    wire [ADDRSIZE:0] rempty_val;
    always@(posedge rclk or negedge rrst_n) begin
        if(!rrst_n) {rbin, rptr} <= 0;
        else {rbin,rptr} <= {rbinnext,rgraynext}; // rptr value is converted to gray code.
    end
    
    assign raddr = rbin[ADDRSIZE-1:0];
    
    assign rbinnext = rbin + (rinc & ~rempty); // whenever rinc is 1 and BRAM is not empty then rbin increases by 1
    assign rgraynext = (rbinnext>>1) ^ rbinnext; //conversion bin to gray
    
    assign rempty_val = (rgraynext == rq2_wptr); // gray write and read vals compared
    
    always@(posedge rclk or negedge rrst_n) begin // if resetted fifo will be empty so empty is 1
        if(!rrst_n) rempty <= 1;
        else rempty <= rempty_val;
    end
endmodule
