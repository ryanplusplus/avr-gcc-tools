__avr_gcc_tools_defaults_path := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

ASFLAGS := \
  -mmcu=$(MCU) \
  -g2 \

CPPFLAGS := \
  -mmcu=$(MCU) \
  -ggdb \
  -g2 \
  -Os \
  -fdata-sections \
  -ffunction-sections \
  -Wall \
  -Wextra \
  -Werror \
  -Wfatal-errors \
  -Wcast-qual \
  -Wpedantic \

CPPFLAGS += -B$(__avr_gcc_tools_defaults_path)dfp/$(DEVICE_PACK)/gcc/dev/$(MCU)

CFLAGS := \
  -std=c11 \

CXXFLAGS := \
  -fno-rtti \
  -fno-exceptions \
  -fno-unwind-tables \
  -fno-non-call-exceptions \
  -fno-use-cxa-atexit \
  -Weffc++ \
  -std=c++17 \

LDFLAGS := \
  -Wl,-Og \
  -Wl,--gc-sections \
  -Wl,--relax \
  -Wl,-Map=$(BUILD_DIR)/$(TARGET).map \
