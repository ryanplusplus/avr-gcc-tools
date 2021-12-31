ifeq ($(MCU),atmega328p)
HARDWARE_MANUAL_URL := http://ww1.microchip.com/downloads/en/DeviceDoc/ATmega48A-PA-88A-PA-168A-PA-328-P-DS-DS40002061A.pdf
DATASHEET_URL := http://ww1.microchip.com/downloads/en/DeviceDoc/ATmega48A-PA-88A-PA-168A-PA-328-P-DS-DS40002061A.pdf
endif

ifeq ($(MCU),atmega4809)
HARDWARE_MANUAL_URL := https://ww1.microchip.com/downloads/en/DeviceDoc/ATmega4808-09-DataSheet-DS40002173B.pdf
DATASHEET_URL := https://ww1.microchip.com/downloads/en/DeviceDoc/ATmega4808-09-DataSheet-DS40002173B.pdf
endif

ifeq ($(MCU),attiny167)
HARDWARE_MANUAL_URL := http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-8265-8-bit-AVR-Microcontroller-tinyAVR-ATtiny87-ATtiny167_datasheet.pdf
DATASHEET_URL := http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-8265-8-bit-AVR-Microcontroller-tinyAVR-ATtiny87-ATtiny167_datasheet.pdf
endif

ifeq ($(MCU),attiny416)
HARDWARE_MANUAL_URL := https://ww1.microchip.com/downloads/en/DeviceDoc/ATtiny212-214-412-414-416-DataSheet-DS40002287A.pdf
DATASHEET_URL := https://ww1.microchip.com/downloads/en/DeviceDoc/ATtiny212-214-412-414-416-DataSheet-DS40002287A.pdf
endif

ifeq ($(MCU),attiny85)
HARDWARE_MANUAL_URL := http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2586-AVR-8-bit-Microcontroller-ATtiny25-ATtiny45-ATtiny85_Datasheet.pdf
DATASHEET_URL := http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2586-AVR-8-bit-Microcontroller-ATtiny25-ATtiny45-ATtiny85_Datasheet.pdf
endif

ifeq ($(MCU),attiny88)
HARDWARE_MANUAL_URL := https://ww1.microchip.com/downloads/en/DeviceDoc/doc8008.pdf
DATASHEET_URL := https://ww1.microchip.com/downloads/en/DeviceDoc/doc8008.pdf
endif

ifneq ($(HARDWARE_MANUAL_URL),)
.PHONY: hardware_manual
hardware_manual:
	@xdg-open $(HARDWARE_MANUAL_URL)
else
.PHONY: hardware_manual
hardware_manual:
	$(error unknown micro, please edit docs.mk)
endif

ifneq ($(HARDWARE_MANUAL_URL),)
.PHONY: datasheet
datasheet:
	@xdg-open $(DATASHEET_URL)
else
.PHONY: datasheet
datasheet:
	$(error unknown micro, please edit docs.mk)
endif
