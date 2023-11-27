use <libraries/openbox.scad>
use <libraries/screwpost.scad>

$fs = 0.4;

// Pieces of the part that will hold the GY521 board in place
module gy521_holder() {

    Y_MAX = GY_Y - (GY_WALL * 2);
    
    SHELF = 11;
    FRONT_THICK = 2.5;
    BOARD_THICK = 1;
    // bottom section
    cube([FRONT_THICK,5,SHELF]);
    translate([0,Y_MAX - 5,0]) cube([FRONT_THICK,5,SHELF]);
    
    translate([FRONT_THICK + BOARD_THICK,0,0]) cube([7,24,SHELF]);
    
    // top sections
    translate([FRONT_THICK + BOARD_THICK,Y_MAX - GY_WALL - 0.1,SHELF - 0.01]) cube([7,1.6,8]);
    translate([0,0,SHELF - 0.01]) cube([FRONT_THICK,1.6,8]);
    translate([0,Y_MAX - GY_WALL - 0.01,SHELF - 0.01]) cube([FRONT_THICK,1.6,8]);
    
}

GY_X = 25;
GY_Y = 26;
GY_Z = 22;
GY_WALL = 1.6;

module gy521_main_box() {
    
    // Form the outer frame
    color("#480059") openbox([GY_X,GY_Y,GY_Z]);

    // Add the gy521 PCB holder
    color("#9000B2") translate([GY_WALL,GY_WALL,0]) gy521_holder();

    // Add the screw holder
    color("#f7e400") translate([GY_X - 3.5,GY_Y - 3.5,0]) screwpost(20,3,2,8);
    // Screw hole position is 3.5 + (3 - 1) = 5.5 from edges
    
    // TODO: add cutout for grommet, generate lid
}

module gy521_grommet_hole() {

    hull() {
        translate([GY_X - (GY_WALL * 1.5),3.9,GY_Z - 3.1]) cube([GY_WALL * 2,6.2,6.2]);

        translate([GY_X - (GY_WALL / 2),7,GY_Z - 4.1])
        // Rotate and move the grmmet hole
        rotate([90,0,90])
        translate([0,0,-1.6]) 
        // Form the main grommet hole
        cylinder(h=GY_WALL * 2,r=3.1,$fa=1);
    }
}

module gy521_grommet_stub() {
    
    difference() {
        // start with cuboid
        translate([(GY_X * 2) + 10 - GY_WALL, 0, GY_WALL]) cube([GY_WALL,6.2,6.2]);

        // subtract circle
        translate([(GY_X * 2) - 0.01 + 10,3.1,3.1+GY_WALL])
        rotate([90,0,90])
        translate([0,0,-1.6]) 
        cylinder(h=GY_WALL+0.02,r=3.1,$fa=1);

        // subtract upper half of cuboid
        translate([(GY_X * 2) + 9.99 - GY_WALL, -0.01, GY_WALL + 0.99]) cube([GY_WALL+0.02,6.22,6.22]);
    }
}

module gy521_lid() {
    color("#f7e400") translate([GY_X + 10,0,0]) openbox_lid([GY_X,GY_Y],1.6);

    translate([0,GY_Y - (GY_WALL * 2) - 7,0]) gy521_grommet_stub();
    
}

// Generate pieces
difference() {
    gy521_main_box();
    gy521_grommet_hole();
}
difference() {
    gy521_lid();
    // subtract the screw hole
    translate([GY_X*2+10-4.5,4.5,-0.01]) cylinder(h=GY_WALL*2+0.02,r=1);
}