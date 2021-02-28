__avr_gcc_tools_debug_path := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
__dwdebug_path := $(__avr_gcc_tools_debug_path)bin/dwdebug-$(shell uname)

.PHONY: $(BUILD_DIR)/debug-server-avarice-updi-ice
$(BUILD_DIR)/debug-server-avarice-updi-ice:
	@echo "#!/bin/bash" > $@
	@echo "PORT=\`echo \"'\$$*'\" | sed 's/.*gdb_port \([^ ]*\).*/\\\1/'\`" >> $@
	@echo "avarice -P $(MCU) --edbg --updi :\$$PORT" >> $@
	@chmod +x $@

.PHONY: $(BUILD_DIR)/debug-server-dwdebug
$(BUILD_DIR)/debug-server-dwdebug:
	@echo "#!/bin/bash" > $@
	@echo "$(__dwdebug_path) verbose,gdbserver,device $(DWDEBUG_TOOL)" >> $@
	@chmod +x $@

.PHONY: debug-deps
debug-deps: $(BUILD_DIR)/debug-server-avarice-updi-ice $(BUILD_DIR)/debug-server-dwdebug $(BUILD_DIR)/$(TARGET).hex
