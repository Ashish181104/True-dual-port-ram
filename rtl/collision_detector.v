`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// college: MNNIT Allahabad
// Ashish Kumar Kashyap
// 
// Create Date: 23.05.2026
// Design Name: Industrial RAM Subsystem
// Module Name: collision_detector
// Project Name: True Dual Port RAM
// Target Devices: Xilinx FPGA
// Tool Versions: Vivado 2023.x
// Description:
//
// Detects simultaneous writes to same address.
//
// Revision:
// Revision 0.01 - File Created
//
//////////////////////////////////////////////////////////////////////////////////
module collision_detector #

(
    parameter DEPTH = 1024
)

(
    input we_a,
    input we_b,

    input [$clog2(DEPTH)-1:0] addr_a,
    input [$clog2(DEPTH)-1:0] addr_b,

    output reg collision_flag
);

always @(*)
begin

    collision_flag = 1'b0;



    // ========================================================
    // SAME ADDRESS WRITE COLLISION
    // ========================================================

    if(we_a && we_b && (addr_a == addr_b))
    begin

        collision_flag = 1'b1;
    end

end

endmodule
