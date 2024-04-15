# Amplifier Box

## Purpose

The amplifier box provides a tidy way to manage the amplifier circuitry.

The box contains mounting points for the four MAX98306 amplifier boards and also contains all of the wiring to connect the amplifiers to power and signal inputs and outputs.

## Parts needed

The links here may point to multiple quantities and sizes in kits. The quantity and size needed for the project are given. 

* 4x [PAM8403 amplifier boards](https://www.amazon.com/HiLetgo%C2%AE-PAM8403-Digital-Amplifier-2-5-5V/dp/B00LODGV64)
* 2x [5 pin aviation connectors](https://www.amazon.com/dp/B07GZJYC91)
* 4x [3.5mm panel mount jacks](https://www.amazon.com/dp/B01C3RFHDC)
* 4x [3.5mm aux cables](https://www.amazon.com/dp/B07TCFQ3MG)
* Some bits of wire and connectors to connect everything together inside the box
    * Suggestion: use [solder seal connectors](https://www.amazon.com/dp/B083LZS69N) to make joining groups of wires easy with a [heat gun](https://www.amazon.com/gp/product/B08VFY8THD).

## Measurements

* *Aviation connector*: 16mm (less than 18mm) hole needed in model. Set to 16.4mm for tolerance.
* *3.5mm connector*: 6mm (less than 8mm) hole needed in model. Set to 8.4mm for tolerance.
* *PAM8403 amplifier board*:
    * 18mm (x) by 22mm (y)
    * Board has no mounting holes, so we can just use a bit of hot glue to hold it in place.
    * The 3D print design has a platform with cutouts to make room for the soldered pins, allowing the board to sit flush but slightly elevated from the bottom of the enclosure. 
* *5.5/2.1mm barrel jack*: 
    * 11.6mm wide point, 10.3mm narrow point
    * Narrow points on *sides* to make jack "vertical"

## Wiring

TODO: include a visual schematic of the wiring diagram

* Each 5-pin aviation connector connects to one ear cup of the headset. 
* **The PAM8403 is a differential amplifier**, therefore the negative terminals of the outputs *cannot* be tied together. However, we can simply ignore the negative outputs and use only the positive output to one side of each speaker, and connect the other side to the common system ground. This results in half the amplitude, but for this project that should be sufficient.
