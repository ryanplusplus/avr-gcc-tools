__avr_gcc_tools_path := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

BUILD_DEPS += dfp
SYS_INC_DIRS += $(__avr_gcc_tools_path)dfp/$(DEVICE_PACK)/include

TOOLCHAIN_PREFIX := avr-
include $(__avr_gcc_tools_path)gcc/tools.mk

include $(__avr_gcc_tools_path)upload.mk
include $(__avr_gcc_tools_path)debug.mk
include $(__avr_gcc_tools_path)dfp.mk

.PHONY: install_toolchain
install_toolchain:
	sudo apt-get install gcc-avr binutils-avr gdb-avr avr-libc avrdude avarice
