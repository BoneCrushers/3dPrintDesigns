# GY-521 (MPU6050) Accelerometer Case

## Purpose

The GY-521 case holds the accelerometer module to the side of one earcup.

The module is designed to be as light as possible and contains only the accelerometer module, which is cabled to the data logging interface box.

The GY-521 has a JST-XH 4-pin connector soldered on, to which is connected a 4-pin cable or a series of wires. The currently defined and implemented wire colors are:

Wire Color | Signal
-|-
**Black** | Ground
**Red** | +5V
**Yellow** | I2C Clock
**Green** | I2C Data

The other end of the 4-pin cable should be a JST-SM connector. The JST-SM has a physical locking lever to hold it in place, and also allows custom cable lengths to be created if needed.

## Parts needed

The links here often point to multiple quantities and sizes in kits. The quantity and size needed for the project are given. 

* 1x [GY-521/MPU6050 I2C Accelerometer Module](https://www.amazon.com/Pre-Soldered-Accelerometer-Raspberry-Compatible-Arduino/dp/B0BMY15TC4)
* 1x [3/8" rubber grommet](https://www.amazon.com/gp/product/B08BRJF5Z2/)
* 1x [JST-XH 4-pin female and male connector](https://www.amazon.com/gp/product/B08BRJF5Z2) (solder to the GY-521 across the first four pins - VCC, GND, SCL, SDA)
* 1x [JST-SM 4-pin female connector with crimping pins](https://www.amazon.com/Connector-Hosuing-Connectors-Adapter-Assortment/dp/B074LVGVTY) (you'll also need an appropriate crimp tool if you don't have one)
* Some length of 4-conductor cable

## Steps for assembly

1. Print the enclosure.
1. Solder the JST-XH 4-pin connector to the GY-521 module across the VCC, GND, SCL and SDA pins
1. Select a length of cable and slide a grommet onto the cable.
1. Assmble the cable with a male JST-XH on one end and a male JST-SM on the other. The pinout on the XH side should match the color code if at all possible; otherwise just make sure you are consistent with your wire colors.
1. Connect the JST-XH connector on the cable to the connector on the board.
1. Slide the grommet up to the housing and slot it into the cutout on the housing. Install the GY-521 into the housing by firmly pressing it into the slot.
1. Place the cover on the case and secure it with one M2.5 screw.
