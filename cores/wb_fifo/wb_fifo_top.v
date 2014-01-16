/////////////////////////////////////////////////////////////////////////////
////                                                                     ////        
//// Fifo interface for WB				                 ////
////                                                                     ////
////                                                                     ////
//// Author(s):  Carlos Rodrigues		        		 ////
////	   	 carlosaarodrigues@inesc-id.pt                           ////
////                                                                     ////
//// Downloaded from:     					         ////
////  https://github.com/jjts/orpsoc-cores/tree/master/cores/wb_fifo     ////
/////////////////////////////////////////////////////////////////////////////
////                                                                     ////
//// Copyright (C) 2013 Carlos Rodigues                        		 ////
////                    carlosaarodrigues@inesc-id.pt                    ////
////                                                                     ////
////  This Source Code Form is subject to the terms of the        	 ////
////  Open Hardware Description License, v. 1.0. If a copy        	 ////
////  of the OHDL was not distributed with this file, You        	 ////
////  can obtain one at http://juliusbaxter.net/ohdl/ohdl.txt            ////
////                                                                     ////
/////////////////////////////////////////////////////////////////////////////


`include "timescale.v"


module wb_fifo #(
  parameter dw = 32
)(
 
  input        		clk_i,   
  input        		cyc_i,    
  input        		stb_i,     
  input   [2:0]  	adr_i,       
  input        		we_i,        
  input   [dw-1:0]  	dat_i,  
  output  [dw-1:0]  	dat_o,
  output        	ack_o,

  //interface
  input   [dw-1:0] 	fifo_s2m_dat_i,
  input		     	fifo_s2m_we,
  output	     	fifo_s2m_empty,
  output	     	fifo_s2m_full,
  output  [dw-1:0] 	fifo_m2s_dat_o,
  input              	fifo_m2s_re,
  output	     	fifo_m2s_empty,
  output	     	fifo_m2s_full

);


  // fifo signals
  reg        m2s_we;
  wire [dw-1:0] s2m_dout;
  reg        s2m_re;


  wire wb_acc = cyc_i & stb_i;       // WISHBONE access
  wire wb_wr = wb_acc & we_i;       // WISHBONE write access
  reg wb_re;      		   // WISHBONE read access

  wire [7:0] spsr;

  // write fifo
  assign m2s_we = wb_acc & (adr_i == 3'b000) & ack_o &  we_i;

  // dat_o
  always @(posedge clk_i)
    case(adr_i) 
       3'b000: dat_o <= s2m_dout;
       3'b010: dat_o <= {{dw-8{1'b0}},spsr};
      default: dat_o <= 0;
    endcase

  // read fifo
  assign s2m_re = wb_acc & (adr_i == 3'b000) & ~ack_o & ~we_i & ~fifo_s2m_empty;

  // ack_o
  always @(posedge clk_i)
    if (rst_i)
      ack_o <= 1'b0;
    else if (we_i)
      ack_o <= wb_acc & !ack_o ;
    else
      ack_o <= wb_acc & !ack_o & s2m_re;



  assign spsr[7:4] = 4'b0000;
  assign spsr[3]   = fifo_m2s_full;
  assign spsr[2]   = fifo_m2s_empty;
  assign spsr[1]   = fifo_m2s_full;
  assign spsr[0]   = fifo_s2m_empty;
  

  //
  // hookup read/write buffer fifo
  fifo4 #(dw) //fifo for master send data
  m2s_fifo(
	.clk   ( clk_i   ),
	.rst   ( ~rst_i  ),
	.clr   ( rst_i    ),
	.din   ( dat_i   ),
	.we    ( m2s_we    ),
	.dout  ( fifo_m2s_dat_o  ),
	.re    ( fifo_m2s_re    ),
	.full  ( fifo_m2s_full  ),
	.empty ( fifo_m2s_empty )
  );

  fifo4 #(dw) //fifo for master receive data
  s2m_fifo(
	.clk   ( clk_i   ),
	.rst   ( ~rst_i  ),
	.clr   ( rst_i    ),
	.din   ( fifo_s2m_dat_i ),
	.we    ( fifo_s2m_we    ),
	.dout  ( s2m_dout  ),
	.re    ( s2m_re    ),
	.full  ( fifo_s2m_full  ),
	.empty ( fifo_s2m_empty )
  );


endmodule

