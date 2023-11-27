use <libraries/openbox.scad>
use <libraries/screwpost.scad>

$fs = 0.4;

// Pieces of the part that will hold the GY521 board in place
module gy521_holder() {
    cube([5,24,12]);
    translate([0,0,11.99]) cube([5,1.6,8]);
    //translate([7,0,11.99]) cube([7,1.6,8]);
    translate([0,21.21,11.99]) cube([5,1.6,8]);
    translate([7,21.21,11.99]) cube([7,1.6,8]);
    translate([7,0,0]) cube([7,24,12]);
    
}

module gy521_main_box() {
    // Form the outer frame
    color("blue") openbox([31,26,22]);

    // Add the gy521 PCB holder
    color("#8080ff") translate([1.6,1.6,0]) gy521_holder();

    // Add the screw holder
    color("red") translate([27.25,22.25,0]) screwpost(20,3,2,8);

    // TODO: add cutout for grommet, generate lid
}

module gy521_grommet_hole() {

    translate([30.4,7,19.31])
    // Rotate and move the grmmet hole
    rotate([90,0,90])
    translate([0,0,-1.6]) 
    // Form the main grommet hole
    cylinder(h=3.2,r=3.1,$fa=1);

}

difference() {
    gy521_main_box();
    gy521_grommet_hole();
}