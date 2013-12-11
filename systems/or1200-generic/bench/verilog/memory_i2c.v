

module memory_i2c (

    input 		       	clk_i,
    input 		 	rst_i,
    input[7:0] 		  	dat_i,
    output[7:0] 		dat_o,
    input			dat_avail,
    input			dat_req,
    input 		 	stop,
    input			start);


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


    reg[17:0]	state;
    reg[7:0] 	adr;
    reg		W_R;


   localparam wb_dw = 8;
   localparam MEM_SIZE_BITS = 8;


   always @ (posedge clk_i or posedge rst_i)
	begin
	    data_avaiable = data_avaiable1;
	    data_avaiable1 = dat_avail;

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
	end
	else
		case (state)
                    idle://
                    begin
		   	if(data_avaiable)
			begin
                            state <= adresse;
			end
		   	if(dat_req)
			    state <= read;
		    end



		    adresse:
		    begin
		   	if(data_avaiable)
			begin
			    state <= write;
			    adr <= dat_i;
			end
			if(start)
			    state <= idle;

		    end

		    read:
		    begin
			    adr_m_i <= adr;
			    cyc_m_i <= 1'b1;
			    stb_m_i <= 1'b1;
			    state <= read_a;
		    end

		    read_a:
		    begin
			if(ack_m_o)
			begin
			    dat_o <= dat_m_o;
			    cyc_m_i <= 1'b0;
			    stb_m_i <= 1'b0;
			    adr <= adr +1;
			    state <= idle;
			end
		    end
		   
		    write:
		    begin
		   	if(data_avaiable)
			begin
			    adr_m_i <= adr;
			    dat_m_i <= dat_i;
			    we_m_i  <= 1'b1;
			    stb_m_i <= 1'b1;
			    cyc_m_i <= 1'b1;
			    state <= write_a;
			end
			if (stop)
			   state <= idle;
			if(start)
			    state <= idle;
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
      .wb_bte_i	(8'b01),
      .wb_dat_o	(dat_m_o),
      .wb_ack_o	(ack_m_o),
      .wb_err_o (err_m_o),
      .wb_rty_o (rty_m_o));

endmodule

