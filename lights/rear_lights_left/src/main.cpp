#include "settings.h"
#include <Arduino.h>
#include <Wire.h>
#include <avr/wdt.h>

void receiveHandler(int numBytes);
void requestHandler();
void allOff();

uint8_t signal = 0;
uint8_t value = 0;
uint8_t cmd = 0;

static void (*jump_to_app)(void) __attribute__((noreturn)) = (void *)0x0000;

void setup() {
  pinMode(LED_MARKER, OUTPUT);
  pinMode(LED_TURN, OUTPUT);
  pinMode(LED_BRAKE, OUTPUT);
  pinMode(LED_REVERSE, OUTPUT);
  pinMode(LED_TAIL, OUTPUT);
  pinMode(LED_FOG, OUTPUT);
  pinMode(LED_PLATE, OUTPUT);

  Wire.begin(I2C_ADDR);
  Wire.onReceive(receiveHandler);
  Wire.onRequest(requestHandler);
}

void loop() {
  if (cmd == CMD_RESET) {
    allOff();
    jump_to_app();
    cmd = 0;
  } else if (cmd == CMD_OFF) {
    allOff();
    cmd = 0;
  } else if (cmd == CMD_DATA) {
    // check events first
    if (signal >= EVENT_LIGHTS_OFF && signal <= EVENT_TURN_RIGHT) {
      switch (signal) {
        case EVENT_LIGHTS_OFF:
          allOff();
          break;
        case EVENT_TURN_LEFT:
          digitalWrite(LED_TURN, value == 0 ? OFF : ON);
          break;
        case EVENT_BRAKE:
          digitalWrite(LED_BRAKE, value == 0 ? OFF : ON);
          break;
        case EVENT_PARKING:
          digitalWrite(LED_MARKER, value == 0 ? OFF : ON);
          digitalWrite(LED_TAIL, value == 0 ? OFF : ON);
          digitalWrite(LED_PLATE, value == 0 ? OFF : ON);
          break;
        case EVENT_REVERSE:
          digitalWrite(LED_REVERSE, value == 0 ? OFF : ON);
          break;
        case EVENT_FOG:
          digitalWrite(LED_FOG, value == 0 ? OFF : ON);
          break;
        default:
          break;
      }
    } else if (signal >= SIGNAL_PARKING && signal <= SIGNAL_PLATE) {
      switch (signal) {
        case SIGNAL_MARKER:
          digitalWrite(LED_MARKER, value == 0 ? OFF : ON);
          break;
        case SIGNAL_TURN:
          digitalWrite(LED_TURN, value == 0 ? OFF : ON);
          break;
        case SIGNAL_BRAKE:
          digitalWrite(LED_BRAKE, value == 0 ? OFF : ON);
          break;
        case SIGNAL_REVERSE:
          digitalWrite(LED_REVERSE, value == 0 ? OFF : ON);
          break;
        case SIGNAL_TAIL:
          digitalWrite(LED_TAIL, value == 0 ? OFF : ON);
          break;
        case SIGNAL_FOG:
          digitalWrite(LED_FOG, value == 0 ? OFF : ON);
          break;
        case SIGNAL_PLATE:
          digitalWrite(LED_PLATE, value == 0 ? OFF : ON);
          break;
        default:
          break;
      }
    }

    cmd = 0;
  }
}

void allOff() {
  digitalWrite(LED_MARKER, OFF);
  digitalWrite(LED_TURN, OFF);
  digitalWrite(LED_BRAKE, OFF);
  digitalWrite(LED_REVERSE, OFF);
  digitalWrite(LED_TAIL, OFF);
  digitalWrite(LED_FOG, OFF);
  digitalWrite(LED_PLATE, OFF);
}

void receiveHandler(int numBytes) {
  cmd = Wire.read();
  if (cmd == CMD_DATA && numBytes == 3) {
    signal = Wire.read();
    value = Wire.read();
  } else if (cmd == CMD_PING && numBytes == 1) {
    // send response later in requestHandler
  } else {
    value = 0;
    signal = 0;
  }
}

void requestHandler() {
  if (cmd == CMD_PING) {
    uint8_t data[] = {CMD_PING, I2C_ADDR, 'R', 'L'};
    Wire.write(data, sizeof(data));
    cmd = 0;
  }
}