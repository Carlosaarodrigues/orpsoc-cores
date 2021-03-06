module wb_intercon
   (input         wb_clk_i,
    input         wb_rst_i,
    input  [31:0] wb_or1200_d_adr_i,
    input  [31:0] wb_or1200_d_dat_i,
    input   [3:0] wb_or1200_d_sel_i,
    input         wb_or1200_d_we_i,
    input         wb_or1200_d_cyc_i,
    input         wb_or1200_d_stb_i,
    input   [2:0] wb_or1200_d_cti_i,
    input   [1:0] wb_or1200_d_bte_i,
    output [31:0] wb_or1200_d_dat_o,
    output        wb_or1200_d_ack_o,
    output        wb_or1200_d_err_o,
    output        wb_or1200_d_rty_o,
    input  [31:0] wb_or1200_i_adr_i,
    input  [31:0] wb_or1200_i_dat_i,
    input   [3:0] wb_or1200_i_sel_i,
    input         wb_or1200_i_we_i,
    input         wb_or1200_i_cyc_i,
    input         wb_or1200_i_stb_i,
    input   [2:0] wb_or1200_i_cti_i,
    input   [1:0] wb_or1200_i_bte_i,
    output [31:0] wb_or1200_i_dat_o,
    output        wb_or1200_i_ack_o,
    output        wb_or1200_i_err_o,
    output        wb_or1200_i_rty_o,
    output [31:0] wb_mem_adr_o,
    output [31:0] wb_mem_dat_o,
    output  [3:0] wb_mem_sel_o,
    output        wb_mem_we_o,
    output        wb_mem_cyc_o,
    output        wb_mem_stb_o,
    output  [2:0] wb_mem_cti_o,
    output  [1:0] wb_mem_bte_o,
    input  [31:0] wb_mem_dat_i,
    input         wb_mem_ack_i,
    input         wb_mem_err_i,
    input         wb_mem_rty_i,
    output [31:0] wb_uart_adr_o,
    output [31:0] wb_uart_dat_o,
    output  [3:0] wb_uart_sel_o,
    output        wb_uart_we_o,
    output        wb_uart_cyc_o,
    output        wb_uart_stb_o,
    output  [2:0] wb_uart_cti_o,
    output  [1:0] wb_uart_bte_o,
    input  [31:0] wb_uart_dat_i,
    input         wb_uart_ack_i,
    input         wb_uart_err_i,
    input         wb_uart_rty_i,
    output [31:0] wb_gpio_adr_o,
    output [31:0] wb_gpio_dat_o,
    output  [3:0] wb_gpio_sel_o,
    output        wb_gpio_we_o ,
    output        wb_gpio_cyc_o,
    output        wb_gpio_stb_o,
    output  [2:0] wb_gpio_cti_o,
    output  [1:0] wb_gpio_bte_o,
    input  [31:0] wb_gpio_dat_i,
    input         wb_gpio_ack_i,
    input         wb_gpio_err_i,
    input         wb_gpio_rty_i,
    output [31:0] wb_rom_adr_o,
    output [31:0] wb_rom_dat_o,
    output  [3:0] wb_rom_sel_o,
    output        wb_rom_we_o ,
    output        wb_rom_cyc_o,
    output        wb_rom_stb_o,
    output  [2:0] wb_rom_cti_o,
    output  [1:0] wb_rom_bte_o,
    input  [31:0] wb_rom_dat_i,
    input         wb_rom_ack_i,
    input         wb_rom_err_i,
    input         wb_rom_rty_i,
    output [31:0] wb_i2c_adr_o,
    output [31:0] wb_i2c_dat_o,
    output  [3:0] wb_i2c_sel_o,
    output        wb_i2c_we_o,
    output        wb_i2c_cyc_o,
    output        wb_i2c_stb_o,
    output  [2:0] wb_i2c_cti_o,
    output  [1:0] wb_i2c_bte_o,
    input  [31:0] wb_i2c_dat_i,
    input         wb_i2c_ack_i,
    input         wb_i2c_err_i,
    input         wb_i2c_rty_i,

    output [31:0] wb_spi_adr_o,
    output [31:0] wb_spi_dat_o,
    output  [3:0] wb_spi_sel_o,
    output        wb_spi_we_o,
    output        wb_spi_cyc_o,
    output        wb_spi_stb_o,
    output  [2:0] wb_spi_cti_o,
    output  [1:0] wb_spi_bte_o,
    input  [31:0] wb_spi_dat_i,
    input         wb_spi_ack_i,
    input         wb_spi_err_i,
    input         wb_spi_rty_i,
    output [31:0] wb_fifo0_adr_o,
    output [31:0] wb_fifo0_dat_o,
    output  [3:0] wb_fifo0_sel_o,
    output        wb_fifo0_we_o,
    output        wb_fifo0_cyc_o,   
    output        wb_fifo0_stb_o,
    output  [2:0] wb_fifo0_cti_o,
    output  [1:0] wb_fifo0_bte_o,
    input  [31:0] wb_fifo0_dat_i,
    input         wb_fifo0_ack_i,
    input         wb_fifo0_err_i,
    input         wb_fifo0_rty_i,
    output [31:0] wb_fifo1_adr_o,
    output [31:0] wb_fifo1_dat_o,
    output  [3:0] wb_fifo1_sel_o,
    output        wb_fifo1_we_o,
    output        wb_fifo1_cyc_o,   
    output        wb_fifo1_stb_o,
    output  [2:0] wb_fifo1_cti_o,
    output  [1:0] wb_fifo1_bte_o,
    input  [31:0] wb_fifo1_dat_i,
    input         wb_fifo1_ack_i,
    input         wb_fifo1_err_i,
    input         wb_fifo1_rty_i);

wire [31:0] wb_m2s_or1200_d_mem_adr;
wire [31:0] wb_m2s_or1200_d_mem_dat;
wire  [3:0] wb_m2s_or1200_d_mem_sel;
wire        wb_m2s_or1200_d_mem_we;
wire        wb_m2s_or1200_d_mem_cyc;
wire        wb_m2s_or1200_d_mem_stb;
wire  [2:0] wb_m2s_or1200_d_mem_cti;
wire  [1:0] wb_m2s_or1200_d_mem_bte;
wire [31:0] wb_s2m_or1200_d_mem_dat;
wire        wb_s2m_or1200_d_mem_ack;
wire        wb_s2m_or1200_d_mem_err;
wire        wb_s2m_or1200_d_mem_rty;
wire [31:0] wb_m2s_or1200_i_mem_adr;
wire [31:0] wb_m2s_or1200_i_mem_dat;
wire  [3:0] wb_m2s_or1200_i_mem_sel;
wire        wb_m2s_or1200_i_mem_we;
wire        wb_m2s_or1200_i_mem_cyc;
wire        wb_m2s_or1200_i_mem_stb;
wire  [2:0] wb_m2s_or1200_i_mem_cti;
wire  [1:0] wb_m2s_or1200_i_mem_bte;
wire [31:0] wb_s2m_or1200_i_mem_dat;
wire        wb_s2m_or1200_i_mem_ack;
wire        wb_s2m_or1200_i_mem_err;
wire        wb_s2m_or1200_i_mem_rty;


wb_mux
  #(.num_slaves (7),
    .MATCH_ADDR ({32'h00000000, 32'h90000000, 32'h91000000, 32'ha0000000, 32'hb0000000, 32'hc0000000, 32'hd0000000}),
    .MATCH_MASK ({32'hff800000, 32'hfffffff8, 32'hfffffffe, 32'hfffffff8, 32'hfffffff8, 32'hfffffff8, 32'hfffffff8}))
 wb_mux_or1200_d
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i (wb_or1200_d_adr_i),
    .wbm_dat_i (wb_or1200_d_dat_i),
    .wbm_sel_i (wb_or1200_d_sel_i),
    .wbm_we_i  (wb_or1200_d_we_i),
    .wbm_cyc_i (wb_or1200_d_cyc_i),
    .wbm_stb_i (wb_or1200_d_stb_i),
    .wbm_cti_i (wb_or1200_d_cti_i),
    .wbm_bte_i (wb_or1200_d_bte_i),
    .wbm_dat_o (wb_or1200_d_dat_o),
    .wbm_ack_o (wb_or1200_d_ack_o),
    .wbm_err_o (wb_or1200_d_err_o),
    .wbm_rty_o (wb_or1200_d_rty_o),
    .wbs_adr_o ({wb_m2s_or1200_d_mem_adr, wb_uart_adr_o, wb_gpio_adr_o, wb_i2c_adr_o, wb_spi_adr_o, wb_fifo0_adr_o, wb_fifo1_adr_o }),
    .wbs_dat_o ({wb_m2s_or1200_d_mem_dat, wb_uart_dat_o, wb_gpio_dat_o, wb_i2c_dat_o, wb_spi_dat_o, wb_fifo0_dat_o, wb_fifo1_dat_o }),
    .wbs_sel_o ({wb_m2s_or1200_d_mem_sel, wb_uart_sel_o, wb_gpio_sel_o, wb_i2c_sel_o, wb_spi_sel_o, wb_fifo0_sel_o, wb_fifo1_sel_o }),
    .wbs_we_o  ({wb_m2s_or1200_d_mem_we,  wb_uart_we_o,	 wb_gpio_we_o,  wb_i2c_we_o,  wb_spi_we_o,  wb_fifo0_we_o,  wb_fifo1_we_o }),
    .wbs_cyc_o ({wb_m2s_or1200_d_mem_cyc, wb_uart_cyc_o, wb_gpio_cyc_o, wb_i2c_cyc_o, wb_spi_cyc_o, wb_fifo0_cyc_o, wb_fifo1_cyc_o }),
    .wbs_stb_o ({wb_m2s_or1200_d_mem_stb, wb_uart_stb_o, wb_gpio_stb_o, wb_i2c_stb_o, wb_spi_stb_o, wb_fifo0_stb_o, wb_fifo1_stb_o }),
    .wbs_cti_o ({wb_m2s_or1200_d_mem_cti, wb_uart_cti_o, wb_gpio_cti_o, wb_i2c_cti_o, wb_spi_cti_o, wb_fifo0_cti_o, wb_fifo1_cti_o }),
    .wbs_bte_o ({wb_m2s_or1200_d_mem_bte, wb_uart_bte_o, wb_gpio_bte_o, wb_i2c_bte_o, wb_spi_bte_o, wb_fifo0_bte_o, wb_fifo1_bte_o }),
    .wbs_dat_i ({wb_s2m_or1200_d_mem_dat, wb_uart_dat_i, wb_gpio_dat_i, wb_i2c_dat_i, wb_spi_dat_i, wb_fifo0_dat_i, wb_fifo1_dat_i }),
    .wbs_ack_i ({wb_s2m_or1200_d_mem_ack, wb_uart_ack_i, wb_gpio_ack_i, wb_i2c_ack_i, wb_spi_ack_i, wb_fifo0_ack_i, wb_fifo1_ack_i }),
    .wbs_err_i ({wb_s2m_or1200_d_mem_err, wb_uart_err_i, wb_gpio_err_i, wb_i2c_err_i, wb_spi_err_i, wb_fifo0_err_i, wb_fifo1_err_i }),
    .wbs_rty_i ({wb_s2m_or1200_d_mem_rty, wb_uart_rty_i, wb_gpio_rty_i, wb_i2c_rty_i, wb_spi_rty_i, wb_fifo0_rty_i, wb_fifo1_rty_i }));



wb_mux
  #(.num_slaves (2),
    .MATCH_ADDR ({32'h00000000, 32'hf0000200}),
    .MATCH_MASK ({32'hfe000000, 32'hfffffE00}))
 wb_mux_or1200_i
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i (wb_or1200_i_adr_i),
    .wbm_dat_i (wb_or1200_i_dat_i),
    .wbm_sel_i (wb_or1200_i_sel_i),
    .wbm_we_i  (wb_or1200_i_we_i ),
    .wbm_cyc_i (wb_or1200_i_cyc_i),
    .wbm_stb_i (wb_or1200_i_stb_i),
    .wbm_cti_i (wb_or1200_i_cti_i),
    .wbm_bte_i (wb_or1200_i_bte_i),
    .wbm_dat_o (wb_or1200_i_dat_o),
    .wbm_ack_o (wb_or1200_i_ack_o),
    .wbm_err_o (wb_or1200_i_err_o),
    .wbm_rty_o (wb_or1200_i_rty_o),	 
    .wbs_adr_o ({wb_m2s_or1200_i_mem_adr, wb_rom_adr_o }),
    .wbs_dat_o ({wb_m2s_or1200_i_mem_dat, wb_rom_dat_o }),
    .wbs_sel_o ({wb_m2s_or1200_i_mem_sel, wb_rom_sel_o }),
    .wbs_we_o  ({wb_m2s_or1200_i_mem_we,  wb_rom_we_o  }),
    .wbs_cyc_o ({wb_m2s_or1200_i_mem_cyc, wb_rom_cyc_o }),
    .wbs_stb_o ({wb_m2s_or1200_i_mem_stb, wb_rom_stb_o }),
    .wbs_cti_o ({wb_m2s_or1200_i_mem_cti, wb_rom_cti_o }),
    .wbs_bte_o ({wb_m2s_or1200_i_mem_bte, wb_rom_bte_o }),
    .wbs_dat_i ({wb_s2m_or1200_i_mem_dat, wb_rom_dat_i }),
    .wbs_ack_i ({wb_s2m_or1200_i_mem_ack, wb_rom_ack_i }),
    .wbs_err_i ({wb_s2m_or1200_i_mem_err, wb_rom_err_i }),
    .wbs_rty_i ({wb_s2m_or1200_i_mem_rty, wb_rom_rty_i }));


wb_arbiter
  #(.num_masters (2))
 wb_arbiter_mem
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),   		  
    .wbm_adr_i ({wb_m2s_or1200_d_mem_adr, wb_m2s_or1200_i_mem_adr}),
    .wbm_dat_i ({wb_m2s_or1200_d_mem_dat, wb_m2s_or1200_i_mem_dat}),
    .wbm_sel_i ({wb_m2s_or1200_d_mem_sel, wb_m2s_or1200_i_mem_sel}),
    .wbm_we_i  ({wb_m2s_or1200_d_mem_we,  wb_m2s_or1200_i_mem_we }),
    .wbm_cyc_i ({wb_m2s_or1200_d_mem_cyc, wb_m2s_or1200_i_mem_cyc}),
    .wbm_stb_i ({wb_m2s_or1200_d_mem_stb, wb_m2s_or1200_i_mem_stb}),
    .wbm_cti_i ({wb_m2s_or1200_d_mem_cti, wb_m2s_or1200_i_mem_cti}),
    .wbm_bte_i ({wb_m2s_or1200_d_mem_bte, wb_m2s_or1200_i_mem_bte}),
    .wbm_dat_o ({wb_s2m_or1200_d_mem_dat, wb_s2m_or1200_i_mem_dat}),
    .wbm_ack_o ({wb_s2m_or1200_d_mem_ack, wb_s2m_or1200_i_mem_ack}),
    .wbm_err_o ({wb_s2m_or1200_d_mem_err, wb_s2m_or1200_i_mem_err}),
    .wbm_rty_o ({wb_s2m_or1200_d_mem_rty, wb_s2m_or1200_i_mem_rty}),
    .wbs_adr_o (wb_mem_adr_o),
    .wbs_dat_o (wb_mem_dat_o),
    .wbs_sel_o (wb_mem_sel_o),
    .wbs_we_o  (wb_mem_we_o),
    .wbs_cyc_o (wb_mem_cyc_o),
    .wbs_stb_o (wb_mem_stb_o),
    .wbs_cti_o (wb_mem_cti_o),
    .wbs_bte_o (wb_mem_bte_o),
    .wbs_dat_i (wb_mem_dat_i),
    .wbs_ack_i (wb_mem_ack_i),
    .wbs_err_i (wb_mem_err_i),
    .wbs_rty_i (wb_mem_rty_i));

endmodule
