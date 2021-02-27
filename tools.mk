__avr_gcc_tools_path := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

BUILD_DEPS += dfp
SYS_INC_DIRS += $(__avr_gcc_tools_path)dfp/$(DEVICE_PACK)/include

TOOLCHAIN_PREFIX := avr-
include $(__avr_gcc_tools_path)gcc/tools.mk

include $(__avr_gcc_tools_path)upload.mk
include $(__avr_gcc_tools_path)debug.mk

.PHONY: dfp
dfp: $(__avr_gcc_tools_path)dfp/$(DEVICE_PACK)/package.content

$(__avr_gcc_tools_path)dfp/$(DEVICE_PACK)/package.content: $(__avr_gcc_tools_path)dfp/download/$(DEVICE_PACK).atpack
	@unzip $(__avr_gcc_tools_path)dfp/download/$(DEVICE_PACK).atpack -d $(__avr_gcc_tools_path)dfp/$(DEVICE_PACK)
	@touch $@

$(__avr_gcc_tools_path)dfp/download/$(DEVICE_PACK).atpack:
	@mkdir -p $(dir $@)
	@cd $(dir $@) && wget http://packs.download.atmel.com/$(DEVICE_PACK).atpack

.PHONY: install_toolchain
install_toolchain:
	sudo apt-get install gcc-avr binutils-avr gdb-avr avr-libc avrdude avarice
