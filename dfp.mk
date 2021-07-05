.PHONY: dfp
dfp: $(__avr_gcc_tools_path)dfp/$(DEVICE_PACK)/package.content

$(__avr_gcc_tools_path)dfp/$(DEVICE_PACK)/package.content: $(__avr_gcc_tools_path)dfp/download/$(DEVICE_PACK).atpack
	@unzip $(__avr_gcc_tools_path)dfp/download/$(DEVICE_PACK).atpack -d $(__avr_gcc_tools_path)dfp/$(DEVICE_PACK)
	@touch $@

$(__avr_gcc_tools_path)dfp/download/$(DEVICE_PACK).atpack:
	@mkdir -p $(dir $@)
	@cd $(dir $@) && wget http://packs.download.microchip.com/$(DEVICE_PACK).atpack
