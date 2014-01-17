//////////////////////////////////////////////////////////////////////
///   write error mensage with GPIO                               //// 
//////////////////////////////////////////////////////////////////////

#define SPI_BASE 0xb0000000
/* simple_spi driver */	
#define SPI_SPCR 0x0
#define SPI_SPSR 0x1
#define SPI_SPDR 0x2
#define SPI_SPER 0x3
#define SPI_SPSS 0x4 	//adresse select slave

#define BOOTROM_ADDR_BYTE2 0x0
#define BOOTROM_ADDR_BYTE1 0x0
#define BOOTROM_ADDR_BYTE0 0x0

#define SPI_SPCR_XFER_GO 0xFF 	// start SPI
#define SPI_SPSS_INIT 0x1	//sleext slave SPI
#define SPI_SPSR_RX_CHECK 0x01 /* Check bit 0 is cleared, fifo !empty*/
	
#define RAM_LOAD_BASE 0x00000000
#define ROM_LOAD_BASE 0xF0000000
#define UART_BASE 0x90000000
#define GPIO_BASE 0x91000000
#define RESET_ADDR 0x100

boot_init:	
	l.movhi r0, 0
	l.movhi r1, RAM_LOAD_BASE
	l.movhi r2, 0xF000
	l.movhi r4, hi(SPI_BASE)
        l.movhi r10, hi(GPIO_BASE)

erro_mensage:
	l.ori 	r3, r0, 0xFF	//select all pin
	l.addi 	r8, r10, 0x01
	l.sb 	0(r8), r3
	l.ori 	r3, r0, 0x01	//select all pin
	l.addi 	r8, r10, 0x00
	l.sb 	0(r8), r3



