wire [31:0] wb_m2s_or1200_d_adr;
wire [31:0] wb_m2s_or1200_d_dat;
wire  [3:0] wb_m2s_or1200_d_sel;
wire        wb_m2s_or1200_d_we;
wire        wb_m2s_or1200_d_cyc;
wire        wb_m2s_or1200_d_stb;
wire  [2:0] wb_m2s_or1200_d_cti;
wire  [1:0] wb_m2s_or1200_d_bte;
wire [31:0] wb_s2m_or1200_d_dat;
wire        wb_s2m_or1200_d_ack;
wire        wb_s2m_or1200_d_err;
wire        wb_s2m_or1200_d_rty;
wire [31:0] wb_m2s_or1200_i_adr;
wire [31:0] wb_m2s_or1200_i_dat;
wire  [3:0] wb_m2s_or1200_i_sel;
wire        wb_m2s_or1200_i_we;
wire        wb_m2s_or1200_i_cyc;
wire        wb_m2s_or1200_i_stb;
wire  [2:0] wb_m2s_or1200_i_cti;
wire  [1:0] wb_m2s_or1200_i_bte;
wire [31:0] wb_s2m_or1200_i_dat;
wire        wb_s2m_or1200_i_ack;
wire        wb_s2m_or1200_i_err;
wire        wb_s2m_or1200_i_rty;
wire [31:0] wb_m2s_mem_adr;
wire [31:0] wb_m2s_mem_dat;
wire  [3:0] wb_m2s_mem_sel;
wire        wb_m2s_mem_we;
wire        wb_m2s_mem_cyc;
wire        wb_m2s_mem_stb;
wire  [2:0] wb_m2s_mem_cti;
wire  [1:0] wb_m2s_mem_bte;
wire [31:0] wb_s2m_mem_dat;
wire        wb_s2m_mem_ack;
wire        wb_s2m_mem_err;
wire        wb_s2m_mem_rty;
wire [31:0] wb_m2s_uart_adr;
wire [31:0] wb_m2s_uart_dat;
wire  [3:0] wb_m2s_uart_sel;
wire        wb_m2s_uart_we;
wire        wb_m2s_uart_cyc;
wire        wb_m2s_uart_stb;
wire  [2:0] wb_m2s_uart_cti;
wire  [1:0] wb_m2s_uart_bte;
wire [31:0] wb_s2m_uart_dat;
wire        wb_s2m_uart_ack;
wire        wb_s2m_uart_err;
wire        wb_s2m_uart_rty;
wire [31:0] wb_m2s_gpio_adr;
wire [31:0] wb_m2s_gpio_dat;
wire  [3:0] wb_m2s_gpio_sel;
wire        wb_m2s_gpio_we ;
wire        wb_m2s_gpio_cyc;
wire        wb_m2s_gpio_stb;
wire  [2:0] wb_m2s_gpio_cti;
wire  [1:0] wb_m2s_gpio_bte;
wire [31:0] wb_s2m_gpio_dat;
wire        wb_s2m_gpio_ack;
wire        wb_s2m_gpio_err;
wire        wb_s2m_gpio_rty;
wire [31:0] wb_m2s_rom_adr;
wire [31:0] wb_m2s_rom_dat;
wire  [3:0] wb_m2s_rom_sel;
wire        wb_m2s_rom_we ;
wire        wb_m2s_rom_cyc;
wire        wb_m2s_rom_stb;
wire  [2:0] wb_m2s_rom_cti;
wire  [1:0] wb_m2s_rom_bte;
wire [31:0] wb_s2m_rom_dat;
wire        wb_s2m_rom_ack;
wire        wb_s2m_rom_err;
wire        wb_s2m_rom_rty;
wire [31:0] wb_m2s_i2c_adr;
wire [31:0] wb_m2s_i2c_dat;
wire  [3:0] wb_m2s_i2c_sel;
wire        wb_m2s_i2c_we ;
wire        wb_m2s_i2c_cyc;
wire        wb_m2s_i2c_stb;
wire  [2:0] wb_m2s_i2c_cti;
wire  [1:0] wb_m2s_i2c_bte;
wire [31:0] wb_s2m_i2c_dat;
wire        wb_s2m_i2c_ack;
wire        wb_s2m_i2c_err;
wire        wb_s2m_i2c_rty;
wire [31:0] wb_m2s_spi_adr;
wire [31:0] wb_m2s_spi_dat;
wire  [3:0] wb_m2s_spi_sel;
wire        wb_m2s_spi_we ;
wire        wb_m2s_spi_cyc;
wire        wb_m2s_spi_stb;
wire  [2:0] wb_m2s_spi_cti;
wire  [1:0] wb_m2s_spi_bte;
wire [31:0] wb_s2m_spi_dat;
wire        wb_s2m_spi_ack;
wire        wb_s2m_spi_err;
wire        wb_s2m_spi_rty;
wire [31:0] wb_m2s_fifo0_adr;
wire [31:0] wb_m2s_fifo0_dat;
wire  [3:0] wb_m2s_fifo0_sel;
wire        wb_m2s_fifo0_we ;
wire        wb_m2s_fifo0_cyc;   
wire        wb_m2s_fifo0_stb;
wire  [2:0] wb_m2s_fifo0_cti;
wire  [1:0] wb_m2s_fifo0_bte;
wire [31:0] wb_s2m_fifo0_dat;
wire        wb_s2m_fifo0_ack;
wire        wb_s2m_fifo0_err;
wire        wb_s2m_fifo0_rty;
wire [31:0] wb_m2s_fifo1_adr;
wire [31:0] wb_m2s_fifo1_dat;
wire  [3:0] wb_m2s_fifo1_sel;
wire        wb_m2s_fifo1_we ;
wire        wb_m2s_fifo1_cyc;   
wire        wb_m2s_fifo1_stb;
wire  [2:0] wb_m2s_fifo1_cti;
wire  [1:0] wb_m2s_fifo1_bte;
wire [31:0] wb_s2m_fifo1_dat;
wire        wb_s2m_fifo1_ack;
wire        wb_s2m_fifo1_err;
wire        wb_s2m_fifo1_rty;


wb_intercon wb_intercon0
   (.wb_clk_i          (wb_clk),
    .wb_rst_i          (wb_rst),
    .wb_or1200_d_adr_i (wb_m2s_or1200_d_adr),
    .wb_or1200_d_dat_i (wb_m2s_or1200_d_dat),
    .wb_or1200_d_sel_i (wb_m2s_or1200_d_sel),
    .wb_or1200_d_we_i  (wb_m2s_or1200_d_we),
    .wb_or1200_d_cyc_i (wb_m2s_or1200_d_cyc),
    .wb_or1200_d_stb_i (wb_m2s_or1200_d_stb),
    .wb_or1200_d_cti_i (wb_m2s_or1200_d_cti),
    .wb_or1200_d_bte_i (wb_m2s_or1200_d_bte),
    .wb_or1200_d_dat_o (wb_s2m_or1200_d_dat),
    .wb_or1200_d_ack_o (wb_s2m_or1200_d_ack),
    .wb_or1200_d_err_o (wb_s2m_or1200_d_err),
    .wb_or1200_d_rty_o (wb_s2m_or1200_d_rty),
    .wb_or1200_i_adr_i (wb_m2s_or1200_i_adr),
    .wb_or1200_i_dat_i (wb_m2s_or1200_i_dat),
    .wb_or1200_i_sel_i (wb_m2s_or1200_i_sel),
    .wb_or1200_i_we_i  (wb_m2s_or1200_i_we),
    .wb_or1200_i_cyc_i (wb_m2s_or1200_i_cyc),
    .wb_or1200_i_stb_i (wb_m2s_or1200_i_stb),
    .wb_or1200_i_cti_i (wb_m2s_or1200_i_cti),
    .wb_or1200_i_bte_i (wb_m2s_or1200_i_bte),
    .wb_or1200_i_dat_o (wb_s2m_or1200_i_dat),
    .wb_or1200_i_ack_o (wb_s2m_or1200_i_ack),
    .wb_or1200_i_err_o (wb_s2m_or1200_i_err),
    .wb_or1200_i_rty_o (wb_s2m_or1200_i_rty),
    .wb_mem_adr_o      (wb_m2s_mem_adr),
    .wb_mem_dat_o      (wb_m2s_mem_dat),
    .wb_mem_sel_o      (wb_m2s_mem_sel),
    .wb_mem_we_o       (wb_m2s_mem_we),
    .wb_mem_cyc_o      (wb_m2s_mem_cyc),
    .wb_mem_stb_o      (wb_m2s_mem_stb),
    .wb_mem_cti_o      (wb_m2s_mem_cti),
    .wb_mem_bte_o      (wb_m2s_mem_bte),
    .wb_mem_dat_i      (wb_s2m_mem_dat),
    .wb_mem_ack_i      (wb_s2m_mem_ack),
    .wb_mem_err_i      (wb_s2m_mem_err),
    .wb_mem_rty_i      (wb_s2m_mem_rty),
    .wb_uart_adr_o     (wb_m2s_uart_adr),
    .wb_uart_dat_o     (wb_m2s_uart_dat),
    .wb_uart_sel_o     (wb_m2s_uart_sel),
    .wb_uart_we_o      (wb_m2s_uart_we),
    .wb_uart_cyc_o     (wb_m2s_uart_cyc),
    .wb_uart_stb_o     (wb_m2s_uart_stb),
    .wb_uart_cti_o     (wb_m2s_uart_cti),
    .wb_uart_bte_o     (wb_m2s_uart_bte),
    .wb_uart_dat_i     (wb_s2m_uart_dat),
    .wb_uart_ack_i     (wb_s2m_uart_ack),
    .wb_uart_err_i     (wb_s2m_uart_err),
    .wb_uart_rty_i     (wb_s2m_uart_rty),
    .wb_gpio_adr_o     (wb_m2s_gpio_adr),
    .wb_gpio_dat_o     (wb_m2s_gpio_dat),
    .wb_gpio_sel_o     (wb_m2s_gpio_sel),
    .wb_gpio_we_o      (wb_m2s_gpio_we ),
    .wb_gpio_cyc_o     (wb_m2s_gpio_cyc),
    .wb_gpio_stb_o     (wb_m2s_gpio_stb),
    .wb_gpio_cti_o     (wb_m2s_gpio_cti),
    .wb_gpio_bte_o     (wb_m2s_gpio_bte),
    .wb_gpio_dat_i     (wb_s2m_gpio_dat),
    .wb_gpio_ack_i     (wb_s2m_gpio_ack),
    .wb_gpio_err_i     (wb_s2m_gpio_err),
    .wb_gpio_rty_i     (wb_s2m_gpio_rty),
    .wb_rom_adr_o      (wb_m2s_rom_adr),
    .wb_rom_dat_o      (wb_m2s_rom_dat),
    .wb_rom_sel_o      (wb_m2s_rom_sel),
    .wb_rom_we_o       (wb_m2s_rom_we ),
    .wb_rom_cyc_o      (wb_m2s_rom_cyc),
    .wb_rom_stb_o      (wb_m2s_rom_stb),
    .wb_rom_cti_o      (wb_m2s_rom_cti),
    .wb_rom_bte_o      (wb_m2s_rom_bte),
    .wb_rom_dat_i      (wb_s2m_rom_dat),
    .wb_rom_ack_i      (wb_s2m_rom_ack),
    .wb_rom_err_i      (wb_s2m_rom_err),
    .wb_rom_rty_i      (wb_s2m_rom_rty),
    .wb_i2c_adr_o      (wb_m2s_i2c_adr),
    .wb_i2c_dat_o      (wb_m2s_i2c_dat),
    .wb_i2c_sel_o      (wb_m2s_i2c_sel),
    .wb_i2c_we_o       (wb_m2s_i2c_we),
    .wb_i2c_cyc_o      (wb_m2s_i2c_cyc),
    .wb_i2c_stb_o      (wb_m2s_i2c_stb),
    .wb_i2c_cti_o      (wb_m2s_i2c_cti),
    .wb_i2c_bte_o      (wb_m2s_i2c_bte),
    .wb_i2c_dat_i      (wb_s2m_i2c_dat),
    .wb_i2c_ack_i      (wb_s2m_i2c_ack),
    .wb_i2c_err_i      (wb_s2m_i2c_err),
    .wb_i2c_rty_i      (wb_s2m_i2c_rty),
    .wb_spi_adr_o      (wb_m2s_spi_adr),
    .wb_spi_dat_o      (wb_m2s_spi_dat),
    .wb_spi_sel_o      (wb_m2s_spi_sel),
    .wb_spi_we_o       (wb_m2s_spi_we ),
    .wb_spi_cyc_o      (wb_m2s_spi_cyc),
    .wb_spi_stb_o      (wb_m2s_spi_stb),
    .wb_spi_cti_o      (wb_m2s_spi_cti),
    .wb_spi_bte_o      (wb_m2s_spi_bte),
    .wb_spi_dat_i      (wb_s2m_spi_dat),
    .wb_spi_ack_i      (wb_s2m_spi_ack),
    .wb_spi_err_i      (wb_s2m_spi_err),
    .wb_spi_rty_i      (wb_s2m_spi_rty),
    .wb_fifo0_adr_o    (wb_m2s_fifo0_adr),
    .wb_fifo0_dat_o    (wb_m2s_fifo0_dat), 
    .wb_fifo0_sel_o    (wb_m2s_fifo0_sel),
    .wb_fifo0_we_o     (wb_m2s_fifo0_we ),  
    .wb_fifo0_cyc_o    (wb_m2s_fifo0_cyc),       
    .wb_fifo0_stb_o    (wb_m2s_fifo0_stb),      
    .wb_fifo0_cti_o    (wb_m2s_fifo0_cti),       
    .wb_fifo0_bte_o    (wb_m2s_fifo0_bte), 
    .wb_fifo0_dat_i    (wb_s2m_fifo0_dat),      
    .wb_fifo0_ack_i    (wb_s2m_fifo0_ack),
    .wb_fifo0_err_i    (wb_s2m_fifo0_err),
    .wb_fifo0_rty_i    (wb_s2m_fifo0_rty),
    .wb_fifo1_adr_o    (wb_m2s_fifo1_adr),
    .wb_fifo1_dat_o    (wb_m2s_fifo1_dat), 
    .wb_fifo1_sel_o    (wb_m2s_fifo1_sel),
    .wb_fifo1_we_o     (wb_m2s_fifo1_we ),  
    .wb_fifo1_cyc_o    (wb_m2s_fifo1_cyc),       
    .wb_fifo1_stb_o    (wb_m2s_fifo1_stb),      
    .wb_fifo1_cti_o    (wb_m2s_fifo1_cti),       
    .wb_fifo1_bte_o    (wb_m2s_fifo1_bte), 
    .wb_fifo1_dat_i    (wb_s2m_fifo1_dat),      
    .wb_fifo1_ack_i    (wb_s2m_fifo1_ack),
    .wb_fifo1_err_i    (wb_s2m_fifo1_err),
    .wb_fifo1_rty_i    (wb_s2m_fifo1_rty));




