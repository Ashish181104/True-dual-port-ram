`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// college: MNNIT Allahabad
// Ashish Kumar Kashyap
// 
// Create Date: 23.05.2026
// Design Name: Industrial RAM Subsystem
// Module Name: axi_style_interface
// Project Name: True Dual Port RAM
// Target Devices: Xilinx FPGA
// Tool Versions: Vivado 2023.x
// Description:
//
// AXI-style handshake interface.
//
// Features:
// - VALID/READY handshake
// - Pipeline registers
// - Independent clock domains
//
// Revision:
// Revision 0.01 - File Created
//
//////////////////////////////////////////////////////////////////////////////////
module axi_style_interface #

(
    parameter DATA_WIDTH = 32,
    parameter DEPTH      = 1024
)

(
    input clk_a,
    input rst_a,

    input clk_b,
    input rst_b,



   
    // PORT A INPUTS
  

    input valid_a,
    input we_a,

    input [$clog2(DEPTH)-1:0] addr_a,
    input [DATA_WIDTH-1:0] din_a,



    // PORT B INPUTS
   

    input valid_b,
    input we_b,

    input [$clog2(DEPTH)-1:0] addr_b,
    input [DATA_WIDTH-1:0] din_b,



    
    // READY OUTPUTS
  

    output reg ready_a,
    output reg ready_b,



   
    // PIPELINE OUTPUTS
   

    output reg we_a_pipe,
    output reg we_b_pipe,

    output reg [$clog2(DEPTH)-1:0] addr_a_pipe,
    output reg [$clog2(DEPTH)-1:0] addr_b_pipe,

    output reg [DATA_WIDTH-1:0] din_a_pipe,
    output reg [DATA_WIDTH-1:0] din_b_pipe
);





// PORT A LOGIC


always @(posedge clk_a or posedge rst_a)
begin

    if(rst_a)
    begin

        ready_a <= 1'b0;

        we_a_pipe   <= 1'b0;
        addr_a_pipe <= 0;
        din_a_pipe  <= 0;

    end

    else
    begin

      
        // ALWAYS READY
       

        ready_a <= 1'b1;



       
        // VALID/READY HANDSHAKE
       

        if(valid_a && ready_a)
        begin

            we_a_pipe   <= we_a;

            addr_a_pipe <= addr_a;

            din_a_pipe  <= din_a;

        end

        else
        begin

           
            // NO TRANSACTION
           

            we_a_pipe <= 1'b0;

        end

    end

end





// PORT B LOGIC


always @(posedge clk_b or posedge rst_b)
begin

    if(rst_b)
    begin

        ready_b <= 1'b0;

        we_b_pipe   <= 1'b0;
        addr_b_pipe <= 0;
        din_b_pipe  <= 0;

    end

    else
    begin

       
        // ALWAYS READY
        

        ready_b <= 1'b1;



       
        // VALID/READY HANDSHAKE
        

        if(valid_b && ready_b)
        begin

            we_b_pipe   <= we_b;

            addr_b_pipe <= addr_b;

            din_b_pipe  <= din_b;

        end

        else
        begin

           
            // NO TRANSACTION
          

            we_b_pipe <= 1'b0;

        end

    end

end

endmodule
