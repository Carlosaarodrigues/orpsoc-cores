
`include "timescale.v"


module slave_spiTop #(
)(
  // SPI port
  input  reg        sck_i,      // serial clock output
  input  wire 	    ss_i,      	// slave select (active low)
  input  wire       mosi_i,     // MasterOut SlaveIN
  output wire       miso_o      // MasterIn SlaveOut
);

  reg [1:0]	state;
  reg [7:0]	word;
  reg [2:0]	word_cnt;
  reg [7:0]	command;
  reg 		read;
  reg 		write;
  reg [23:0]	adr_m_i;
  
   localparam wb_dw = 8;
   localparam MEM_SIZE_BITS = 24;

 assign word_done = ~|word_cnt;


  always @(posedge clk_i)
	if(rst_i || ss_i)
	begin         
	   cyc_o  <=  1'b0;      
	   stb_o  <=  1'b0;       
	   adr_m_i  <=  24'h0000;        
	   we_o   <=  1'b0;          
	   dat_o  <=  8'h0;
	   state  <=  2'b00;
	   read <=1'b0;
	   write <=1'b0;
	end
	else
	begin
	   case (state)

		3'b000: begin
		    read <=1'b1;
		    if (word_done)
		    begin
			state <=  3'b001;
			command <= word;
	    		word_cnt <= 3'b111;
		    end
		end 
		3'b001: begin 
		    if(command == 8'h03)
		    	if (word_done)
		    	begin
			    state <=  3'b010;
			    adr_m_i[23:16] <= word;
	    		    word_cnt <= 3'b111;
		    	end
		     else
			state <=  3'b000;
		end
		3'b010:
		    if (word_done)
		    begin
			state <=  3'b011;
			adr_m_i[15:8] <= word;
	    		word_cnt <= 3'b111;
		    end

		3'b011:
		    if (word_done)
		    begin
			state <=  3'b100;
			adr_m_i[7:0] <= word;
	    		word_cnt <= 3'b111;
		    	read <=1'b0;
		    end

		3'b100:
		begin
		    cyc_m_i <= 1'b1;
		    stb_m_i <= 1'b1;
		    sel_m_i <= 4'h1;
		    state <= 3'b100;
		end
		
		3'b101:
		    if(ack_m_o && word_done)
		    begin
			word <= dat_m_o;
		    	write <=1'b1;
			cyc_m_i <= 1'b0;
			stb_m_i <= 1'b0;
			sel_m_i <= 4'h0;
	    		word_cnt <= 3'b111;
			state <= 3'b101;
			adr_m_i <= adr_m_i + 1'b1;
		    end

		3'b101:
		    state <= 3'b100;
	    endcase
	end

  always @(posedge sck_i)
	if(rst_i || ss_i) begin
	    word  <= 8'h0;
	    word_cnt <= 3'b111; 
	end else
	    if(read && ~word_done)
	    begin
	    	word  <= {word[6:0],mosi_i};
		word_cnt <= word_cnt - 1'b1;
	    end


  always @(negedge sck_i)
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
      .wb_adr_i	({adr_m_i & (2**MEM_SIZE_BITS-1),2'b00}),
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
