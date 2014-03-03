# Makefile for bootROM Verilog

# Whenever PRELOAD_RAM is defined on command line, we probably want the bootrom
# to be jumping to reset instead of doing a full boot preload.


# Set V=1 when calling make to enable verbose output
# mainly for debugging purposes.
ifeq ($(V), 1)
Q=
else
Q ?=@
endif

OR1K_TOOL_PREFIX = or1k-elf-
OR1K_CC=$(OR1K_TOOL_PREFIX)gcc
OR1K_OBJCOPY=$(OR1K_TOOL_PREFIX)objcopy

CC = gcc
CFLAGS = -O2 -Wall


all: bootrom.v

%.v: %.bin utils/bin2vlogarray
$(Q) utils/bin2vlogarray < $< > $@

%.bin: %.o
$(Q)$(OR1K_OBJCOPY) -O binary $< $@

utils/bin2vlogarray: utils/bin2vlogarray.c
$(CC) -o $@ $(CFLAGS) $<

%.o: %.S
$(Q)$(OR1K_CC) $(OR1K_CFLAGS) -c $< -o $@

clean:
rm -f *.o *.bin *.hex *.in *.dis *.v utils/bin2vlogarray
