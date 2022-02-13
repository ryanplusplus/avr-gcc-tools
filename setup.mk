__avr_gcc_tools_setup_included := Y

__avr_gcc_tools_path := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

include $(__avr_gcc_tools_path)utils/utils.mk
