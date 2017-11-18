#!/usr/bin/env python

__author__ = "Sergey Razmyslov"
__copyright__ = "Copyright 2017"
__credits__ = ["Sergey Razmyslov - https://github.com/SergeyRazmyslov"]
__v__  = "1.0"
__license__ = "GPL"
__version__ = "2.0"
__maintainer__ = __author__
__email__ = "sergey.razmyslov@gmail.com"


import evdev
import uinput
from time import sleep
from evdev import InputDevice, KeyEvent, UInput, AbsInfo, ecodes as e
from pyA20.gpio import gpio
from pyA20.gpio import port

# Number of connected gamepads (max value is 4)
MAX_GAMEPADS = 2

# Delay between ticks
PULSE_TIME = 0.001

PIN_DATA1 = port.PA12
PIN_DATA2 = port.PA11
PIN_DATA3 = port.PA6
PIN_DATA4 = port.PG7

PIN_CLOCK = port.PA9
PIN_LATCH = port.PA20

events = ([
		uinput.BTN_START,
		uinput.BTN_SELECT,
		uinput.BTN_A,
		uinput.BTN_B,
		uinput.ABS_X + (0,255,0,0),
		uinput.ABS_Y + (0,255,0,0),
	])

NES_UP = 0x08
NES_DOWN = 0x04
NES_LEFT = 0x02
NES_RIGHT = 0x01
NES_START = 0x10
NES_SELECT = 0x20
NES_B = 0x40
NES_A = 0x80

class Button:
	def __init__(self, nes_code, btn_code, up_value, down_value):
		self.nes_code = nes_code
		self.btn_code = btn_code
		self.up_value = up_value
		self.down_value = down_value
		self.is_pressed = False

class Gamepad:
	def __init__(self, name, id, data_pin):
		self.device = uinput.Device(events, name, id)
		self.data_pin = data_pin
		self.buttons_value = 0
		self.buttons = [
			Button(NES_UP, uinput.ABS_Y, 128, 0),
			Button(NES_DOWN, uinput.ABS_Y, 128, 255),
			Button(NES_LEFT, uinput.ABS_X, 128, 0),
			Button(NES_RIGHT, uinput.ABS_X, 128, 255),
			Button(NES_START, uinput.BTN_START, 0, 1),
			Button(NES_SELECT, uinput.BTN_SELECT, 0, 1),
			Button(NES_B, uinput.BTN_B, 0, 1),
			Button(NES_A, uinput.BTN_A, 0, 1)
		]

		# init ABS buttons
		self.device.emit(uinput.ABS_X, 128, syn=False)
		self.device.emit(uinput.ABS_Y, 128)

class Gamepad_Configuration:
	def __init__(self, name, id, data_pin):
		self.name = name
		self.id = id
		self.data_pin = data_pin

gamepad_configurations = [
	Gamepad_Configuration("NES pad #1", 0x00, PIN_DATA1),
	Gamepad_Configuration("NES pad #2", 0x01, PIN_DATA2),
	Gamepad_Configuration("NES pad #3", 0x02, PIN_DATA3),
	Gamepad_Configuration("NES pad #4", 0x03, PIN_DATA4)
]

# Init gamepads
gamepads = []
for i in range(0, MAX_GAMEPADS):
	gamepads.append(Gamepad(gamepad_configurations[i].name, gamepad_configurations[i].id, gamepad_configurations[i].data_pin))

#--------------------------------Initialize module. Always called first
gpio.init()

gpio.setcfg(PIN_LATCH, gpio.OUTPUT)
gpio.setcfg(PIN_CLOCK, gpio.OUTPUT)

gpio.output(PIN_LATCH, 0)
gpio.output(PIN_CLOCK, 0)

for gamepad in gamepads:
	gpio.setcfg(gamepad.data_pin, gpio.INPUT)

while True:

	# init read gamepads
	gpio.output(PIN_LATCH, 1)
	sleep(PULSE_TIME)
	gpio.output(PIN_LATCH, 0)
	sleep(PULSE_TIME)

	# read first bit
	for gamepad in gamepads:
		gamepad.buttons_value = gpio.input(gamepad.data_pin)

	for i in range(0, 7):
		# init read next bit
		gpio.output(PIN_CLOCK, 1)
		sleep(PULSE_TIME)
		gpio.output(PIN_CLOCK, 0)
		sleep(PULSE_TIME)

		# read next bit
		for gamepad in gamepads:
			gamepad.buttons_value = (gamepad.buttons_value << 1) | gpio.input(gamepad.data_pin)

	# analyse gamepad values
	for gamepad in gamepads:
		gamepad.buttons_value = gamepad.buttons_value^0xFF

		for button in gamepad.buttons:
			# check if the button is pressed
			if (gamepad.buttons_value & button.nes_code):
				# invoke event if the button state changed
				if (not button.is_pressed):
					button.is_pressed = True
					gamepad.device.emit(button.btn_code, button.down_value)
			else: # button is not pressed
				# invoke event if the button state changed
				if (button.is_pressed):
					button.is_pressed = False
					gamepad.device.emit(button.btn_code, button.up_value)
