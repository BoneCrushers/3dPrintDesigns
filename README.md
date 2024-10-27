# Bone Crushers - 3D Printer Design Repository

This repository contains 3D printer files for the Bone Crushers project.

## Headset design

The headset design is in [OpenSCAD](https://openscad.org/) format, based directly on the original TinkerCAD design. The design has been accurately replicated into OpenSCAD format. To 3D-print the objects, use OpenSCAD to generate STL files, then use a slicer to prepare a Gcode file for 3D printing on your specific printer.

## Support hardware

Supporting hardware 3D prints are mostly for enclosures to hold related hardware:

* **Headset Interface Box**: Connects the headset to the sound interface. Neatly conceals all of the complex wiring, amplifiers and connections.
* **GY521 Accelerometer Box**: A small enclosure to hold the GY-521 (MPU6050) accelerometer sensor to the side of the headset. This box is deliberately kept small, holding only the accelerometer, to minimize possible effects of weight biasing.
  * If necessary a matching dummy accelerometer box with roughly equal weight of the box + accelerometer module will be added for the opposing ear.
* **Accelerometer Data Logger Box**: A box to hold the hardware for reading and interpreting the accelerometer data and sending it to the PC during experimentation. The box needs two connectors - one for the accelerometer and one for a USB port to connect to a PC. The other hardware components inside include a custom PCB with an ATtiny85 microprocessor and a USB-to-serial adapter. The AVR firmware for this project will be added to another repository.
