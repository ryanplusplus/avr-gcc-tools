__avr_gcc_tools_debug_path := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
__dwdebug_path := $(__avr_gcc_tools_debug_path)bin/$(shell uname)-$(shell uname -m)/dwdebug

BLOOM_INSIGHT_ENABLED ?= false

.PHONY: $(BUILD_DIR)/debug-server-avarice-updi-ice
$(BUILD_DIR)/debug-server-avarice-updi-ice:
	@echo "#!/bin/bash" > $@
	@echo "PORT=\`echo \"'\$$*'\" | sed 's/.*gdb_port \([^ ]*\).*/\\\1/'\`" >> $@
	@echo "avarice -P $(MCU) --edbg --updi :\$$PORT" >> $@
	@chmod +x $@

.PHONY: $(BUILD_DIR)/debug-server-bloom
$(BUILD_DIR)/debug-server-bloom: $(BUILD_DIR)/bloom.yaml
	@echo "#!/bin/bash" > $@
	@echo "echo '\nInfo : Listening on port 50000 for gdb connection\n'" >> $@
	@echo "cd $(abspath $(BUILD_DIR)) && bloom" >> $@
	@chmod +x $@

.PHONY: $(BUILD_DIR)/bloom.yaml
$(BUILD_DIR)/bloom.yaml:
	@echo "environments:" > $@
	@echo "  default:" >> $@
	@echo "    debugTool:" >> $@
	@echo "      name: \"$(BLOOM_DEBUG_TOOL)\"" >> $@
	@echo "" >> $@
	@echo "    target:" >> $@
	@echo "      name: \"$(MCU)\"" >> $@
	@echo "      physicalInterface: \"$(BLOOM_DEBUG_INTERFACE)\"" >> $@
	@echo "" >> $@
	@echo "    debugServer:" >> $@
	@echo "      name: \"avr-gdb-rsp\"" >> $@
	@echo "      ipAddress: \"127.0.0.1\"" >> $@
	@echo "      port: 50000" >> $@
	@echo "" >> $@
	@echo "    shutdownPostDebugSession: true" >> $@
	@echo "" >> $@
	@echo "insight:" >> $@
	@echo "  enabled: $(BLOOM_INSIGHT_ENABLED)" >> $@
	@echo "" >> $@

.PHONY: $(BUILD_DIR)/debug-server-dwdebug
$(BUILD_DIR)/debug-server-dwdebug:
	@(command -v setserial > /dev/null && setserial /dev/$(DWDEBUG_DEVICE) low_latency 2> /dev/null) || true
	@echo "#!/bin/bash" > $@
	@echo "echo '\nInfo : Listening on port 50000 for gdb connection\n'" >> $@
	@echo "$(__dwdebug_path) verbose,gdbserver,device $(DWDEBUG_DEVICE)" >> $@
	@chmod +x $@

.PHONY: debug-deps
debug-deps: \
  $(BUILD_DIR)/debug-server-avarice-updi-ice \
  $(BUILD_DIR)/debug-server-bloom \
  $(BUILD_DIR)/debug-server-dwdebug \
  $(BUILD_DIR)/$(TARGET).hex
