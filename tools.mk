__avr_gcc_tools_path := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

BUILD_DEPS += dfp
SYS_INC_DIRS += dfp/$(DEVICE_PACK)/include

TOOLCHAIN_PREFIX := avr-
include $(__avr_gcc_tools_path)gcc/tools.mk

include $(__avr_gcc_tools_path)upload.mk
include $(__avr_gcc_tools_path)debug.mk

.PHONY: dfp
dfp: dfp/$(DEVICE_PACK)/package.content

dfp/$(DEVICE_PACK)/package.content: dfp/download/$(DEVICE_PACK).atpack
	@unzip dfp/download/$(DEVICE_PACK).atpack -d dfp/$(DEVICE_PACK)
	@touch $@

dfp/download/$(DEVICE_PACK).atpack:
	@mkdir -p $(dir $@)
	@cd $(dir $@) && wget http://packs.download.atmel.com/$(DEVICE_PACK).atpack
