//////////////////////////////////////////////////////////////////////
///   write error mensage with uart                               //// 
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
#define RESET_ADDR 0x100

boot_init:	
	l.movhi r0, 0
	l.movhi r1, RAM_LOAD_BASE
	l.movhi r2, 0xF000
	l.movhi r4, hi(SPI_BASE)
        l.movhi r10, hi(UART_BASE)

erro_mensage:
	l.ori 	r3, r0, 0xC7	//inicializacao
	l.addi 	r8, r10, 0x02
	l.sb 	0(r8), r3
	l.ori 	r3, r0, 0x0	//inicializacao
	l.addi 	r8, r10, 0x01
	l.sb 	0(r8), r3
	l.ori 	r3, r0, 0x83	//inicializacao
	l.addi 	r8, r10, 0x3
	l.sb 	0(r8), r3
	l.ori 	r3, r0, 0x36	//inicializacao
	l.addi 	r8, r10, 0x00
	l.sb 	0(r8), r3
	l.ori 	r3, r0, 0x00	//inicializacao
	l.addi 	r8, r10, 0x01
	l.sb 	0(r8), r3
	l.ori 	r3, r0, 0x03	//inicializacao
	l.addi 	r8, r10, 0x03
	l.sb 	0(r8), r3

	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x43	//C
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x4F	//O
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x4D	//M
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x4D	//M
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x55	//U
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x4E	//N
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x49	//I
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x43	//C
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x41	//A
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x54	//T //10
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x49	//I
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x4F	//O
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x4E	//N
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x20	//Space
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x50	//P
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x52	//R
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x4F	//O
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x42	//B
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x4C	//L
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x45	//E //20
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x4D	//M
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x20	//space
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3



	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x52	//R
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x45	//E
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x41	//A
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x44	//D
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x20	//Space
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x46	//F
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x4C	//L
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x41	//A  //30
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x53	//S
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x48	//H
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3


	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x20	//space
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x4F	//O
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x52	//R
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x20	//Space
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3


	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x57	//W
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x52	//R
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x49	//I
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x54	//T
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x45	//E
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x20	//Space
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x4D	//M
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x45	//E
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x4D	//M
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x4F	//O
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x52	//R
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x59	//Y
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x0A	//\n
	l.addi 	r8, r10, 0x0
	l.sb 	0(r8), r3
	l.j	goto_reset

busy:
        l.ori	r4, r0, 0x0060
busy_next:
	l.addi 	 r8, r10, 0x05
	l.lbz 	 r3, 0(r8)
	l.sfeq   r3,r4
	l.bnf 	 busy_next
	l.nop
	l.jr 	r9
	l.nop

