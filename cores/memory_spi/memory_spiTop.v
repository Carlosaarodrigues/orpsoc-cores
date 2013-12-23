
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
  reg [3:0]	word_cnt;
  reg [7:0]	command;
  reg 		read;
  reg 		write;

  reg [23:0]	adr_m_i;
  reg [7:0]	dat_m_i;
  wire [31:0]	dat_m_o;
  reg [7:0]	size_write;

  reg [3:0]	sel_m_i;
  reg  	we_m_i; 
  reg  	cyc_m_i;
  reg  	stb_m_i;
  reg  	cti_m_i;
  wire  	ack_m_o;
  wire 	 	err_m_o;
  wire  	rty_m_o;



  
   localparam wb_dw = 8;
   localparam MEM_SIZE_BITS = 24;

 assign word_done = ~|word_cnt;


  always @(posedge clk_i)
	if(rst_i)
	begin         
	   sel_m_i     <=  4'h0;
	   we_m_i      <=  1'b0; 
	   cyc_m_i     <=  1'b0;      
	   stb_m_i     <=  1'b0;
	   cti_m_i     <=  1'b0;    
	   adr_m_i    <=  24'h0000;                 
	   dat_m_i     <=  8'h0;
	   command     <=  8'h0;
	   state      <=  4'b0000;
	   read       <=  1'b0;
	   write      <=  1'b0;
	   word_cnt   <=  4'b1000;
	   size_write <=  8'h0;
	end
	else  	if( ss_i)
	begin         
	   sel_m_i   <=  4'h0;
	   cyc_m_i   <=  1'b0;      
	   stb_m_i   <=  1'b0;
	   cti_m_i   <=  1'b0;    
	   adr_m_i  <=  24'h0000;                 
	   dat_m_i   <=  8'h0;
      	   command     <=  8'h0;
	   state      <=  4'b0000;
	   read     <=  1'b0;
	   write    <=  1'b0;
	   word_cnt <=  4'b1000;
	   size_write <=  8'h0;
	end
	else
	begin
	   case (state)

		4'b0000:
		begin
		    read <=1'b1;
		    if (word_done)
		    begin
			state <=  4'b0001;
			command <= word;
	    		word_cnt <= 4'b1000;
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
	    		    	word_cnt <= 4'b1000;
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
	    		    	word_cnt <= 4'b1000;
			    end
			end

		     	default: state <=  4'b0000;
		        endcase


		4'b0010:
		    if (word_done)
		    begin
			state <=  4'b0011;
			adr_m_i[15:8] <= word;
	    		word_cnt <= 4'b1000;
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
		    	    word_cnt <= 4'b1000;
		    	    read <=1'b1;
	   		    size_write <=  8'h0;
			    state <=  4'b1000;
			end

		    end

		4'b0100:
		begin
		    cyc_m_i  <= 1'b1;
		    stb_m_i  <= 1'b1;
		    sel_m_i  <= 4'h1;
		    state   <= 4'b0101;
		end
		
		4'b0101:
		    if(ack_m_o && word_done)
		    begin
	    		word_cnt <= 4'b1000;
			word     <= dat_m_o[7:0];
			cyc_m_i   <= 1'b0;
			stb_m_i   <= 1'b0;
			sel_m_i   <= 4'h0;
	    		word_cnt <= 4'b1000;
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
	    		word_cnt <= 4'b1000;
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

	    endcase
	end

  always @(posedge sck_i)
	if(rst_i || ss_i)
	begin
	    word  <= 8'h0;
	end
	else
	    if(read && ~word_done)
	    begin
	    	word  <= {word[6:0],mosi_i};
		word_cnt <= word_cnt - 1'b1;
	    end

  always @(posedge sck_i)
	    if(write && ~word_done)
	    begin
	    	miso_o  <= word[7];
		word  <= {word[6:0] , 1'b0};
		word_cnt <= word_cnt - 1'b1;
	    end


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
      .wb_adr_i	({adr_m_i,2'b00} & (2**MEM_SIZE_BITS-1)),
      .wb_dat_i	({24'd0,dat_m_i}),
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
