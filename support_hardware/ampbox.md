# Amplifier Box

## Purpose

The amplifier box provides a tidy way to manage the amplifier circuitry.

The box contains mounting points for the four MAX98306 amplifier boards and also contains all of the wiring to connect the amplifiers to power and signal inputs and outputs.

## Parts needed

The links here may point to multiple quantities and sizes in kits. The quantity and size needed for the project are given. 

* 4x [PAM8403 amplifier boards](https://www.amazon.com/HiLetgo%C2%AE-PAM8403-Digital-Amplifier-2-5-5V/dp/B00LODGV64)
* 2x [panel mount Ethernet connectors](https://www.amazon.com/gp/product/B06Y4J9MZ4)
* 4x [3.5mm panel mount jacks](https://www.amazon.com/dp/B01C3RFHDC)
* 4x [3.5mm aux cables](https://www.amazon.com/dp/B07TCFQ3MG)
* Some bits of wire and connectors to connect everything together inside the box
    * Suggestion: use [solder seal connectors](https://www.amazon.com/dp/B083LZS69N) to make joining groups of wires easy with a [heat gun](https://www.amazon.com/gp/product/B08VFY8THD).

## Measurements

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

* Each ear of the headset uses an Ethernet (RJ45) connector.
    * Wiring for each ear: 
        * Bottom: brown/brown-white
        * Front: green/green-white
        * Back: blue/blue-white
        * Top: orange/orange-white
    * When looking at the QC Passed sticker on the transducer, the solid color wire should be soldered to the *left* terminal. Don't mix these up - messing up the polarity can result in phase issues with sound output, producing inaccurate results.
