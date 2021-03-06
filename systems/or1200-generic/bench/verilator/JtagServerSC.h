/*
 * TCP/IP controlled JTAG Interface.
 * Based on Julius Baxter's work on jp_vpi.c
 *
 * Copyright (C) 2013 Jose T. de Sousa, <jts@inesc-id.pt>
 *
 * See file CREDITS for list of people who contributed to this
 * project.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 */

#define CMD_RESET		0
#define CMD_TMS_SEQ		1
#define CMD_SCAN_CHAIN		2
#define CMD_SCAN_CHAIN_FLIP_TMS	3
#define CMD_STOP_SIMU		4

#include "systemc"

class JtagServerSC:public sc_core::sc_module {
public:

	// The ports. Note that the naming of the low level JTAG ports is reversed,
	// because we are driving the inputs! */
	sc_core::sc_in < bool > sysReset;	//!< The system reset (active high)

	sc_core::sc_in < bool > tck;	//!< External JTAG TCK
	sc_core::sc_out < bool > tdi;	//!< JTAG TDI pin
	sc_core::sc_in < bool > tdo;	//!< JTAG TDO pin
	sc_core::sc_out < bool > tms;	//!< JTAG TMS pin
	sc_core::sc_out < bool > trst;	//!< JTAG TRST pin

	// Constructor and destructor
	JtagServerSC(sc_core::sc_module_name name);
	~JtagServerSC();

	// Main thread
	void MainThread();

protected:


private:
	void ResetTap();
	void GotoRunTestIdle();

};				// JtagServerSC ()

