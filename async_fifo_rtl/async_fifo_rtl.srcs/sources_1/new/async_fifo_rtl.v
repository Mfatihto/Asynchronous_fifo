`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.09.2023 16:45:54
// Design Name: 
// Module Name: async_fifo_rtl
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


module async_fifo_rtl
    #(parameter WRITE_WIDTH = 8, WRITE_DEPTH = 4)(
    input wclk, winc, wrst_n,
    input rclk, rinc, rrst_n,
    input [WRITE_WIDTH-1:0]wdata,
    output [WRITE_WIDTH-1:0]rdata,
    output wfull,
    output rempty
    );
    
    wire [WRITE_DEPTH-1:0] waddr,raddr;
    wire [WRITE_DEPTH:0] wptr,rptr,wq2_rptr,rq2_wptr;
    
    sync_r2w #(.ADDRSIZE(WRITE_DEPTH)) Sync_r2w
    (
    .wq2_rptr(wq2_rptr),
    .rptr(rptr),
    .wclk(wclk),
    .wrst_n(wrst_n)
    );
    
    sync_w2r #(.ADDRSIZE(WRITE_DEPTH)) Sync_w2r
    (
    .rq2_wptr(rq2_wptr),
    .wptr(wptr),
    .rclk(rclk),
    .rrst_n(rrst_n)
    );
    
    fifo_mem #(.DATASIZE(WRITE_WIDTH),.ADDRSIZE(WRITE_DEPTH)) Fifo_mem(
    .rdata(rdata),
    .wdata(wdata),
    .waddr(waddr),
    .raddr(raddr),
    .wclken(winc),
    .wfull(wfull),
    .wclk(wclk)
    );
    
    rptr_empty #(.ADDRSIZE(WRITE_DEPTH)) Rptr_empty
    (
    .rempty(rempty),
    .raddr(raddr),
    .rptr(rptr),
    .rq2_wptr(rq2_wptr),
    .rinc(rinc),
    .rclk(rclk),
    .rrst_n(rrst_n)
    );
    
    wptr_full #(.ADDRSIZE(WRITE_DEPTH)) Wptr_full
    (
    .wfull(wfull),
    .waddr(waddr),
    .wptr(wptr),
    .wq2_rptr(wq2_rptr),
    .winc(winc),
    .wclk(wclk),
    .wrst_n(wrst_n)
    );
endmodule
