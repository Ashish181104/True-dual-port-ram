`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// college: MNNIT Allahabad
// Engineer: Ashish Kumar Kashyap
// 
// Create Date: 23.05.2026
// Design Name: Industrial RAM Subsystem
// Module Name: tb_industrial_ram_top
// Project Name: True Dual Port RAM
// Target Devices: Xilinx FPGA
// Tool Versions: Vivado 2023.x
// Description:
//
// Testbench for industrial RAM subsystem.
//
// Tests:
// - Read/Write operations
// - Collision testing
// - Handshake verification
// - Random traffic
//
// Revision:
// Revision 0.01 - File Created
//
//////////////////////////////////////////////////////////////////////////////////

module tb_industrial_ram_top;



// ============================================================
// PARAMETERS
// ============================================================

parameter DATA_WIDTH = 32;
parameter DEPTH      = 1024;




// ============================================================
// CLOCKS
// ============================================================

reg clk_a;
reg clk_b;




// ============================================================
// RESETS
// ============================================================

reg rst_a;
reg rst_b;




// ============================================================
// PORT A SIGNALS
// ============================================================

reg valid_a;
reg we_a;

reg [$clog2(DEPTH)-1:0] addr_a;
reg [DATA_WIDTH-1:0] din_a;

wire [DATA_WIDTH-1:0] dout_a;
wire ready_a;




// ============================================================
// PORT B SIGNALS
// ============================================================

reg valid_b;
reg we_b;

reg [$clog2(DEPTH)-1:0] addr_b;
reg [DATA_WIDTH-1:0] din_b;

wire [DATA_WIDTH-1:0] dout_b;
wire ready_b;




// ============================================================
// STATUS
// ============================================================

wire collision_flag;




// ============================================================
// DUT
// ============================================================

industrial_ram_top #

(
    .DATA_WIDTH(DATA_WIDTH),
    .DEPTH(DEPTH)
)

dut

(
    .clk_a(clk_a),
    .rst_a(rst_a),

    .clk_b(clk_b),
    .rst_b(rst_b),

    // ========================================================
    // PORT A
    // ========================================================

    .valid_a(valid_a),
    .we_a(we_a),

    .addr_a(addr_a),
    .din_a(din_a),

    .dout_a(dout_a),
    .ready_a(ready_a),



    // ========================================================
    // PORT B
    // ========================================================

    .valid_b(valid_b),
    .we_b(we_b),

    .addr_b(addr_b),
    .din_b(din_b),

    .dout_b(dout_b),
    .ready_b(ready_b),



    // ========================================================
    // STATUS
    // ========================================================

    .collision_flag(collision_flag)
);




// ============================================================
// CLOCK A
// ============================================================

initial
begin

    clk_a = 0;

    forever #5 clk_a = ~clk_a;

end




// ============================================================
// CLOCK B
// ============================================================

initial
begin

    clk_b = 0;

    forever #7 clk_b = ~clk_b;

end




// ============================================================
// MAIN TEST
// ============================================================

initial
begin

    // ========================================================
    // INITIAL VALUES
    // ========================================================

    rst_a = 1'b1;
    rst_b = 1'b1;

    valid_a = 1'b0;
    valid_b = 1'b0;

    we_a = 1'b0;
    we_b = 1'b0;

    addr_a = 0;
    addr_b = 0;

    din_a = 0;
    din_b = 0;



    // ========================================================
    // RESET PHASE
    // ========================================================

    #40;

    rst_a = 1'b0;
    rst_b = 1'b0;

    $display("=======================================");
    $display("RESET RELEASED");
    $display("=======================================");




    // ========================================================
    // PORT A WRITE
    // ========================================================

    @(posedge clk_a);

    if(ready_a)
    begin

        valid_a <= 1'b1;
        we_a    <= 1'b1;

        addr_a  <= 10'd15;
        din_a   <= 32'hAAAA1111;

        $display("PORT A WRITE STARTED");
    end



    @(posedge clk_a);

    valid_a <= 1'b0;
    we_a    <= 1'b0;




    // ========================================================
    // PORT B WRITE
    // ========================================================

    @(posedge clk_b);

    if(ready_b)
    begin

        valid_b <= 1'b1;
        we_b    <= 1'b1;

        addr_b  <= 10'd20;
        din_b   <= 32'hBBBB2222;

        $display("PORT B WRITE STARTED");
    end



    @(posedge clk_b);

    valid_b <= 1'b0;
    we_b    <= 1'b0;




    // ========================================================
    // WAIT
    // ========================================================

    #80;




    // ========================================================
    // PORT A READ
    // ========================================================

    @(posedge clk_a);

    if(ready_a)
    begin

        valid_a <= 1'b1;
        we_a    <= 1'b0;

        addr_a  <= 10'd15;

        $display("PORT A READ STARTED");
    end



    @(posedge clk_a);

    valid_a <= 1'b0;




    // ========================================================
    // PORT B READ
    // ========================================================

    @(posedge clk_b);

    if(ready_b)
    begin

        valid_b <= 1'b1;
        we_b    <= 1'b0;

        addr_b  <= 10'd20;

        $display("PORT B READ STARTED");
    end



    @(posedge clk_b);

    valid_b <= 1'b0;




    // ========================================================
    // WAIT FOR READ
    // ========================================================

    #80;

    $display("=======================================");
    $display("READ RESULTS");
    $display("=======================================");

    $display("PORT A DATA = %h", dout_a);
    $display("PORT B DATA = %h", dout_b);




    // ========================================================
    // COLLISION TEST
    // ========================================================

    $display("=======================================");
    $display("COLLISION TEST STARTED");
    $display("=======================================");




    fork

        begin

            @(posedge clk_a);

            if(ready_a)
            begin

                valid_a <= 1'b1;
                we_a    <= 1'b1;

                addr_a  <= 10'd50;
                din_a   <= 32'h11111111;
            end

        end



        begin

            @(posedge clk_b);

            if(ready_b)
            begin

                valid_b <= 1'b1;
                we_b    <= 1'b1;

                addr_b  <= 10'd50;
                din_b   <= 32'h22222222;
            end

        end

    join




    // ========================================================
    // WAIT
    // ========================================================

    #80;




    // ========================================================
    // COLLISION RESULT
    // ========================================================

    if(collision_flag)

        $display("COLLISION DETECTED");

    else

        $display("NO COLLISION DETECTED");




    // ========================================================
    // STOP WRITES
    // ========================================================

    @(posedge clk_a);

    valid_a <= 1'b0;
    we_a    <= 1'b0;



    @(posedge clk_b);

    valid_b <= 1'b0;
    we_b    <= 1'b0;




    // ========================================================
    // FINAL READBACK
    // ========================================================

    @(posedge clk_a);

    if(ready_a)
    begin

        valid_a <= 1'b1;
        we_a    <= 1'b0;

        addr_a  <= 10'd50;
    end



    @(posedge clk_b);

    if(ready_b)
    begin

        valid_b <= 1'b1;
        we_b    <= 1'b0;

        addr_b  <= 10'd50;
    end




    #100;

    $display("=======================================");
    $display("FINAL MEMORY VALUES");
    $display("=======================================");

    $display("PORT A FINAL DATA = %h", dout_a);
    $display("PORT B FINAL DATA = %h", dout_b);




    // ========================================================
    // RANDOM TRAFFIC
    // ========================================================

    repeat(10)
    begin

        @(posedge clk_a);

        if(ready_a)
        begin

            valid_a <= 1'b1;

            we_a    <= $random;

            addr_a  <= $random % DEPTH;

            din_a   <= $random;
        end

    end




    repeat(10)
    begin

        @(posedge clk_b);

        if(ready_b)
        begin

            valid_b <= 1'b1;

            we_b    <= $random;

            addr_b  <= $random % DEPTH;

            din_b   <= $random;
        end

    end




    // ========================================================
    // END
    // ========================================================

    #200;

    $display("=======================================");
    $display("SIMULATION COMPLETED");
    $display("=======================================");

    $finish;

end

endmodule
