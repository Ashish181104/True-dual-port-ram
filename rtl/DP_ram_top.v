`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// College: MNNIT Allahabad
// Ashish Kumar Kashyap
// 
// Create Date: 23.05.2026
// Design Name: Industrial RAM Subsystem
// Module Name: industrial_ram_top
// Project Name: True Dual Port RAM
// Target Devices: Xilinx FPGA
// Tool Versions: Vivado 2023.x
// Description:
//
// Top module integrating:
// - AXI-style interface
// - True dual-port RAM
// - Collision detector
// - CDC synchronizers
//
// Revision:
// Revision 0.01 - File Created
//
//////////////////////////////////////////////////////////////////////////////////
module industrial_ram_top #

(
    parameter DATA_WIDTH = 32,
    parameter DEPTH      = 1024
)

(
    input clk_a,
    input rst_a,

    input clk_b,
    input rst_b,



    // ========================================================
    // PORT A
    // ========================================================

    input valid_a,
    input we_a,

    input [$clog2(DEPTH)-1:0] addr_a,
    input [DATA_WIDTH-1:0] din_a,

    output [DATA_WIDTH-1:0] dout_a,
    output ready_a,



    // ========================================================
    // PORT B
    // ========================================================

    input valid_b,
    input we_b,

    input [$clog2(DEPTH)-1:0] addr_b,
    input [DATA_WIDTH-1:0] din_b,

    output [DATA_WIDTH-1:0] dout_b,
    output ready_b,



    // ========================================================
    // STATUS
    // ========================================================

    output collision_flag
);



// ============================================================
// INTERNAL SIGNALS
// ============================================================

wire we_a_pipe;
wire we_b_pipe;

wire [$clog2(DEPTH)-1:0] addr_a_pipe;
wire [$clog2(DEPTH)-1:0] addr_b_pipe;

wire [DATA_WIDTH-1:0] din_a_pipe;
wire [DATA_WIDTH-1:0] din_b_pipe;



wire collision_raw;

wire collision_sync_a;
wire collision_sync_b;




// ============================================================
// INTERFACE BLOCK
// ============================================================

axi_style_interface #

(
    .DATA_WIDTH(DATA_WIDTH),
    .DEPTH(DEPTH)
)

interface_block

(
    .clk_a(clk_a),
    .rst_a(rst_a),

    .clk_b(clk_b),
    .rst_b(rst_b),

    .valid_a(valid_a),
    .we_a(we_a),

    .addr_a(addr_a),
    .din_a(din_a),

    .valid_b(valid_b),
    .we_b(we_b),

    .addr_b(addr_b),
    .din_b(din_b),

    .ready_a(ready_a),
    .ready_b(ready_b),

    .we_a_pipe(we_a_pipe),
    .we_b_pipe(we_b_pipe),

    .addr_a_pipe(addr_a_pipe),
    .addr_b_pipe(addr_b_pipe),

    .din_a_pipe(din_a_pipe),
    .din_b_pipe(din_b_pipe)
);




// ============================================================
// COLLISION DETECTOR
// ============================================================

collision_detector #

(
    .DEPTH(DEPTH)
)

collision_block

(
    .we_a(we_a_pipe),
    .we_b(we_b_pipe),

    .addr_a(addr_a_pipe),
    .addr_b(addr_b_pipe),

    .collision_flag(collision_raw)
);




// ============================================================
// CDC SYNCHRONIZERS
// ============================================================

cdc_synchronizer sync_collision_a
(
    .clk(clk_a),
    .rst(rst_a),

    .async_signal(collision_raw),

    .sync_signal(collision_sync_a)
);




cdc_synchronizer sync_collision_b
(
    .clk(clk_b),
    .rst(rst_b),

    .async_signal(collision_raw),

    .sync_signal(collision_sync_b)
);




// ============================================================
// MEMORY BLOCK
// ============================================================

true_dual_port_ram #

(
    .DATA_WIDTH(DATA_WIDTH),
    .DEPTH(DEPTH)
)

memory_block

(
    .clk_a(clk_a),
    .clk_b(clk_b),

    .we_a(we_a_pipe & ~collision_sync_a),
    .we_b(we_b_pipe & ~collision_sync_b),

    .addr_a(addr_a_pipe),
    .addr_b(addr_b_pipe),

    .din_a(din_a_pipe),
    .din_b(din_b_pipe),

    .dout_a(dout_a),
    .dout_b(dout_b)
);




// ============================================================
// STATUS
// ============================================================

assign collision_flag = collision_sync_a | collision_sync_b;

endmodule
