`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// college: MNNIT Allahabad
// Ashish Kumar Kashyap
// 
// Create Date: 23.05.2026
// Design Name: Industrial RAM Subsystem
// Module Name: cdc_synchronizer
// Project Name: True Dual Port RAM
// Target Devices: Xilinx FPGA
// Tool Versions: Vivado 2023.x
// Description:
//
// Two-flop CDC synchronizer.
//
// Revision:
// Revision 0.01 - File Created
//
//////////////////////////////////////////////////////////////////////////////////

module cdc_synchronizer
(
    input clk,
    input rst,

    input async_signal,

    output reg sync_signal
);



// ============================================================
// ASYNC REGISTERS
// ============================================================

(* ASYNC_REG = "TRUE" *) reg sync_ff1;




// ============================================================
// 2-FLOP SYNCHRONIZER
// ============================================================

always @(posedge clk or posedge rst)
begin

    if(rst)
    begin

        sync_ff1    <= 1'b0;
        sync_signal <= 1'b0;
    end

    else
    begin

        sync_ff1    <= async_signal;
        sync_signal <= sync_ff1;
    end

end

endmodule
