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

#include <iostream>
using namespace std;

#include "JtagServerSC.h"
using namespace sc_core;
using sc_core::sc_fifo;
using sc_core::sc_module_name;
using sc_core::sc_stop;
using sc_core::sc_time;

SC_HAS_PROCESS(JtagServerSC);


JtagServerSC::JtagServerSC(sc_core::sc_module_name name){

	cout << "Launching JTAG Server...";
	//Launch SysC thread
	SC_THREAD(MainThread);
}				//JtagServerSC

JtagServerSC::~JtagServerSC()
{
	cout << "Destructor must exist and have non-empty body";

}				// ~JtagServerSC

void JtagServerSC::MainThread(){

	ResetTap();
	GotoRunTestIdle();

	tdi = 1;
	tms = 1;

	cout << "Running Jtag Server...\n";
	//while(1);
}				//MainThread



void JtagServerSC::ResetTap(){
	cout << "Resetting Tap...\n";
}

void JtagServerSC::GotoRunTestIdle(){
	cout << "Going to Run Test / Idle...\n";
}

