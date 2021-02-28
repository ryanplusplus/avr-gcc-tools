__avr_gcc_tools_upload_path := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
__dwdebug_path := $(__avr_gcc_tools_upload_path)bin/dwdebug-$(shell uname)

FUSE_ARGS :=
$(foreach f,$(FUSES),$(eval FUSE_ARGS += -U $(word 1,$(subst =, ,$(f))):w:$(word 2,$(subst =, ,$(f))):m))

ifneq ($(EFUSE),)
FUSES += -U efuse:w:$(EFUSE):m
endif

ifneq ($(HFUSE),)
FUSES += -U hfuse:w:$(HFUSE):m
endif

ifneq ($(LFUSE),)
FUSES += -U lfuse:w:$(LFUSE):m
endif

ifeq ($(UPLOAD_TYPE),avrdude)
.PHONY: fuse
fuse:
	avrdude -c $(AVRDUDE_PROGRAMMER_TYPE) -p $(MCU) $(AVRDUDE_PROGRAMMER_ARGS) $(FUSE_ARGS)

.PHONY: upload
upload: $(BUILD_DIR)/$(TARGET).hex
	avrdude -c $(AVRDUDE_PROGRAMMER_TYPE) -p $(MCU) $(AVRDUDE_PROGRAMMER_ARGS) -U flash:w:$<

.PHONY: erase
erase:
	@avrdude -c $(AVRDUDE_PROGRAMMER_TYPE) -p $(MCU) $(AVRDUDE_PROGRAMMER_ARGS) -e
endif

ifeq ($(UPLOAD_TYPE),dwdebug)
.PHONY: upload
upload: $(BUILD_DIR)/$(TARGET).elf
	@$(__dwdebug_path) device $(DWDEBUG_TOOL),l $<,qr
endif
