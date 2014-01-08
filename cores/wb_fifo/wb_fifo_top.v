/////////////////////////////////////////////////////////////////////
////                                                             ////
////  WB  FIFO                      				 ////
////                                                             ////
////  Author: Richard Herveille                                  ////
////                                            		 ////
////                                                 		 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2002                        ////
////                                             ////
////                                                             ////
//// This source file may be used and distributed without        ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and that any derivative work contains ////
//// the original copyright notice and the associated disclaimer.////
////                                                             ////
////     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ////
//// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ////
//// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ////
//// FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ////
//// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ////
//// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ////
//// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ////
//// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ////
//// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ////
//// LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ////
//// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ////
//// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ////
//// POSSIBILITY OF SUCH DAMAGE.                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////

// synopsys translate_off
`include "timescale.v"
// synopsys translate_on

module wb_fifo #(
  parameter dw = 32
)(
  // 8bit WISHBONE bus slave interface
  input  wire        clk_i,         // clock
  input  wire        rst_i,         // reset (synchronous active high)
  input  wire        cyc_i,         // cycle
  input  wire        stb_i,         // strobe
  input  wire [2:0]  adr_i,         // address
  input  wire        we_i,          // write enable
  input  wire [dw-1:0] dat_i,         // data input
  output reg  [dw-1:0] dat_o,         // data output
  output reg         ack_o,         // normal bus termination
  output reg         inta_o,        // interrupt output

  //interface
  input	      [dw-1:0] fifo_s2m_dat_i,
  input		     fifo_s2m_we,
  output	     fifo_s2m_empty,
  output	     fifo_s2m_full,
  output      [dw-1:0] fifo_m2s_dat_o,
  input              fifo_m2s_re,
  output	     fifo_m2s_empty,
  output	     fifo_m2s_full

);


  // fifo signals
  reg        m2s_we;

  wire [dw-1:0] s2m_dout;
  reg        s2m_re;


  //
  // Wishbone interface
  wire wb_acc = cyc_i & stb_i;       // WISHBONE access
  wire wb_wr = wb_acc & we_i;       // WISHBONE write access
  reg wb_re;      		   // WISHBONE read access

  wire [7:0] spsr;

  // write fifo
  assign m2s_we = wb_acc & (adr_i == 3'b000) & ack_o &  we_i;

  // dat_o
  always @(posedge clk_i)
    case(adr_i) // synopsys full_case parallel_case

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

