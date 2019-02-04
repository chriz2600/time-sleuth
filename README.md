# Time Sleuth - Open Source Lag Tester

## Hardware

Hardware by [**citrus3000psi**](https://twitter.com/citrus3000psi)

Kicad project can be found here: [github.com/citrus3000psi/Time-Sleuth](https://github.com/citrus3000psi/Time-Sleuth).

## Operation

Time Sleuth generates a flicker pattern and then measures the time it takes from the start of the first pattern to the moment it shows up on screen using a photo transistor.

<img src="assets/time-sleuth.jpg" width="100%"/>

The counter measuring the lag starts at the first line of the first field. So if you're using a display, which generates the image from top to bottom (line by line, as LCD/OLED/CRT monitors/TVs will do), the first field will give you the processing lag of the screen, while the second and third field will also include the lag inherent to the line by line drawing of the image.

There are 4 values displayed on the screen:

- `current`

  Shows the value of the last measurement.

- `min/max`

  Minimum and maximum value within the last averaging period.

- `average`

  Average value of the last **32** measurements. Most LED backlit LCD screens are using pulse width modulation for brightness adjustment and the PWM duty cycle of the backlight is often not 100% even if brightness is. So the current readings are often jumping, so `average` gives you the mean lag. 

<img src="assets/time-sleuth-hw.jpg" width="100%"/>

- ***LED***

  Flashes, when a measurement was performed.

- ***Switch***

  Switches between 1080p (`1`), 720p (`2`) and VGA (`3`) output.

  *VGA will be changed to 480i in a future firmware revision*

- ***10pin JTAG connection***

  JTAG interface for updateing the firmware using an USB Blaster.

- ***Crosshair***

  The crosshair indicates the position of the photo transistor on the bottom of the device and helps aligning over the measurement fields.
