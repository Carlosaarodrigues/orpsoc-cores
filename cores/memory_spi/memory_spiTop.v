/////////////////////////////////////////////////////////////////////////////
////                                                                     ////        
//// Memory with interface SPI				                 ////
////                                                                     ////
////                                                                     ////
//// Author(s):  Carlos Rodrigues		        		 ////
////	   	 carlosaarodrigues@inesc-id.pt                           ////
////                                                                     ////
//// Downloaded from:     					         ////
////  https://github.com/jjts/orpsoc-cores/tree/master/cores/memory_spi  ////
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


module slave_spiTop (
  input		    clk_i,
  input  	    rst_i,
  // SPI port
  input             sck_i,      // serial clock output
  input  wire 	    ss_i,      	// slave select (active low)
  input  wire       mosi_i,     // MasterOut SlaveIN
  output reg       miso_o      // MasterIn SlaveOut
);

  reg [3:0]	state;
  reg [7:0]	word;
  reg [7:0]	word_in;
  reg [3:0]	word_cnt;
  reg [7:0]	command;
  reg 		read;
  reg 		write;

  reg [23:0]	adr_m_i;
  reg [7:0]	dat_m_i;
  wire [7:0]	dat_m_o;
  reg [7:0]	size_write;

  reg [3:0]	sel_m_i;
  reg  		we_m_i; 
  reg  		cyc_m_i;
  reg  		stb_m_i;
  reg [2:0]	cti_m_i;
  wire  	ack_m_o;
  wire 	 	err_m_o;
  wire  	rty_m_o;
  wire		word_done;
  reg		word_done_aux;



  
   localparam wb_dw = 8;
   localparam MEM_SIZE_BITS = 26;

 assign word_done = ~|word_cnt && ~word_done_aux ;


  always @(posedge clk_i)
	if(rst_i)
	begin         
	   sel_m_i     <=  4'h0;
	   we_m_i      <=  1'b0; 
	   cyc_m_i     <=  1'b0;      
	   stb_m_i     <=  1'b0;
	   cti_m_i     <=  3'b000;    
	   adr_m_i    <=  24'h0000;                 
	   dat_m_i     <=  8'h0;
	   command     <=  8'h0;
	   state      <=  4'b0000;
	   read       <=  1'b0;
	   write      <=  1'b0;
	   word_done_aux <= 1'b0;
	   word_in     <=  8'h00;
	   size_write <=  8'h0;
	end
	else  	if( ss_i)
	begin         
	   sel_m_i   <=  4'h0;
	   cyc_m_i   <=  1'b0;      
	   stb_m_i   <=  1'b0;
	   cti_m_i   <=  3'b000;   
	   adr_m_i  <=  24'h0000;                 
	   dat_m_i   <=  8'h0;
      	   command     <=  8'h0;
	   state      <=  4'b0000;
	   read     <=  1'b0;
	   write    <=  1'b0;
	   word_done_aux <= 1'b0;
	   word_in     <=  8'h00;
	   size_write <=  8'h0;
	end
	else
	begin

	   if( word_done ) word_done_aux <= 1'b1;
	   if( word_cnt == 4'b1000)  word_done_aux <= 1'b0;
	
	   case (state)

		4'b0000:
		begin
		    read <=1'b1;
		    if (word_done)
		    begin
			state <=  4'b0001;
			command <= word;
		    end
		end



		4'b0001:
		    
		    	case (command)
			
			8'h03: //read
		    	begin
			    if (word_done)
			    begin
			    	state <=  4'b0010;
			    	adr_m_i[23:16] <= word;
			    end
		    	end

			8'h06: //enable write
			begin
			    we_m_i <= 1'b1;
			    state <=  4'b0000;
			end

			8'h04: //disable write
			begin
			    we_m_i <= 1'b0;
			    state <=  4'b0000;
			end

			8'h02: //Programa 
			begin
			    if (word_done)
			    begin
			    	state <=  4'b0010;
			    	adr_m_i[23:16] <= word;
			    end
			end

		     	default: state <=  4'b0000;
		        endcase


		4'b0010:
		    if (word_done)
		    begin
			state <=  4'b0011;
			adr_m_i[15:8] <= word;
		    end

		4'b0011:
		    if (word_done)
		    begin
			adr_m_i[7:0] <= word;


			if (command == 8'h03) //read mem and write in bus
			begin
		    	    read <=1'b0;
		    	    cyc_m_i  <= 1'b1;
		    	    stb_m_i  <= 1'b1;
		    	    sel_m_i  <= 4'h1;
		    	    state   <= 4'b0101;
			end

			if (command == 8'h02) //read bus and write in mem
			begin
		    	    read <=1'b1;
	   		    size_write <=  8'h0;
			    state <=  4'b1000;
			end

		    end

		4'b0100:
		if (~word_done_aux)
		begin
		    cyc_m_i  <= 1'b1;
		    stb_m_i  <= 1'b1;
		    sel_m_i  <= 4'h1;
		    state   <= 4'b0101;
		end
		
		4'b0101:
		    if(ack_m_o && word_done_aux)
		    begin
			word_in  <= dat_m_o;
			cyc_m_i   <= 1'b0;
			stb_m_i   <= 1'b0;
			sel_m_i   <= 4'h0;
			state    <= 4'b0110;
			adr_m_i  <= adr_m_i + 1'b1;
		    end

		4'b0110:
		begin
		    state <= 4'b0100;
		    write   <= 1'b1;
		end

		4'b1000:
		    if (word_done)
		    begin
			state <=  4'b1001;
			 dat_m_i <= word;
		    end

		4'b1001:
		begin
		    	cyc_m_i  <= 1'b1;
		    	stb_m_i  <= 1'b1;
		    	sel_m_i  <= 4'h1;
			state    <= 4'b1010;
		end

		4'b1010:
		    if(ack_m_o)
		    begin
			cyc_m_i   <= 1'b0;
			stb_m_i   <= 1'b0;
			sel_m_i   <= 4'h0;
			state    <= 4'b1000;
	   		size_write <= size_write + 1'b1;
			adr_m_i  <= adr_m_i + 1'b1;

			if (& size_write)state    <= 4'b0000;
		    end

		default:state    <= 4'b0000;

	    endcase
	end

  always @(posedge sck_i,negedge sck_i,posedge rst_i,posedge ss_i)
	if(rst_i || ss_i)
	begin
	    word  <= 8'h0;
	    word_cnt <= 4'b1000;
	end
	else begin

	    if( word_done_aux ) word_cnt <= 4'b1000;

	    if (sck_i)
	    begin
	    	if(read && ~word_done)
	    	begin
		    word  <= {word[6:0],mosi_i};
		    word_cnt <= word_cnt - 1'b1;
	    	end 

	    	else if(write && ~word_done)
	    	begin
		    if(word_cnt[3]) begin
			word <= {word_in[6:0] , 1'b0}; 
	    		miso_o  <= word_in[7];
			word_cnt <= word_cnt - 1'b1;
		    end
		    else begin
	    	    	miso_o  <= word[7];
		    	word  <= {word[6:0] , 1'b0};
		    	word_cnt <= word_cnt - 1'b1;
		    end
	    	end
	    end
	end


////////////////////////////////////////////////////////////////////////
//
// FLASH
//
////////////////////////////////////////////////////////////////////////

   wb_memory #(
		.aw (24),
		.dw (8))
  flash
     (
      //Wishbone Master interface
      .wb_clk_i (clk_i),
      .wb_rst_i (rst_i),
      .wb_adr_i	(adr_m_i),
      .wb_dat_i	(dat_m_i),
      .wb_sel_i	(sel_m_i),
      .wb_we_i	(we_m_i ),
      .wb_cyc_i	(cyc_m_i),
      .wb_stb_i	(stb_m_i),
      .wb_cti_i	(cti_m_i),
      .wb_bte_i	(2'b01),
      .wb_dat_o	(dat_m_o),
      .wb_ack_o	(ack_m_o),
      .wb_err_o (err_m_o),
      .wb_rty_o (rty_m_o));

endmodule
