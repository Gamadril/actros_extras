#!/bin/bash

# TWI Bootloader Flash Script for PlatformIO
# Usage: flash_twiboot.sh <hex_file>

HEX_FILE="$1"
TWIBOOT_I2C_BUS=${TWIBOOT_I2C_BUS}
TWIBOOT_APP_ADDR=${TWIBOOT_APP_ADDR}
TWIBOOT_BOOT_ADDR=${TWIBOOT_BOOT_ADDR}
FLASHER="twiboot-flasher"

if [ -z "$HEX_FILE" ]; then
    echo "Error: No hex file specified"
    exit 1
fi

if [ -z "$TWIBOOT_I2C_BUS" ]; then
    echo "Error: No I2C bus specified"
    exit 1
fi

if [ -z "$TWIBOOT_APP_ADDR" ]; then
    echo "Error: No I2C adress of application specified"
    exit 1
fi

if [ -z "$TWIBOOT_BOOT_ADDR" ]; then
    echo "Error: No I2C address of TWIBOOt bootloader specified"
    exit 1
fi

if [ ! -f "$HEX_FILE" ]; then
    echo "Error: Hex file not found: $HEX_FILE"
    exit 1
fi

echo "Flashing $HEX_FILE via TWI bootloader..."
echo "Configuration: I2C Bus=$TWIBOOT_I2C_BUS, App Addr=$TWIBOOT_APP_ADDR, Boot Addr=$TWIBOOT_BOOT_ADDR"

# Check if device is in application mode and try to reset it
if i2cdetect -y $TWIBOOT_I2C_BUS | grep -q " ${TWIBOOT_APP_ADDR#0x} "; then
    echo "Device in application mode, sending reset command..."
    # Send reset command to switch to bootloader mode
    if i2cset -y $TWIBOOT_I2C_BUS $TWIBOOT_APP_ADDR 0xFE c 2>/dev/null; then
        echo "Reset command sent successfully"
        sleep 0.1  # Brief delay for device to reset
    else
        echo "Warning: Reset command failed, device may not support it"
    fi
fi

# Check if device is now in bootloader mode
if i2cdetect -y $TWIBOOT_I2C_BUS | grep -q " ${TWIBOOT_BOOT_ADDR#0x} "; then
    echo "Device in bootloader mode, flashing..."
    "$FLASHER" $TWIBOOT_I2C_BUS $TWIBOOT_BOOT_ADDR "$HEX_FILE"
    exit $?
else
    echo "Error: Device not found in bootloader mode"
    if i2cdetect -y $TWIBOOT_I2C_BUS | grep -q " ${TWIBOOT_APP_ADDR#0x} "; then
        echo ""
        echo "Device is in application mode."
        echo "To enter bootloader mode, you can:"
        echo "1. Power cycle the device"
        echo "2. Use a hardware reset"
        echo "3. Implement reset command in application firmware"
        echo ""
        echo "Then run: pio run -e attiny84_twiboot -t upload"
    else
        echo "No device found on I2C bus "$TWIBOOT_I2C_BUS""
        echo "Current I2C devices:"
        i2cdetect -y $TWIBOOT_I2C_BUS
    fi
    exit 1
fi
