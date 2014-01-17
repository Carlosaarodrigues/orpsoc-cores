//////////////////////////////////////////////////////////////////////
///                                                               //// 
/// bootrom                                                       ////
///                                                               ////
/// Assembly programs to be embedded inside system to aid boot    ////
///                                                               ////
/// Julius Baxter, julius@opencores.org                           ////
///                                                               ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2009, 2010 Authors and OPENCORES.ORG           ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////

// Defines for which bootrom app to use are in board.h - TODO: use the
// processed orspoc-defines.v file for this define. It makes more sense
// as this software ends up as gates.
	
#define BOOTROM_SPI_FLASH
#define SPI_RETRY_IF_INSANE_SIZEWORD
#define ERROR_MENSAGE_UART
#define ERROR_MENSAGE_GPIO

#ifdef BOOTROM_SPI_FLASH
	
	/* Assembly program to go into the boot ROM */
	/* For use with simple_spi SPI master core and standard SPI flash
	   interface-compatible parts (ST M25P16 for example.)*/
	/* Currently just loads a program from SPI flash into RAM */
	/* Assuming address at RAM_LOAD_BASE gets clobbered, we need
	   a byte writable address somewhere!*/

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
#define UART_BASE 0x90000000
#define GPIO_BASE 0x91000000
#define RESET_ADDR 0x100

boot_init:	
	l.movhi r0, 0
	l.movhi r13, 0
	l.movhi r1, RAM_LOAD_BASE
	l.movhi r4, hi(SPI_BASE)
	l.movhi r5, hi(UART_BASE)
       	l.movhi r11, hi(GPIO_BASE)
	
spi_init:
	l.ori 	r2, r0, SPI_SPCR_XFER_GO /* Setup SPCR with enable bit set */
	l.sb  	SPI_SPSS(r4), r0         /* Clear SPI slave selects */
	l.sb 	SPI_SPCR(r4), r2
	l.sb 	SPI_SPER(r4), r2
	l.ori 	r6, r0, SPI_SPSS_INIT
	l.sb  	SPI_SPSS(r4), r6         /* Set appropriate slave select */
	l.ori 	r3, r0, 0x3              /* READ command opcode for SPI device*///10
	l.sb SPI_SPDR(r4), r3
#ifdef BOOTROM_ADDR_BYTE2
	l.ori 	r3, r0, BOOTROM_ADDR_BYTE2 /* Use addr if defined. MSB first */
#else	
	l.or 	r3, r0, r0
#endif	
	l.sb SPI_SPDR(r4), r3
#ifdef BOOTROM_ADDR_BYTE1
	l.ori 	r3, r0, BOOTROM_ADDR_BYTE1
#else	
	l.or 	r3, r0, r0
#endif	
	l.sb SPI_SPDR(r4), r3
#ifdef BOOTROM_ADDR_BYTE0
	l.ori 	r3, r0, BOOTROM_ADDR_BYTE0
#else	
	l.or 	r3, r0, r0
#endif	
	l.sb SPI_SPDR(r4), r3
	l.movhi r6, 0
	l.movhi r7, 0x01
	l.ori	r7,r7,0XFFFF	//20

copy:	
	l.nop
	l.lbz 	r3, SPI_SPDR(r4) /* Read a byte into r3 */
	l.add 	r8, r1, r6       /* Calculate store address */
	l.sb 	0(r8), r3        /* Write byte to memory */
	l.addi 	r6, r6, 1        /* Increment counter */
	l.sfeqi r6, 0x101          /* read addr 100 ?*/
	l.bf 	store_read_spi   /* put sizeword in the register */
	l.sfeqi r6, 0x104          /* Is this the first word ?*/
	l.bf 	store_write_mem   /* put sizeword in the register */
	l.sfeq 	r6, r7           /* Check if we've finished loading the words */
	l.bnf 	copy             /* Continue copying if not last word */
	l.nop			

goto_reset:  
	l.mtspr r0,r1,0x11	//change select bit EPH		//30
	l.ori 	r1, r1, RESET_ADDR //program pointer --> 0x100
	l.jr 	r1
	l.sb  	SPI_SPSS(r4), r0 /* Clear SPI slave selects */


//write mensage in uart and GPIO "problem write memory"
store_write_mem:
#ifdef SPI_RETRY_IF_INSANE_SIZEWORD
	l.lwz 	r3, 0x0100(r1)        
	l.srli	r10, r3, 16	 /* Chop the sizeword we read in half */
	l.sfeqi r10, 0x1800	 /* It's unlikely we'll ever load > 32MB */
	l.bnf	erro_mensage_ram	 /* send error mensage by uart */
	l.nop
	l.j 	copy
	l.nop
#else	
	l.j 	copy		
	l.lwz 	r7, 0(r1)         /* Size word is in first word of SDRAM */
#endif

//write mensage in uart and GPIO "problem read spi"
store_read_spi:
#ifdef SPI_RETRY_IF_INSANE_SIZEWORD
	l.sfeqi r3, 0x18	 /* It's unlikely we'll ever load > 32MB */
	l.bnf	erro_mensage_spi	 /* send error mensage by uart */
	l.nop
	l.j 	copy
	l.nop
#else	
	l.j 	copy		
	l.lwz 	r7, 0(r1)         /* Size word is in first word of SDRAM */
#endif	

	
#ifdef SPI_RETRY_IF_INSANE_SIZEWORD
//send mensage memory error
erro_mensage_ram:
	l.nop		//40
#ifdef ERROR_MENSAGE_GPIO
	l.ori 	r3, r0, 0xFF	//select all pin
	l.addi 	r8, r11, 0x01
	l.sb 	0(r8), r3
	l.ori 	r3, r13, 0x05	//send error code
	l.addi 	r8, r11, 0x00
	l.sb 	0(r8), r3
#endif

#ifdef ERROR_MENSAGE_UART
	l.jal	geral_mensage	//send for uart "comunication problem"
	l.nop
	l.j	write_mensage	//send for uart "write memory"
#else
	l.j	goto_reset
#endif	


//send mensage spi error
erro_mensage_spi:
	l.nop		//40
#ifdef ERROR_MENSAGE_GPIO
	l.ori 	r3, r0, 0xFF	//select all pin
	l.addi 	r8, r11, 0x01
	l.sb 	0(r8), r3
	l.ori 	r3, r13, 0x03	//send error code
	l.addi 	r8, r11, 0x00
	l.sb 	0(r8), r3
#endif

#ifdef ERROR_MENSAGE_UART
	l.jal	geral_mensage	//send for uart "comunication problem"
	l.nop
	l.j	read_mensage	//send for uart "write memory"
#else
	l.j	goto_reset
#endif	

//mensage's
#ifdef ERROR_MENSAGE_UART
geral_mensage:
	l.or	r12,r0,r9
	l.ori 	r3, r0, 0xC7	//inicializacao
	l.addi 	r8, r5, 0x02
	l.sb 	0(r8), r3
	l.ori 	r3, r0, 0x0	//inicializacao
	l.addi 	r8, r5, 0x01
	l.sb 	0(r8), r3
	l.ori 	r3, r0, 0x83	//inicializacao
	l.addi 	r8, r5, 0x3
	l.sb 	0(r8), r3
	l.ori 	r3, r0, 0x36	//inicializacao
	l.addi 	r8, r5, 0x00
	l.sb 	0(r8), r3
	l.ori 	r3, r0, 0x00	//inicializacao
	l.addi 	r8, r5, 0x01
	l.sb 	0(r8), r3
	l.ori 	r3, r0, 0x03	//inicializacao
	l.addi 	r8, r5, 0x03
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x43	//C
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x4F	//O
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x4D	//M
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x4D	//M
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x55	//U
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x4E	//N
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x49	//I
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x43	//C
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x41	//A
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x54	//T //10
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x49	//I
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x4F	//O
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x4E	//N
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x20	//Space
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x50	//P
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x52	//R
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x4F	//O
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x42	//B
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x4C	//L
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x45	//E //20
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x4D	//M
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x20	//space
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jr 	r12
	l.nop	

write_mensage:
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x57	//W
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x52	//R
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x49	//I
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x54	//T
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x45	//E
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x20	//Space
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x4D	//M
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x45	//E
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x4D	//M
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x4F	//O
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x52	//R
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x59	//Y
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x0A	//\n
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.j	goto_reset

read_mensage:
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x52	//R
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x45	//E
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x41	//A
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x44	//D
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x20	//Space
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x46	//F
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x4C	//L
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x41	//A  //30
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x53	//S
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x48	//H
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.jal	busy
	l.nop
	l.ori 	r3, r0, 0x0A	//\n
	l.addi 	r8, r5, 0x0
	l.sb 	0(r8), r3
	l.j	goto_reset


busy:
        l.ori	r4, r0, 0x0060
busy_next:
	l.addi 	 r8, r5, 0x05
	l.lbz 	 r3, 0(r8)
	l.sfeq   r3,r4
	l.bnf 	 busy_next
	l.nop
	l.jr 	r9
	l.nop	

#endif

#endif //#ifdef SPI_RETRY_IF_INSANE_SIZEWORD


/////////////////////////////////////////////////////////////

#endif

#ifdef BOOTROM_GOTO_RESET
	/* Jump to reset vector in the SDRAM */
	l.movhi r0, 0
	l.movhi r4, SDRAM_BASE
	l.ori 	r4, r4, 0x100
	l.jr 	r4
	l.nop
	
#endif	

#ifdef BOOTROM_LOOP_AT_ZERO

	/* Don't load app via SPI, instead just put an infinite loop into bottom
	of memory and jump there.
	*/
	l.movhi r0, 0
	l.movhi r4, SDRAM_BASE
	l.sw 	0x0(r4), r0
	l.movhi r5, hi(0x15000001) /* A l.nop 1 so sim exits if this enabled */
	l.ori 	r5, r5, lo(0x15000001)
	l.sw 	0x4(r4), r5
	l.sw 	0x8(r4), r5
	l.sw 	0xc(r4), r5
	l.jr 	r4
	l.nop

	

#endif

#ifdef BOOTROM_LOOP_IN_ROM

	/* Don't load app via SPI, instead just put an infinite loop into bottom
	of memory and jump there.
	*/
	l.movhi r0, 0
	l.nop 	0x1
	l.j 	0
	l.nop
	l.nop 
#endif
