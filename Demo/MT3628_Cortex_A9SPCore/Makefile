NAME = FreeRTOSDemo-Baikal

CC = arm-none-eabi-gcc
LD = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy

LIBS =

SOURCE_DIR = ../..
BUILD_DIR = Build

C_OPTS =	-I"$(SOURCE_DIR)/Demo/MT3628_Cortex_A9SPCore" \
			-I"$(SOURCE_DIR)/Demo/Common/include" \
			-I"$(SOURCE_DIR)/Source/include" \
			-I"$(SOURCE_DIR)/Source/portable/GCC/ARM_CA9" \
			-O3 \
			-Wall \
			-fmessage-length=0 \
			-mcpu=cortex-a9 \
			-g3 \
			-gdwarf-2 \
			-std=c99

ADD_C_FILES = Demo/MT3628_Cortex_A9SPCore/empty_crt.c

C_FILES = $(ADD_C_FILES) \
		Source/croutine.c \
		Source/list.c \
		Source/queue.c \
		Source/tasks.c \
		Source/timers.c \
		Source/portable/GCC/ARM_CA9/port.c \
		Source/portable/MemMang/heap_2.c \
		Demo/MT3628_Cortex_A9SPCore/main.c \
		Demo/MT3628_Cortex_A9SPCore/serial.c \
		Demo/MT3628_Cortex_A9SPCore/uart.c
#		Demo/Common/Minimal/BlockQ.c \
#		Demo/Common/Minimal/blocktim.c \
#		Demo/Common/Minimal/comtest.c \
#		Demo/Common/Minimal/countsem.c \
#		Demo/Common/Minimal/dynamic.c \
#		Demo/Common/Minimal/flop.c \
#		Demo/Common/Minimal/GenQTest.c \
#		Demo/Common/Minimal/integer.c \
#		Demo/Common/Minimal/PollQ.c \
#		Demo/Common/Minimal/QPeek.c \
#		Demo/Common/Minimal/recmutex.c \
#		Demo/Common/Minimal/semtest.c

S_FILES = Demo/MT3628_Cortex_A9SPCore/start.S

C_OBJS = $(C_FILES:%.c=$(BUILD_DIR)/%.o)

S_OBJS = $(S_FILES:%.S=$(BUILD_DIR)/%.o)

AUTODEPENDENCY_CFLAGS=-MMD -MF$(@:.o=.d) -MT$@

ALL_CFLAGS = $(C_OPTS) $(DEFINES) $(CFLAGS) $(AUTODEPENDENCY_CFLAGS)

ALL_LDFLAGS_BASE = $(LD_FLAGS) \
			-nostartfiles \
			-mcpu=cortex-a9 \
			-g3 \
			-gdwarf-2

LINK_PATH = ./

ALL_LDFLAGS =	$(ALL_LDFLAGS_BASE) \
				-Wl,-T,$(LINK_PATH)plain.ld

all: $(NAME).bin

%.bin: %.elf
	$(OBJCOPY) -O binary $< $@

$(NAME).elf: $(C_OBJS) $(S_OBJS)
	$(LD) $(ALL_LDFLAGS) -o $@ $^ $(LIBS)

$(BUILD_DIR)/%.o: $(SOURCE_DIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(ALL_CFLAGS) $(AUTODEPENDENCY_CFLAGS) -c $< -o $@

$(BUILD_DIR)/%.o: $(SOURCE_DIR)/%.S
	@mkdir -p $(dir $@)
	$(CC) $(ALL_CFLAGS) $(AUTODEPENDENCY_CFLAGS) -c $< -o $@




clean:
	rm -rf $(BUILD_DIR)/*
