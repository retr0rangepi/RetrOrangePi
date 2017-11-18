# GPIO Controller for RetrOrangePi

### Credits: duxingkei33/orangepi_PC_gpio_pyH3, olimex pyA20, recalbox/mk_arcade_joystick_rpi, gamecon_gpio_rpi, wiringPi
### ROPi port: ericktarzia, forked by pjmcardle to support 10 buttons per player vs. original 8

Check if your controllers are recognized in emulationstation after a reboot.

## GPIO Driver

![GPIO](https://raw.githubusercontent.com/recalbox/mk_arcade_joystick_rpi/master/wiki/images/mk_joystick_arcade_GPIOsb%2B.png)

You can also add the following 4 button inputs beyond what the image above shows:
Player 1: pins 3 & 27
Player 2: pins 5 & 28

## NES Driver

The driver supports up to 4 controllers of NES gamepads (2 gamepads are configured by default).

The pinout summary can be seen below. The power, ground, clock and latch pins are common for all pads, thus requiring splitters (i.e. a breadboard + pinheaders) when using multiple pads.

![NES](https://camo.githubusercontent.com/4f55cfef987cc7b05bb66f4eb63a3b6ce79e3c9b/687474703a2f2f7777772e6e696b73756c612e6875742e66692f2537456d686969656e6b612f5270692f696d616765732f67616d65636f6e5f6770696f5f7270692e706e67)

Happy gaming!
