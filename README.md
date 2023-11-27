# Bone Crushers - 3D Printer Design Repository

This repository contains 3D printer files for the Bone Crushers project.

## Headset design

The headset design files are done in TinkerCAD, which does not currently offer a way to download and upload full object definition files (with individual parts intact) other than to use the Fusion360 file format. For now this repository will contain STL files for the parts generated from TinkerCAD. In the near future Fusion 360 format files will be included.

## Support hardware

Supporting hardware 3D prints are mostly for enclosures to hold related hardware:

* **GY521 Accelerometer Box**: A small enclosure to hold the GY-521 (MPU6050) accelerometer sensor to the side of the headset. This box is deliberately kept small, holding only the accelerometer, to minimize possible effects of weight biasing.
  * If necessary a matching dummy accelerometer box with roughly equal weight of the box + accelerometer module will be added for the opposing ear.
* **Accelerometer Data Logger Box**: A box to hold the hardware for reading and interpreting the accelerometer data and sending it to the PC during experimentation. The box needs two connectors - one for the accelerometer and one for a USB port to connect to a PC. The other hardware components inside include a custom PCB with an ATtiny85 microprocessor and a USB-to-serial adapter. The AVR firmware for this project will be added to another repository.

These files are for [OpenSCAD](https://openscad.org/), a paramteric modeling tool which incorporates its own scripting language allowing parts to be defined mathematically and functionally. OpenSCAD can then export to STL which can be used to perform the 3D print.
