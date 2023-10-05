`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.09.2023 11:42:08
// Design Name: 
// Module Name: async_fifo_rtl_tb
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
//input wclk, winc, wrst_n,
//    input rclk, rinc, rrst_n,
//    input [WRITE_WIDTH-1:0]wdata,
//    output [WRITE_WIDTH-1:0]rdata,
//    output wfull,
//    output rempty,
//    input clear

module async_fifo_rtl_tb();
//    parameter WRITE_WIDTH = 8;
//    parameter WRITE_DEPTH = 4;
    reg wclk, winc, wrst_n;
    reg rclk, rinc, rrst_n;
    reg [8-1:0]wdata;
//    reg [8-1:0]rdata;
//    reg wfull;
//    reg rempty;

    
    async_fifo_rtl gate
    (
    .wclk(wclk),
    .winc(winc),
    .wrst_n(wrst_n),
    .rclk(rclk),
    .rinc(rinc),
    .rrst_n(rrst_n),
    .wdata(wdata)
//    .rdata(rdata),
//    .wfull(wfull),
//    .rempty(rempty),

    );
    
    parameter T=0.1;
    initial begin
    #150
    forever begin
        wclk = 1'b0;
        #(T);
        wclk = ~wclk;
        #(T);
    end end
    
    
    
    initial begin
    wdata = 8'd0;
    winc = 1;
    rinc = 1;
    wclk = 0;
    rclk = 0;
    wrst_n = 1;
    rrst_n = 1;
    #2
    wrst_n = 0;
    rrst_n = 0;
    #2
    wrst_n = 1;
    rrst_n = 1;
    
    #10;
    wdata = 8'd15;
    #3 wclk = 1;
    #3 wclk = 0;
    wdata = 8'd19;
    #3 wclk = 1;
    #3 wclk = 0;
    wdata = 8'd35;
    #3 wclk = 1;
    #3 wclk = 0;
    #10;
    #3 rclk = 1;
    #3 rclk = 0;
    #3 rclk = 1;
    #3 rclk = 0;
//    #3 r_clk_tb = 1;
//    #3 r_clk_tb = 0;
    #10;
    wdata = 8'd25;
    #3 wclk = 1;
    #3 wclk = 0;
    wdata = 8'd59;
    #3 wclk = 1;
    #3 wclk = 0;
    wdata = 8'd12;
    #3 wclk = 1;
    #3 wclk = 0;
    #10;
    #3 rclk = 1;
    #3 rclk = 0;
    #3 rclk = 1;
    #3 rclk = 0;
    #3 rclk = 1;
    #3 rclk = 0;
    #3 rclk = 1;
    #3 rclk = 0;
    #3 rclk = 1;
    #3 rclk = 0;
    #3 rclk = 1;
    #3 rclk = 0;
        wdata = 8'd25;
        repeat(12) @(posedge wclk);
    end
    
endmodule


