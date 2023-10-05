`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.09.2023 15:48:35
// Design Name: 
// Module Name: wptr_full
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


module wptr_full
    #(parameter ADDRSIZE = 4)
    (
    output reg wfull,
    output [ADDRSIZE-1:0] waddr,
    output reg [ADDRSIZE:0] wptr,
    input [ADDRSIZE:0] wq2_rptr,
    input winc,wclk,wrst_n
    );
    
    reg [ADDRSIZE:0] wbin;
    wire [ADDRSIZE:0] wgraynext,wbinnext;    
    wire [ADDRSIZE:0] wfull_val;
    always@(posedge wclk or negedge wrst_n) begin
        if(!wrst_n) {wbin, wptr} <= 0;
        else {wbin,wptr} <= {wbinnext,wgraynext}; // rptr value is converted to gray code.
    end
    
    assign waddr = wbin[ADDRSIZE-1:0];
    
    assign wbinnext = wbin + (winc & ~wfull); // whenever rinc is 1 and BRAM is not empty then rbin increases by 1
    assign wgraynext = (wbinnext>>1) ^ wbinnext; //conversion bin to gray
    
    assign wfull_val = ((wgraynext[ADDRSIZE] != wq2_rptr[ADDRSIZE]) &&
                        (wgraynext[ADDRSIZE-1] != wq2_rptr[ADDRSIZE-1]) &&
                        (wgraynext[ADDRSIZE-2:0] == wq2_rptr[ADDRSIZE-2:0])); // gray write and read vals compared
    
    always@(posedge wclk or negedge wrst_n) begin // if resetted fifo will be empty so full is 0
        if(!wrst_n) wfull <= 0;
        else wfull <= wfull_val;
    end
endmodule
