/////////////////////////////////////////////////////////////////////////////
////                                                                     ////        
//// Memory with interface I2C				                 ////
////                                                                     ////
////                                                                     ////
//// Author(s):  Carlos Rodrigues		        		 ////
////	   	 carlosaarodrigues@inesc-id.pt                           ////
////                                                                     ////
//// Downloaded from:     					         ////
////  https://github.com/jjts/orpsoc-cores/tree/master/cores/memory_i2c  ////
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


module memory_i2c (

    input 		       	clk_i,
    input 		 	rst_i,
    input 			scl_i,
    output 			scl_padoen_o,
    output 			scl_pad_o,
    input 			sda_i,
    output 			sda_padoen_o,
    output 			sda_pad_o,
    output 			irq_o);

    wire[7:0]	adr_m_i;
    wire[7:0]	dat_m_i;
    wire[3:0]	sel_m_i;
    wire	we_m_i ;
    wire	cyc_m_i;
    wire	stb_m_i;
    wire[2:0]	cti_m_i;
    wire[7:0]	dat_m_o;
    wire	ack_m_o;
    wire	err_m_o;
    wire	rty_m_o;


   wire[7:0]	dat_s_i;
   wire[7:0]	dat_s_o;
   wire		data_avail;
   wire		data_req;
   wire		start;
   wire		stop;

    reg[4:0]	state;
    reg[7:0] 	adr;


   always @ (posedge clk_i or posedge rst_i)
	if(rst_i)
	begin
		adr<= 8'h0;
		state <= idle;
		cti_m_i <= 3'b111;
		stb_m_i <= 1'b0;
		cyc_m_i <= 1'b0;
		we_m_i  <= 1'b0;
		sel_m_i <= 4'h0;
	end
	else
		case (state)
                    idle://
                    begin
			   we_m_i  <= 1'b0;
			   stb_m_i <= 1'b0;
			   cyc_m_i <= 1'b0;
		   	if(data_avail)
			begin
                            state <= adresse;
			end

		   	if(data_req)
			begin
			    state <= read;
			    adr <= adr +1;
			end
		    end


		    ////capture memory address  
		    adresse:
		    begin
		   	if(data_avail)
			begin
			    state <= write;
			    adr <= dat_s_o;
			    sel_m_i <= 4'h1;
			end
			if(start)
			    state <= read;

		    end

		    ////read memory 
		    read:
		    begin
			    adr_m_i <= adr;
			    cyc_m_i <= 1'b1;
			    stb_m_i <= 1'b1;
			    sel_m_i <= 4'h1;
			    state <= read_a;
		    end

		    read_a:
		    begin
			if(ack_m_o)
			begin
			    dat_s_i <= dat_m_o;
			    cyc_m_i <= 1'b0;
			    stb_m_i <= 1'b0;
			    sel_m_i <= 4'h0;
			    state <= idle;
			end
		    end
		   
		    ////write memory 
		    write:
		    begin
		   	if(data_avail)
			begin
			    adr_m_i <= adr;
			    dat_m_i <= dat_s_o;
			    we_m_i  <= 1'b1;
			    stb_m_i <= 1'b1;
			    cyc_m_i <= 1'b1;
			    state <= write_a;
			end
			if (stop)
			begin
			   state <= read;
			   sel_m_i <= 4'h0;
			end

			if(start)
			begin
			    state <= read;
			   sel_m_i <= 4'h0;
			end
		    end

		    write_a:
		    begin
			if (ack_m_o)
			begin
			   adr <= adr +1;
			   we_m_i  <= 1'b1;
			   stb_m_i <= 1'b0;
			   cyc_m_i <= 1'b0;
			   state <= write;	
			end
		    end

		    default: state <= idle;

		endcase







parameter [4:0] idle    = 5'b0_0000;
parameter [4:0] adresse = 5'b0_0001;
parameter [4:0] write 	= 5'b0_0010;
parameter [4:0] write_a = 5'b0_0100;
parameter [4:0] read    = 5'b0_1000;
parameter [4:0] read_a  = 5'b1_0000;



////////////////////////////////////////////////////////////////////////
//
// FLASH
//
////////////////////////////////////////////////////////////////////////

   wb_memory #(
		.aw (8),
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

////////////////////////////////////////////////////////////////////////
//
// i2c Slave
//
////////////////////////////////////////////////////////////////////////

i2c_master_byte_ctrl i2c_slave (
      .clk      	( clk_i       	 ),
      .my_addr  	( 7'h50          ),
      .rst      	( rst_i	         ),
      .nReset  	 	( 1'b1           ),
      .ena      	( 1'b0           ),
      .clk_cnt  	( 16'hffff       ),
      .start    	( 1'b0           ),
      .stop     	( 1'b0           ),
      .read     	( 1'b0           ),
      .write    	( 1'b0           ),
      .ack_in   	( 1'b0           ),
      .din      	( dat_s_i        ),
      .cmd_ack  	(     ),
      .ack_out  	(     ),
      .dout     	( dat_s_o        ),
      .i2c_busy 	(     ),
      .i2c_al   	(     ),
      .scl_i    	( scl_i 	 ),
      .scl_o    	( scl_pad_o      ),
      .scl_oen  	( scl_padoen_o   ),
      .sda_i    	( sda_i      	 ),
      .sda_o    	( sda_pad_o      ),
      .sda_oen  	( sda_padoen_o   ),
      .sl_cont  	( 1'b0           ),
      .slave_en 	( 1'b1           ),
      .slave_dat_req 	( data_req       ),
      .slave_dat_avail 	( data_avail   	 ),
      .slave_act 	(     ),
      .slave_cmd_ack 	(     ),
      .stop_signal	( stop           ),
      .start_signal	( start          ));


endmodule

