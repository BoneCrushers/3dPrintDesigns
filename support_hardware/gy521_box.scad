use <openbox.scad>
use <screwpost.scad>

// Pieces of the part that will hold the GY521 board in place
module gy521_holder() {
    cube([5,24,12]);
    translate([7,0,0]) cube([7,24,12]);
}

// Form the outer frame
color("blue") openbox([31,26,22]);

// Add the gy521 PCB holder
color("#8080ff") translate([1.6,1.6,0]) gy521_holder();

// Add the screw holder
color("red") translate([27.25,22.25,0]) screwpost(18,3,2,8);

// TODO: add cutout for grommet, generate lid
