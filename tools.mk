ifneq ($(__avr_gcc_tools_setup_included),Y)
$(error setup.mk must be included before tools.mk)
endif

include $(__avr_gcc_tools_path)dfp-deps.mk

TOOLCHAIN_PREFIX := avr-
BUILD_DEPS_ORDER_ONLY += dfp
include $(__avr_gcc_tools_path)gcc/tools.mk

include $(__avr_gcc_tools_path)upload.mk
include $(__avr_gcc_tools_path)debug.mk
include $(__avr_gcc_tools_path)dfp.mk
include $(__avr_gcc_tools_path)docs.mk

.PHONY: install_toolchain
install_toolchain:
	sudo apt-get install gcc-avr binutils-avr gdb-avr avr-libc
