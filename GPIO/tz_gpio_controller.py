#!/usr/bin/env python


__author__ = "Erick Tarzia"
__copyright__ = "Copyright 2016, TZ Games SP"
__credits__ = ["Erick Tarzia - tzgamessp.com.br"]
__v__  = "1.0"
__license__ = "GPL"
__version__ = "2.0"
__maintainer__ = __author__
__email__ = "ericktarzia@gmail.com"


import evdev
import uinput
from time import sleep
from evdev import InputDevice, KeyEvent, UInput, AbsInfo, ecodes as e
from pyA20.gpio import gpio
from pyA20.gpio import port
from pyA20.gpio import connector

#sleep(10)

events = ([
		uinput.BTN_JOYSTICK,
		uinput.BTN_0,
		uinput.BTN_1,
		uinput.BTN_2,
		uinput.BTN_3,
		uinput.BTN_4,
		uinput.BTN_5,
		uinput.BTN_6,
		uinput.BTN_7,
		uinput.BTN_8,
		uinput.ABS_X + (0,255,0,0),
		uinput.ABS_Y + (0,255,0,0),
	])

gamepad = uinput.Device(events,"TZGamesSP Controle #1",0x00)
gamepad2 = uinput.Device(events,"TZGamesSP Controle #2",0x01)

gamepad.emit(uinput.ABS_X, 128, syn=False)
gamepad.emit(uinput.ABS_Y, 128)
gamepad2.emit(uinput.ABS_X, 128, syn=False)
gamepad2.emit(uinput.ABS_Y, 128)
#print device1.capabilities()
'''
devices = [evdev.InputDevice(fn) for fn in evdev.list_devices()]
for device in devices:
	print(device.fn, device.name, device.phys)
	if device.name == "TZ Arcade Joystick 0":
		gamepad = InputDevice(device.fn)
	if device.name == "TZ Arcade Joystick 1":
		gamepad2 = InputDevice(device.fn)
	
'''
#--------------- define botoes -----------------
	# ---- PLAYER 1 ---------#
bt_up_p1 = port.PA6
bt_down_p1 = port.PA1
bt_left_p1 = port.PA0
bt_right_p1 = port.PA3

bt_l_p1 = port.PA13
bt_x_p1 = port.PA14
bt_y_p1 = port.PD14
bt_r_p1 = port.PC4
bt_b_p1 = port.PA2
bt_a_p1 = port.PC7

bt_select_p1 = port.PC1
bt_start_p1 = port.PC0

bt_left_trigger_p1 = port.PA12
bt_right_trigger_p1 = port.PA19

	# ---- PLAYER 2 ---------#
bt_up_p2 = port.PC2
bt_down_p2 = port.PA7
bt_left_p2 = port.PA8
bt_right_p2 = port.PA9

bt_l_p2 = port.PC3
bt_x_p2 = port.PA21
bt_y_p2 = port.PG8
bt_r_p2 = port.PG9
bt_b_p2 = port.PG6
bt_a_p2 = port.PG7

bt_select_p2 = port.PA20
bt_start_p2 = port.PA10

bt_left_trigger_p2 = port.PA11
bt_right_trigger_p2 = port.PA18
#--------------------------------Initialize module. Always called first
gpio.init()

gpio.setcfg(bt_up_p1, gpio.INPUT)
gpio.pullup(bt_up_p1, gpio.PULLUP)

gpio.setcfg(bt_down_p1, gpio.INPUT)
gpio.pullup(bt_down_p1, gpio.PULLUP)

gpio.setcfg(bt_left_p1, gpio.INPUT)
gpio.pullup(bt_left_p1, gpio.PULLUP)

gpio.setcfg(bt_right_p1, gpio.INPUT)
gpio.pullup(bt_right_p1, gpio.PULLUP)


gpio.setcfg(bt_l_p1, gpio.INPUT)
gpio.pullup(bt_l_p1, gpio.PULLUP)

gpio.setcfg(bt_x_p1, gpio.INPUT)
gpio.pullup(bt_x_p1, gpio.PULLUP)

gpio.setcfg(bt_y_p1, gpio.INPUT)
gpio.pullup(bt_y_p1, gpio.PULLUP)

gpio.setcfg(bt_r_p1, gpio.INPUT)
gpio.pullup(bt_r_p1, gpio.PULLUP)

gpio.setcfg(bt_b_p1, gpio.INPUT)
gpio.pullup(bt_b_p1, gpio.PULLUP)

gpio.setcfg(bt_a_p1, gpio.INPUT)
gpio.pullup(bt_a_p1, gpio.PULLUP)

gpio.setcfg(bt_select_p1, gpio.INPUT)
gpio.pullup(bt_select_p1, gpio.PULLUP)

gpio.setcfg(bt_start_p1, gpio.INPUT)
gpio.pullup(bt_start_p1, gpio.PULLUP)

gpio.setcfg(bt_left_trigger_p1, gpio.INPUT)
gpio.pullup(bt_left_trigger_p1, gpio.PULLUP)

gpio.setcfg(bt_right_trigger_p1, gpio.INPUT)
gpio.pullup(bt_right_trigger_p1, gpio.PULLUP)

gpio.setcfg(bt_up_p2, gpio.INPUT)
gpio.pullup(bt_up_p2, gpio.PULLUP)

gpio.setcfg(bt_down_p2, gpio.INPUT)
gpio.pullup(bt_down_p2, gpio.PULLUP)

gpio.setcfg(bt_left_p2, gpio.INPUT)
gpio.pullup(bt_left_p2, gpio.PULLUP)

gpio.setcfg(bt_right_p2, gpio.INPUT)
gpio.pullup(bt_right_p2, gpio.PULLUP)


gpio.setcfg(bt_l_p2, gpio.INPUT)
gpio.pullup(bt_l_p2, gpio.PULLUP)

gpio.setcfg(bt_x_p2, gpio.INPUT)
gpio.pullup(bt_x_p2, gpio.PULLUP)

gpio.setcfg(bt_y_p2, gpio.INPUT)
gpio.pullup(bt_y_p2, gpio.PULLUP)

gpio.setcfg(bt_r_p2, gpio.INPUT)
gpio.pullup(bt_r_p2, gpio.PULLUP)

gpio.setcfg(bt_b_p2, gpio.INPUT)
gpio.pullup(bt_b_p2, gpio.PULLUP)

gpio.setcfg(bt_a_p2, gpio.INPUT)
gpio.pullup(bt_a_p2, gpio.PULLUP)

gpio.setcfg(bt_select_p2, gpio.INPUT)
gpio.pullup(bt_select_p2, gpio.PULLUP)

gpio.setcfg(bt_start_p2, gpio.INPUT)
gpio.pullup(bt_start_p2, gpio.PULLUP)
	
gpio.setcfg(bt_left_trigger_p2, gpio.INPUT)
gpio.pullup(bt_left_trigger_p2, gpio.PULLUP)

gpio.setcfg(bt_right_trigger_p2, gpio.INPUT)
gpio.pullup(bt_right_trigger_p2, gpio.PULLUP)
	
_bt_up_p1 = False
_bt_down_p1 = False
_bt_left_p1 = False
_bt_right_p1 = False
_bt_a_p1 = False
_bt_b_p1 = False
_bt_x_p1 = False
_bt_y_p1 = False
_bt_l_p1 = False
_bt_r_p1 = False
_bt_select_p1 = False
_bt_start_p1 = False
_bt_left_trigger_p1 = False
_bt_right_trigger_p1 = False

_bt_up_p2 = False
_bt_down_p2 = False
_bt_left_p2 = False
_bt_right_p2 = False
_bt_a_p2 = False
_bt_b_p2 = False
_bt_x_p2 = False
_bt_y_p2 = False
_bt_l_p2 = False
_bt_r_p2 = False
_bt_select_p2 = False
_bt_start_p2 = False
_bt_left_trigger_p2 = False
_bt_right_trigger_p2 = False

print gpio.input(bt_a_p1)

while True:
	#------ player 1 -----------#		
#bt a =====================
	if (not _bt_a_p1) and (gpio.input(bt_a_p1) == 0):
		_bt_a_p1 = True
		gamepad.emit(uinput.BTN_0, 1)	
	if (_bt_a_p1) and (gpio.input(bt_a_p1) == 1):
		_bt_a_p1 = False
		gamepad.emit(uinput.BTN_0, 0)	
#bt b =====================

	if (not _bt_b_p1) and (gpio.input(bt_b_p1) == 0):
		_bt_b_p1 = True
		gamepad.emit(uinput.BTN_1, 1)	
	if (_bt_b_p1) and (gpio.input(bt_b_p1) == 1):
		_bt_b_p1 = False
		gamepad.emit(uinput.BTN_1, 0)	

#bt x =====================

	if (not _bt_x_p1) and (gpio.input(bt_x_p1) == 0):
		_bt_x_p1 = True
		gamepad.emit(uinput.BTN_2, 1)	
	if (_bt_x_p1) and (gpio.input(bt_x_p1) == 1):
		_bt_x_p1 = False
		gamepad.emit(uinput.BTN_2, 0)	
#bt y =====================

	if (not _bt_y_p1) and (gpio.input(bt_y_p1) == 0):
		_bt_y_p1 = True
		gamepad.emit(uinput.BTN_3, 1)	
	if (_bt_y_p1) and (gpio.input(bt_y_p1) == 1):
		_bt_y_p1 = False
		gamepad.emit(uinput.BTN_3, 0)	
#bt l =====================
	if (not _bt_l_p1) and (gpio.input(bt_l_p1) == 0):
		_bt_l_p1 = True
		gamepad.emit(uinput.BTN_4, 1)	
	if (_bt_l_p1) and (gpio.input(bt_l_p1) == 1):
		_bt_l_p1 = False
		gamepad.emit(uinput.BTN_4, 0)	
#bt r =====================
	if (not _bt_r_p1) and (gpio.input(bt_r_p1) == 0):
		_bt_r_p1 = True
		gamepad.emit(uinput.BTN_5, 1)	
	if (_bt_r_p1) and (gpio.input(bt_r_p1) == 1):
		_bt_r_p1 = False
		gamepad.emit(uinput.BTN_5, 0)
#bt select =====================
	if (not _bt_select_p1) and (gpio.input(bt_select_p1) == 0):
		_bt_select_p1 = True
		gamepad.emit(uinput.BTN_6, 1)	
	if (_bt_select_p1) and (gpio.input(bt_select_p1) == 1):
		_bt_select_p1 = False
		gamepad.emit(uinput.BTN_6, 0)	
#bt start =====================
	if (not _bt_start_p1) and (gpio.input(bt_start_p1) == 0):
		_bt_start_p1 = True
		gamepad.emit(uinput.BTN_7, 1)	
	if (_bt_start_p1) and (gpio.input(bt_start_p1) == 1):
		_bt_start_p1 = False
		gamepad.emit(uinput.BTN_7, 0)
#bt left trigger =====================
	if (not _bt_left_trigger_p1) and (gpio.input(bt_left_trigger_p1) == 0):
		_bt_left_trigger_p1 = True
		gamepad.emit(uinput.BTN_JOYSTICK, 1)	
	if (_bt_left_trigger_p1) and (gpio.input(bt_left_trigger_p1) == 1):
		_bt_left_trigger_p1 = False
		gamepad.emit(uinput.BTN_JOYSTICK, 0)	
#bt right trigger =====================
	if (not _bt_right_trigger_p1) and (gpio.input(bt_right_trigger_p1) == 0):
		_bt_right_trigger_p1 = True
		gamepad.emit(uinput.BTN_8, 1)	
	if (_bt_right_trigger_p1) and (gpio.input(bt_right_trigger_p1) == 1):
		_bt_right_trigger_p1 = False
		gamepad.emit(uinput.BTN_8, 0)	
####DIRECTIONS P1 ###########################

#bt up =====================
	if (not _bt_up_p1) and (gpio.input(bt_up_p1) == 0):
		_bt_up_p1 = True
		gamepad.emit(uinput.ABS_Y, 0)	
	if (_bt_up_p1) and (gpio.input(bt_up_p1) == 1):
		_bt_up_p1 = False
		gamepad.emit(uinput.ABS_Y, 128)
#bt down =====================
	if (not _bt_down_p1) and (gpio.input(bt_down_p1) == 0):
		_bt_down_p1 = True
		gamepad.emit(uinput.ABS_Y, 255)	
	if (_bt_down_p1) and (gpio.input(bt_down_p1) == 1):
		_bt_down_p1 = False
		gamepad.emit(uinput.ABS_Y, 128)
#bt left =====================
	if (not _bt_left_p1) and (gpio.input(bt_left_p1) == 0):
		_bt_left_p1 = True
		gamepad.emit(uinput.ABS_X, 0)	
	if (_bt_left_p1) and (gpio.input(bt_left_p1) == 1):
		_bt_left_p1 = False
		gamepad.emit(uinput.ABS_X, 128)
#bt right =====================
	if (not _bt_right_p1) and (gpio.input(bt_right_p1) == 0):
		_bt_right_p1 = True
		gamepad.emit(uinput.ABS_X, 255)	
	if (_bt_right_p1) and (gpio.input(bt_right_p1) == 1):
		_bt_right_p1 = False
		gamepad.emit(uinput.ABS_X, 128)
	
	#------ player 2 -----------#
#bt a =====================
	if (not _bt_a_p2) and (gpio.input(bt_a_p2) == 0):
		_bt_a_p2 = True
		gamepad2.emit(uinput.BTN_0, 1)	
	if (_bt_a_p2) and (gpio.input(bt_a_p2) == 1):
		_bt_a_p2 = False
		gamepad2.emit(uinput.BTN_0, 0)	
#bt b =====================
	if (not _bt_b_p2) and (gpio.input(bt_b_p2) == 0):
		_bt_b_p2 = True
		gamepad2.emit(uinput.BTN_1, 1)	
	if (_bt_b_p2) and (gpio.input(bt_b_p2) == 1):
		_bt_b_p2 = False
		gamepad2.emit(uinput.BTN_1, 0)	
#bt x =====================
	if (not _bt_x_p2) and (gpio.input(bt_x_p2) == 0):
		_bt_x_p2 = True
		gamepad2.emit(uinput.BTN_2, 1)	
	if (_bt_x_p2) and (gpio.input(bt_x_p2) == 1):
		_bt_x_p2 = False
		gamepad2.emit(uinput.BTN_2, 0)	
#bt y =====================
	if (not _bt_y_p2) and (gpio.input(bt_y_p2) == 0):
		_bt_y_p2 = True
		gamepad2.emit(uinput.BTN_3, 1)	
	if (_bt_y_p2) and (gpio.input(bt_y_p2) == 1):
		_bt_y_p2 = False
		gamepad2.emit(uinput.BTN_3, 0)	
#bt l =====================
	if (not _bt_l_p2) and (gpio.input(bt_l_p2) == 0):
		_bt_l_p2 = True
		gamepad2.emit(uinput.BTN_4, 1)	
	if (_bt_l_p2) and (gpio.input(bt_l_p2) == 1):
		_bt_l_p2 = False
		gamepad2.emit(uinput.BTN_4, 0)	
#bt r =====================
	if (not _bt_r_p2) and (gpio.input(bt_r_p2) == 0):
		_bt_r_p2 = True
		gamepad2.emit(uinput.BTN_5, 1)	
	if (_bt_r_p2) and (gpio.input(bt_r_p2) == 1):
		_bt_r_p2 = False
		gamepad2.emit(uinput.BTN_5, 0)
#bt select =====================
	if (not _bt_select_p2) and (gpio.input(bt_select_p2) == 0):
		_bt_select_p2 = True
		gamepad2.emit(uinput.BTN_6, 1)	
	if (_bt_select_p2) and (gpio.input(bt_select_p2) == 1):
		_bt_select_p2 = False
		gamepad2.emit(uinput.BTN_6, 0)	
#bt start =====================
	if (not _bt_start_p2) and (gpio.input(bt_start_p2) == 0):
		_bt_start_p2 = True
		gamepad2.emit(uinput.BTN_7, 1)	
	if (_bt_start_p2) and (gpio.input(bt_start_p2) == 1):
		_bt_start_p2 = False
		gamepad2.emit(uinput.BTN_7, 0)
#bt left trigger =====================
	if (not _bt_left_trigger_p2) and (gpio.input(bt_left_trigger_p2) == 0):
		_bt_left_trigger_p2 = True
		gamepad2.emit(uinput.BTN_JOYSTICK, 1)	
	if (_bt_left_trigger_p2) and (gpio.input(bt_left_trigger_p2) == 1):
		_bt_left_trigger_p2 = False
		gamepad2.emit(uinput.BTN_JOYSTICK, 0)	
#bt right trigger =====================
	if (not _bt_right_trigger_p2) and (gpio.input(bt_right_trigger_p2) == 0):
		_bt_right_trigger_p2 = True
		gamepad2.emit(uinput.BTN_8, 1)	
	if (_bt_right_trigger_p2) and (gpio.input(bt_right_trigger_p2) == 1):
		_bt_right_trigger_p2 = False
		gamepad2.emit(uinput.BTN_8, 0)	

####DIRECTIONS P2 ###########################

#bt up =====================
	if (not _bt_up_p2) and (gpio.input(bt_up_p2) == 0):
		_bt_up_p2 = True
		gamepad2.emit(uinput.ABS_Y, 0)	
	if (_bt_up_p2) and (gpio.input(bt_up_p2) == 1):
		_bt_up_p2 = False
		gamepad2.emit(uinput.ABS_Y, 128)
#bt down =====================
	if (not _bt_down_p2) and (gpio.input(bt_down_p2) == 0):
		_bt_down_p2 = True
		gamepad2.emit(uinput.ABS_Y, 255)	
	if (_bt_down_p2) and (gpio.input(bt_down_p2) == 1):
		_bt_down_p2 = False
		gamepad2.emit(uinput.ABS_Y, 128)
#bt left =====================
	if (not _bt_left_p2) and (gpio.input(bt_left_p2) == 0):
		_bt_left_p2 = True
		gamepad2.emit(uinput.ABS_X, 0)	
	if (_bt_left_p2) and (gpio.input(bt_left_p2) == 1):
		_bt_left_p2 = False
		gamepad2.emit(uinput.ABS_X, 128)
#bt right =====================
	if (not _bt_right_p2) and (gpio.input(bt_right_p2) == 0):
		_bt_right_p2 = True
		gamepad2.emit(uinput.ABS_X, 255)	
	if (_bt_right_p2) and (gpio.input(bt_right_p2) == 1):
		_bt_right_p2 = False
		gamepad2.emit(uinput.ABS_X, 128)
	

	sleep(.02)

