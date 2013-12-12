

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
    wire	data_avaiable;
    wire	data_avaiable1;

//
   wire[7:0]	dat_s_i;
   wire[7:0]	dat_s_o;
   wire		data_avail;
   wire		data_req;
   wire		start;
   wire		stop;
//
    reg[17:0]	state;
    reg[7:0] 	adr;
    reg		W_R;


   localparam wb_dw = 8;
   localparam MEM_SIZE_BITS = 8;


   always @ (posedge clk_i or posedge rst_i)
	begin
	    data_avaiable = data_avaiable1;
	    data_avaiable1 = data_avail;

	end


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
		   	if(data_avaiable)
			begin
                            state <= adresse;
			end
		   	if(data_req)
			    state <= read;
		    end



		    adresse:
		    begin
		   	if(data_avaiable)
			begin
			    state <= write;
			    adr <= dat_s_o;
			    sel_m_i <= 4'h1;
			end
			if(start)
			    state <= idle;

		    end

		    read:
		    begin
			    adr_m_i <= adr;
			    cyc_m_i <= 1'b1;
			    stb_m_i <= 1'b1;
			    sel_m_i <= 4'h0;
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
			    adr <= adr +1;
			    state <= idle;
			end
		    end
		   
		    write:
		    begin
		   	if(data_avaiable)
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
			   state <= idle;
			   sel_m_i <= 4'h0;
			end

			if(start)
			begin
			    state <= idle;
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


		endcase

parameter [17:0] idle    = 6'b00_0000;
parameter [17:0] adresse = 6'b00_0001;
parameter [17:0] write 	 = 6'b00_0010;
parameter [17:0] write_a = 6'b00_0100;
parameter [17:0] read    = 6'b01_0000;
parameter [17:0] read_a  = 6'b10_0000;



////////////////////////////////////////////////////////////////////////
//
// FLASH
//
////////////////////////////////////////////////////////////////////////
   ram_wb_b3 #(
   //wb_bfm_memory #(.DEBUG (0),
	       .mem_size_bytes (2**MEM_SIZE_BITS*(wb_dw/8)),
	       .mem_adr_width (MEM_SIZE_BITS))
   flash
     (
      //Wishbone Master interface
      .wb_clk_i (clk_i),
      .wb_rst_i (rst_i),
      .wb_adr_i	(adr_m_i & (2**MEM_SIZE_BITS-1)),
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
      .clk      	( clk_i       	 ),//
      .my_addr  	( 7'h50          ),//
      .rst      	( rst_i	         ),//
      .nReset  	 	( 1'b1           ),//
      .ena      	( 1'b0           ),//
      .clk_cnt  	( 16'hffff       ),//
      .start    	( 1'b0           ),//
      .stop     	( 1'b0           ),//
      .read     	( 1'b0           ),//
      .write    	( 1'b0           ),//
      .ack_in   	( 1'b0           ),//
      .din      	( dat_s_i        ),//
      .cmd_ack  	(     ),
      .ack_out  	(     ),
      .dout     	( dat_s_o        ),
      .i2c_busy 	(     ),
      .i2c_al   	(     ),
      .scl_i    	( scl_i 	 ),//
      .scl_o    	( scl_pad_o      ),
      .scl_oen  	( scl_padoen_o   ),
      .sda_i    	( sda_i      	 ),//
      .sda_o    	( sda_pad_o      ),
      .sda_oen  	( sda_padoen_o   ),
      .sl_cont  	( 1'b0           ),//
      .slave_en 	( 1'b1           ),//
      .slave_dat_req 	( data_req       ),//
      .slave_dat_avail 	( data_avail  ),//
      .slave_act 	(     ),
      .slave_cmd_ack 	(     ),
      .stop_signal	( stop           ),//
      .start_signal	( start          ));//


endmodule

