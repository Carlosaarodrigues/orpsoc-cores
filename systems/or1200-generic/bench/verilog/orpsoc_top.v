`define JTAG_DEBUG

module orpsoc_top
  (input wb_clk_i,
   input wb_rst_i

`ifdef JTAG_DEBUG
,   output          tdo_pad_o,
   input           tms_pad_i,
   input           tck_pad_i,
   input           tdi_pad_i
`endif
);

   localparam wb_aw = 32;
   localparam wb_dw = 32;

   localparam MEM_SIZE_BITS = 23;
   
   ////////////////////////////////////////////////////////////////////////
   //
   // Clock and reset generation
   // 
   ////////////////////////////////////////////////////////////////////////
   

   ////////////////////////////////////////////////////////////////////////
   //
   // Wishbone interconnect
   //
   ////////////////////////////////////////////////////////////////////////
   wire wb_clk = wb_clk_i;
   wire wb_rst = wb_rst_i;

   `include "wb_intercon.vh"

   wire [31:0]                wb_m2s_uart8_adr;
   wire [7:0] 		      wb_m2s_uart8_dat;
   wire 		      wb_m2s_uart8_we;
   wire 		      wb_m2s_uart8_cyc;
   wire 		      wb_m2s_uart8_stb;
   wire [2:0] 		      wb_m2s_uart8_cti;
   wire [1:0] 		      wb_m2s_uart8_bte;
   wire [7:0] 		      wb_s2m_uart8_dat;
   wire 		      wb_s2m_uart8_ack;
   wire 		      wb_s2m_uart8_err;
   wire 		      wb_s2m_uart8_rty;

`ifdef JTAG_DEBUG
////////////////////////////////////////////////////////////////////////
//
// GENERIC JTAG TAP
//
////////////////////////////////////////////////////////////////////////

wire	dbg_if_select;
wire	dbg_if_tdo;
wire	jtag_tap_tdo;
wire	jtag_tap_shift_dr;
wire	jtag_tap_pause_dr;
wire	jtag_tap_update_dr;
wire	jtag_tap_capture_dr;

tap_top jtag_tap0 (
	.tdo_pad_o			(tdo_pad_o),
	.tms_pad_i			(tms_pad_i),
	.tck_pad_i			(tck_pad_i),
	.trst_pad_i			(wb_rst),
	.tdi_pad_i			(tdi_pad_i),

	.tdo_padoe_o			(tdo_padoe_o),

	.tdo_o				(jtag_tap_tdo),

	.shift_dr_o			(jtag_tap_shift_dr),
	.pause_dr_o			(jtag_tap_pause_dr),
	.update_dr_o			(jtag_tap_update_dr),
	.capture_dr_o			(jtag_tap_capture_dr),

	.extest_select_o		(),
	.sample_preload_select_o	(),
	.mbist_select_o			(),
	.debug_select_o			(dbg_if_select),


	.bs_chain_tdi_i			(1'b0),
	.mbist_tdi_i			(1'b0),
	.debug_tdi_i			(dbg_if_tdo)
);
`endif

   ////////////////////////////////////////////////////////////////////////
   //
   // or1200
   // 
   ////////////////////////////////////////////////////////////////////////

   wire [19:0] 				  or1200_pic_ints;

   wire	[31:0]	or1k_dbg_dat_i;  
   wire	[31:0]	or1k_dbg_adr_i;
   wire		or1k_dbg_we_i;
   wire		or1k_dbg_stb_i;
   wire		or1k_dbg_ack_o;
   wire	[31:0]	or1k_dbg_dat_o;

   wire		or1k_dbg_stall_i;
   wire		or1k_dbg_ewt_i;
   wire	[3:0]	or1k_dbg_lss_o;
   wire	[1:0]	or1k_dbg_is_o;
   wire	[10:0]	or1k_dbg_wp_o;
   wire		or1k_dbg_bp_o;
   wire		or1k_dbg_rst;

   wire		or1k_rst;

   assign	or1k_rst= wb_rst | or1k_dbg_rst;


   or1200_top #(.boot_adr(32'h00000100)) or1200_top0
       (
	// Instruction bus, clocks, reset
	.iwb_clk_i			(wb_clk_i),
	.iwb_rst_i			(wb_rst_i),
	.iwb_adr_o			(wb_m2s_or1200_i_adr),
	.iwb_dat_o			(wb_m2s_or1200_i_dat),
	.iwb_sel_o			(wb_m2s_or1200_i_sel),
	.iwb_we_o			(wb_m2s_or1200_i_we ),
	.iwb_cyc_o			(wb_m2s_or1200_i_cyc),
	.iwb_stb_o			(wb_m2s_or1200_i_stb),
	.iwb_cti_o			(wb_m2s_or1200_i_cti),
	.iwb_bte_o			(wb_m2s_or1200_i_bte),
	.iwb_dat_i			(wb_s2m_or1200_i_dat),
	.iwb_ack_i			(wb_s2m_or1200_i_ack),
	.iwb_err_i			(wb_s2m_or1200_i_err),
	.iwb_rty_i			(wb_s2m_or1200_i_rty),
	// Data bus, clocks, reset            
	.dwb_clk_i			(wb_clk_i),
	.dwb_rst_i			(wb_rst_i),
	.dwb_adr_o			(wb_m2s_or1200_d_adr),
	.dwb_dat_o			(wb_m2s_or1200_d_dat),
	.dwb_sel_o			(wb_m2s_or1200_d_sel),
	.dwb_we_o			(wb_m2s_or1200_d_we),
	.dwb_cyc_o			(wb_m2s_or1200_d_cyc),
	.dwb_stb_o			(wb_m2s_or1200_d_stb),
	.dwb_cti_o			(wb_m2s_or1200_d_cti),
	.dwb_bte_o			(wb_m2s_or1200_d_bte),
	.dwb_dat_i			(wb_s2m_or1200_d_dat),
	.dwb_ack_i			(wb_s2m_or1200_d_ack),
	.dwb_err_i			(wb_s2m_or1200_d_err),
	.dwb_rty_i			(wb_s2m_or1200_d_rty),

	// Debug interface ports
	.dbg_stall_i			(or1k_dbg_stall_i),
	.dbg_ewt_i			(1'b0),
	.dbg_lss_o			(or1k_dbg_lss_o),
	.dbg_is_o			(or1k_dbg_is_o),
	.dbg_wp_o			(or1k_dbg_wp_o),
	.dbg_bp_o			(or1k_dbg_bp_o),

	.dbg_adr_i			(or1k_dbg_adr_i),
	.dbg_we_i			(or1k_dbg_we_i),
	.dbg_stb_i			(or1k_dbg_stb_i),
	.dbg_dat_i			(or1k_dbg_dat_i),
	.dbg_dat_o			(or1k_dbg_dat_o),
	.dbg_ack_o			(or1k_dbg_ack_o),
	
	.pm_clksd_o			(),
	.pm_dc_gate_o			(),
	.pm_ic_gate_o			(),
	.pm_dmmu_gate_o			(),
	.pm_immu_gate_o			(),
	.pm_tt_gate_o			(),
	.pm_cpu_gate_o			(),
	.pm_wakeup_o			(),
	.pm_lvolt_o			(),

	// Core clocks, resets
	.clk_i				(wb_clk_i),
	.rst_i				(or1k_rst),
	
	.clmode_i			(2'b00),
	// Interrupts      
	.pic_ints_i			(or1200_pic_ints),
	.sig_tick(),

	.pm_cpustall_i			(1'b0));

   ////////////////////////////////////////////////////////////////////////
   //
   // Generic main RAM
   // 
   ////////////////////////////////////////////////////////////////////////
   ram_wb_b3 #(
   //wb_bfm_memory #(.DEBUG (0),
	       .mem_size_bytes (2**MEM_SIZE_BITS*(wb_dw/8)),
	       .mem_adr_width (MEM_SIZE_BITS))
   wb_bfm_memory0
     (
      //Wishbone Master interface
      .wb_clk_i (wb_clk_i),
      .wb_rst_i (wb_rst_i),
      .wb_adr_i	(wb_m2s_mem_adr & (2**MEM_SIZE_BITS-1)),
      .wb_dat_i	(wb_m2s_mem_dat),
      .wb_sel_i	(wb_m2s_mem_sel),
      .wb_we_i	(wb_m2s_mem_we),
      .wb_cyc_i	(wb_m2s_mem_cyc),
      .wb_stb_i	(wb_m2s_mem_stb),
      .wb_cti_i	(wb_m2s_mem_cti),
      .wb_bte_i	(wb_m2s_mem_bte),
      .wb_dat_o	(wb_s2m_mem_dat),
      .wb_ack_o	(wb_s2m_mem_ack),
      .wb_err_o (wb_s2m_mem_err),
      .wb_rty_o (wb_s2m_mem_rty));
   
   ////////////////////////////////////////////////////////////////////////
   //
   // UART
   // 
   ////////////////////////////////////////////////////////////////////////
   wb_data_resize wb_data_resize_uart0
   (//Wishbone Master interface
    .wbm_adr_i (wb_m2s_uart_adr),
    .wbm_dat_i (wb_m2s_uart_dat),
    .wbm_sel_i (wb_m2s_uart_sel),
    .wbm_we_i  (wb_m2s_uart_we ),
    .wbm_cyc_i (wb_m2s_uart_cyc),
    .wbm_stb_i (wb_m2s_uart_stb),
    .wbm_cti_i (wb_m2s_uart_cti),
    .wbm_bte_i (wb_m2s_uart_bte),
    .wbm_dat_o (wb_s2m_uart_dat),
    .wbm_ack_o (wb_s2m_uart_ack),
    .wbm_err_o (wb_s2m_uart_err),
    .wbm_rty_o (wb_s2m_uart_rty),
    // Wishbone Slave interface
    .wbs_adr_o (wb_m2s_uart8_adr),
    .wbs_dat_o (wb_m2s_uart8_dat),
    .wbs_we_o  (wb_m2s_uart8_we ),
    .wbs_cyc_o (wb_m2s_uart8_cyc),
    .wbs_stb_o (wb_m2s_uart8_stb),
    .wbs_cti_o (wb_m2s_uart8_cti),
    .wbs_bte_o (wb_m2s_uart8_bte),
    .wbs_dat_i (wb_s2m_uart8_dat),
    .wbs_ack_i (wb_s2m_uart8_ack),
    .wbs_err_i (wb_s2m_uart8_err),
    .wbs_rty_i (wb_s2m_uart8_rty));
/* 
   wb_uart_wrapper #(.DEBUG (0))
   wb_uart_wrapper0
     (
      //Wishbone Master interface
      .wb_clk_i (wb_clk_i),
      .wb_rst_i (wb_rst_i),
      .wb_adr_i	(wb_m2s_uart8_adr),
      .wb_dat_i	(wb_m2s_uart8_dat),
      .wb_we_i	(wb_m2s_uart8_we),
      .wb_cyc_i	(wb_m2s_uart8_cyc),
      .wb_stb_i	(wb_m2s_uart8_stb),
      .wb_cti_i	(wb_m2s_uart8_cti),
      .wb_bte_i	(wb_m2s_uart8_bte),
      .wb_dat_o	(wb_s2m_uart8_dat),
      .wb_ack_o	(wb_s2m_uart8_ack),
      .wb_err_o (wb_s2m_uart8_err),
      .wb_rty_o (wb_s2m_uart8_rty));
*/

////////////////////////////////////////////////////////////////////////
//
// Debug Interface
//
////////////////////////////////////////////////////////////////////////

`ifdef JTAG_DEBUG
adbg_top dbg_if0 (
	// OR1K interface
	.cpu0_clk_i	(wb_clk),
	.cpu0_rst_o	(or1k_dbg_rst),
	.cpu0_addr_o	(or1k_dbg_adr_i),
	.cpu0_data_o	(or1k_dbg_dat_i),
	.cpu0_stb_o	(or1k_dbg_stb_i),
	.cpu0_we_o	(or1k_dbg_we_i),
	.cpu0_data_i	(or1k_dbg_dat_o),
	.cpu0_ack_i	(or1k_dbg_ack_o),
	.cpu0_stall_o	(or1k_dbg_stall_i),
	.cpu0_bp_i	(or1k_dbg_bp_o),

	// TAP interface
	.tck_i		(tck_pad_i),
	.tdi_i		(jtag_tap_tdo),
	.tdo_o		(dbg_if_tdo),
	.rst_i		(wb_rst),
	.capture_dr_i	(jtag_tap_capture_dr),
	.shift_dr_i	(jtag_tap_shift_dr),
	.pause_dr_i	(jtag_tap_pause_dr),
	.update_dr_i	(jtag_tap_update_dr),
	.debug_select_i	(dbg_if_select),

	// Wishbone debug master
	.wb_clk_i	(wb_clk),
	.wb_dat_i	(wb_s2m_dbg_dat),
	.wb_ack_i	(wb_s2m_dbg_ack),
	.wb_err_i	(wb_s2m_dbg_err),

	.wb_adr_o	(wb_m2s_dbg_adr),
	.wb_dat_o	(wb_m2s_dbg_dat),
	.wb_cyc_o	(wb_m2s_dbg_cyc),
	.wb_stb_o	(wb_m2s_dbg_stb),
	.wb_sel_o	(wb_m2s_dbg_sel),
	.wb_we_o	(wb_m2s_dbg_we),
	.wb_cti_o	(wb_m2s_dbg_cti),
	.wb_bte_o	(wb_m2s_dbg_bte)
);
`endif

   ////////////////////////////////////////////////////////////////////////
   //
   // OR1200 Interrupt assignment
   // 
   ////////////////////////////////////////////////////////////////////////
   assign or1200_pic_ints[0] = 0; // Non-maskable inside OR1200
   assign or1200_pic_ints[1] = 0; // Non-maskable inside OR1200
   assign or1200_pic_ints[2] = 0;
   assign or1200_pic_ints[3] = 0;
   assign or1200_pic_ints[4] = 0;
   assign or1200_pic_ints[5] = 0;
   assign or1200_pic_ints[6] = 0;
   assign or1200_pic_ints[7] = 0;
   assign or1200_pic_ints[8] = 0;
   assign or1200_pic_ints[9] = 0;
   assign or1200_pic_ints[10] = 0;
   assign or1200_pic_ints[11] = 0;
   assign or1200_pic_ints[12] = 0;
   assign or1200_pic_ints[13] = 0;
   assign or1200_pic_ints[14] = 0;
   assign or1200_pic_ints[15] = 0;
   assign or1200_pic_ints[16] = 0;
   assign or1200_pic_ints[17] = 0;
   assign or1200_pic_ints[18] = 0;
   assign or1200_pic_ints[19] = 0;
   
endmodule
