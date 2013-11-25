//////////////////////////////////////////////////////////////////////
////                                                              ////
//// i2cSlaveTop.v                                                   ////
////                                                              ////
//// This file is part of the i2cSlave opencores effort.
//// <http://www.opencores.org/cores//>                           ////
////                                                              ////
//// Module Description:                                          ////
//// You will need to modify this file to implement your 
//// interface.
////                                                              ////
//// To Do:                                                       ////
//// 
////                                                              ////
//// Author(s):                                                   ////
//// - Steve Fielding, sfielding@base2designs.com                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2008 Steve Fielding and OPENCORES.ORG          ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE. See the GNU Lesser General Public License for more  ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from <http://www.opencores.org/lgpl.shtml>                   ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
`include "flash_i2c_define.v"


module flash_i2cTop #(
   parameter dw = 32,
   parameter aw = 32,
   // Memory parameters
   parameter memory_file = "",
   parameter mem_size_bytes = 32'h0000_5000, // 20KBytes
   parameter mem_adr_width = 15) //(log2(mem_size_bytes));

  (input clk,
   input rst,
   inout sda,
   input scl);

   localparam bytes_per_dw = (dw/8);
   localparam adr_width_for_num_word_bytes = 2; //(log2(bytes_per_dw))
   localparam mem_words = (mem_size_bytes/bytes_per_dw); 

wire [7:0] addr_write;
wire [7:0] addr_read;
wire [7:0] dat_in;
wire [7:0] dat_out;

reg [dw-1:0] 	mem [ 0 : mem_words-1 ];
reg [7:0] adr;

   always@(addr_read)
	dat_out <= mem[addr_read];

   always@(addr_write)
	adr = addr_write;

   always@(dat_in) 
	mem[adr] = dat_in;

i2cSlave u_i2cSlave(
  .clk(clk),
  .rst(rst),
  .sda(sda),
  .scl(scl),
  .myReg0(addr_write),
  .myReg1(addr_read),
  .myReg2(dat_in),
  .myReg3(),
  .myReg4(dat_out),
  .myReg5(),
  .myReg6(),
  .myReg7()

);

// synthesis translate_off

`ifdef verilator
   
   task do_readmemh;
      // verilator public
      $readmemh(memory_file, mem);
   endtask // do_readmemh

`endif // !`ifdef verilator
   
//synthesis translate_on

   // Function to access RAM (for use by Verilator).
   function [31:0] get_mem32;
      // verilator public
      input [aw-1:0] 		addr;
      get_mem32 = mem[addr];
   endfunction // get_mem32   

   // Function to access RAM (for use by Verilator).
   function [7:0] get_mem8;
      // verilator public
      input [aw-1:0] 		addr;
            reg [31:0] 		temp_word;
      begin
	 temp_word = mem[{addr[aw-1:2],2'd0}];
	 // Big endian mapping.
	 get_mem8 = (addr[1:0]==2'b00) ? temp_word[31:24] :
		    (addr[1:0]==2'b01) ? temp_word[23:16] :
		    (addr[1:0]==2'b10) ? temp_word[15:8] : temp_word[7:0];
	 end
   endfunction // get_mem8   

   // Function to write RAM (for use by Verilator).
   function set_mem32;
      // verilator public
      input [aw-1:0] 		addr;
      input [dw-1:0] 		data;
      begin
         mem[addr] = data;
         set_mem32 = data; // For avoiding ModelSim warning
      end
   endfunction // set_mem32   
   
endmodule // ram_wb_b3



 
