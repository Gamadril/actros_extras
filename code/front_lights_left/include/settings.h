#pragma once

#define I2C_ADDR 0x11

#define ON HIGH
#define OFF LOW

#define CMD_OFF 0x01
#define CMD_DATA 0x02
#define CMD_PING 0x03
#define CMD_RESET 0xFE

#define EVENT_LIGHTS_OFF 0x01
#define EVENT_PARKING 0x02
#define EVENT_LOW_BEAM 0x03
#define EVENT_HIGH_BEAM 0x04
#define EVENT_BRAKE 0x05
#define EVENT_REVERSE 0x06
#define EVENT_DAYTIME 0x07
#define EVENT_FOG 0x08
#define EVENT_TURN_LEFT 0x09
#define EVENT_TURN_RIGHT 0x0A

#define SIGNAL_PARKING 0x10
#define SIGNAL_LOW_BEAM 0x11
#define SIGNAL_HIGH_BEAM 0x12
#define SIGNAL_TURN 0x13
#define SIGNAL_FOG 0x14
#define SIGNAL_DAYTIME 0x15
#define SIGNAL_ROOF 0x16
#define SIGNAL_MARKER 0x17
#define SIGNAL_TURN_SIDE 0x18
#define SIGNAL_BRAKE 0x19
#define SIGNAL_TAIL 0x1A
#define SIGNAL_REVERSE 0x1B
#define SIGNAL_PLATE 0x1C

/* https://github.com/SpenceKonde/ATTinyCore/blob/master/avr/extras/Pinout_x4.jpg */
/* ! COUNTERCLOCKWISE PINOUT ! */

#define LED_PARKING 2
#define LED_LOW_BEAM 0
#define LED_HIGH_BEAM 3
#define LED_TURN 9
#define LED_DAYTIME 1
// 11 is RESET PIN on attiny84 - needs to be set as IO pin in hfuse
#define LED_FOG 11
#define LED_TURN_SIDE 7
#define LED_ROOF 5
#define LED_MARKER 8
