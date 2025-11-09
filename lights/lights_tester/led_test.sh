#!/bin/bash
# LED test script using i2cset
# Author: ChatGPT
# Description: Controls LED signals on an I2C slave microcontroller

# === CONFIGURATION ===
I2C_BUS=17           # Default I2C bus number (can be overridden by env var)
CMD_DATA=0x02        # Data packet type

# === SIGNALS ===
declare -A SIGNALS=(
  [parking]=0x10
  [low_beam]=0x11
  [high_beam]=0x12
  [turn]=0x13
  [fog]=0x14
  [daytime]=0x15
  [roof]=0x16
  [marker]=0x17
  [turn_side]=0x18
  [brake]=0x19
  [tail]=0x1A
  [reverse]=0x1B
  [plate]=0x1C
)

# === FUNCTIONS ===

usage() {
  echo "Usage:"
  echo "  $0 <i2c_addr> all on|off             # Turn all LEDs on or off"
  echo "  $0 <i2c_addr> <signal> on|off        # Control a specific LED"
  echo "  $0 <i2c_addr> demo                   # Run sequential demo pattern"
  echo "  $0 <i2c_addr> turnloop [interval]    # Simulate blinking turn signal (default 0.5s)"
  echo ""
  echo "Signals: parking, low_beam, high_beam, turn, fog, daytime, roof, marker, turn_side, brake, tail, reverse, plate"
  echo "Default I2C bus: ${I2C_BUS} (override with I2C_BUS=<bus> before command)"
  exit 1
}

send_i2c() {
  local addr=$1
  local signal=$2
  local value=$3
  echo "Sending to addr ${addr}: signal=${signal}, value=${value}"
  i2cset -y $I2C_BUS $addr $CMD_DATA ${SIGNALS[$signal]} $value i
}

turn_all() {
  local addr=$1
  local value=$2
  for signal in "${!SIGNALS[@]}"; do
    send_i2c $addr $signal $value
    sleep 0.05
  done
}

demo_mode() {
  local addr=$1
  echo "Running LED demo pattern on ${addr}..."
  for signal in "${!SIGNALS[@]}"; do
    send_i2c $addr $signal 0x01  # ON
    sleep 0.3
    send_i2c $addr $signal 0x00  # OFF
  done
  echo "Demo complete."
}

turn_signal_loop() {
  local addr=$1
  local interval=${2:-0.5}  # Default blink interval (seconds)
  echo "Simulating turn signal blink on ${addr} every ${interval}s..."
  echo "Press Ctrl+C to stop."
  trap "echo -e '\nStopping turn signal simulation...'; send_i2c $addr turn 0x01; exit 0" SIGINT
  while true; do
    send_i2c $addr turn 0x00  # ON
    sleep $interval
    send_i2c $addr turn 0x01  # OFF
    sleep $interval
  done
}

# === MAIN ===

[[ $# -lt 2 ]] && usage

I2C_ADDR=$1
ACTION=$2
OPTION=$3

case "$ACTION" in
  all)
    [[ "$OPTION" == "on" ]] && turn_all $I2C_ADDR 0x01 && exit 0
    [[ "$OPTION" == "off" ]] && turn_all $I2C_ADDR 0x00 && exit 0
    usage
    ;;
  demo)
    demo_mode $I2C_ADDR
    ;;
  turnloop)
    turn_signal_loop $I2C_ADDR $OPTION
    ;;
  *)
    [[ -z "${SIGNALS[$ACTION]}" ]] && { echo "Unknown signal: $ACTION"; usage; }
    [[ "$OPTION" == "on" ]] && send_i2c $I2C_ADDR $ACTION 0x01 && exit 0
    [[ "$OPTION" == "off" ]] && send_i2c $I2C_ADDR $ACTION 0x00 && exit 0
    usage
    ;;
esac
