`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: MNNIT Allahabad
// Engineer: Ashish Kumar Kashyap
// 
// Create Date: 23.05.2026
// Design Name: Industrial RAM Subsystem
// Module Name: true_dual_port_ram
// Project Name: True Dual Port RAM
// Target Devices: Xilinx FPGA
// Tool Versions: Vivado 2023.x
// Description:
//
// Asynchronous true dual-port RAM.
//
// Features:
// - Independent read/write ports
// - Write-first mode
// - BRAM inference
//
// Revision:
// Revision 0.01 - File Created
//
//////////////////////////////////////////////////////////////////////////////////

module true_dual_port_ram #

(
    parameter DATA_WIDTH = 32,
    parameter DEPTH      = 1024
)

(
    input clk_a,
    input clk_b,



    // ========================================================
    // PORT A
    // ========================================================

    input we_a,

    input [$clog2(DEPTH)-1:0] addr_a,
    input [DATA_WIDTH-1:0] din_a,

    output reg [DATA_WIDTH-1:0] dout_a,



    // ========================================================
    // PORT B
    // ========================================================

    input we_b,

    input [$clog2(DEPTH)-1:0] addr_b,
    input [DATA_WIDTH-1:0] din_b,

    output reg [DATA_WIDTH-1:0] dout_b
);




// ============================================================
// MEMORY ARRAY
// ============================================================

(* ram_style = "block" *)
reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];




// ============================================================
// PORT A LOGIC
// ============================================================

always @(posedge clk_a)
begin

    if(we_a)
    begin

        mem[addr_a] <= din_a;

        // WRITE-FIRST MODE

        dout_a <= din_a;

    end

    else
    begin

        dout_a <= mem[addr_a];

    end

end




// ============================================================
// PORT B LOGIC
// ============================================================

always @(posedge clk_b)
begin

    if(we_b)
    begin

        mem[addr_b] <= din_b;

        // WRITE-FIRST MODE

        dout_b <= din_b;

    end

    else
    begin

        dout_b <= mem[addr_b];

    end

end

endmodule