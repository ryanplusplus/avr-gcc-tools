__avr_gcc_tools_debug_path := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
__dwdebug_path := $(__avr_gcc_tools_debug_path)bin/$(shell uname)-$(shell uname -m)/dwdebug

.PHONY: $(BUILD_DIR)/debug-server-avarice-updi-ice
$(BUILD_DIR)/debug-server-avarice-updi-ice:
	@echo "#!/bin/bash" > $@
	@echo "PORT=\`echo \"'\$$*'\" | sed 's/.*gdb_port \([^ ]*\).*/\\\1/'\`" >> $@
	@echo "avarice -P $(MCU) --edbg --updi :\$$PORT" >> $@
	@chmod +x $@

.PHONY: $(BUILD_DIR)/debug-server-dwdebug
$(BUILD_DIR)/debug-server-dwdebug:
	@(command -v setserial > /dev/null && setserial /dev/$(DWDEBUG_DEVICE) low_latency) || true
	@echo "#!/bin/bash" > $@
	@echo "echo '\nInfo : Listening on port 50000 for gdb connection\n'" >> $@
	@echo "$(__dwdebug_path) verbose,gdbserver,device $(DWDEBUG_DEVICE)" >> $@
	@chmod +x $@

.PHONY: debug-deps
debug-deps: $(BUILD_DIR)/debug-server-avarice-updi-ice $(BUILD_DIR)/debug-server-dwdebug $(BUILD_DIR)/$(TARGET).hex
