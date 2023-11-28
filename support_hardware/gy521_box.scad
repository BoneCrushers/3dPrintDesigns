// GY521 container box
// TODO make some sort of headset mount

// design by Flint Million - 11-2023

// History:
//  v5 - made grommet hole even deeper
//  v4 - made grommet hole deeper
//       made grommet stub higher
//       made box a bit shorter
//       * almost perfect, grommet hole needs to be a bit deeper
//  v3 - parameterize the grommet hole
//       reduce height of channel on left front edge to accommodate IC
//       use math to position both the grommet hole and the grommet stub on the lid
//       * fits perfectly, grommet won't fit though
//  v2 - widen the IC slot
//       make grommet hole bigger (diameter wise)
//       * the board doesn't slot all the way down, small 6-pin SOIC in the way
//       * the grommet still won't fit, make even larger (parameterize)
//       * the grommet hole doesn't match with the slot in the lid (parameterize)
//  v1 - initial test
//       * IC does not fit, too narrow
//       * grommet does not fit
//       * box won't close

use <libraries/openbox.scad>
use <libraries/screwpost.scad>

$fs = 0.4;

// Sets the global size of the main box
GY_X = 25;              //  /
GY_Y = 26;              // <-- size of overall box sans lid
GY_Z = 20;              //  \ 
GY_WALL = 1.6;          // thickness of box wall
GROMMET = 4.25;         // radius of grommet hole

// Pieces of the part that will hold the GY521 board in place
module gy521_holder() {

    Y_MAX = GY_Y - (GY_WALL * 2);
    
    SHELF = 11;
    FRONT_THICK = 2.5;
    BOARD_THICK = 1.8;
    SIDE_THICK = 2;

    // bottom section
    cube([FRONT_THICK,5,SHELF/2]); // a bit lower to accommodate the IC
    translate([0,Y_MAX - 5,0]) cube([FRONT_THICK,5,SHELF]);
    translate([FRONT_THICK + BOARD_THICK,0,0]) cube([7,24,SHELF]);
    
    // top sections
    translate([FRONT_THICK + BOARD_THICK,Y_MAX - SIDE_THICK + 0.01,SHELF - 0.01]) cube([7,SIDE_THICK,GY_Z-14]);
    //translate([0,0.01,SHELF/2 - 0.01]) cube([FRONT_THICK,SIDE_THICK,8+(SHELF/2)]);
    translate([0,Y_MAX - SIDE_THICK + 0.01,SHELF - 0.01]) cube([FRONT_THICK,SIDE_THICK,GY_Z-14]);
    
}

module gy521_main_box() {
    
    // Form the outer frame
    color("#480059") openbox([GY_X,GY_Y,GY_Z]);

    // Add the gy521 PCB holder
    color("#9000B2") translate([GY_WALL,GY_WALL,0]) gy521_holder();

    // Add the screw holder
    color("#f7e400") translate([GY_X - 3.5,GY_Y - 3.5,0]) screwpost(GY_Z - GY_WALL - 1,3,2,8);
    // Screw hole position is 3.5 + (3 - 1) = 5.5 from edges
}

module gy521_grommet_hole() {

    hull() {
        translate([GY_X - (GY_WALL * 1.5),3.9,GY_Z - GROMMET]) cube([GY_WALL * 2,GROMMET*2,GROMMET*2.25]);

        // Rotate and move the grmmet hole
        translate([GY_X - (GY_WALL / 2),GROMMET*2,GY_Z - (GROMMET * 1.66)])
        // rotate and correct for grommet hole prior to translate
        rotate([90,0,90])
        translate([0,0,-GY_WALL])
        // Form the main grommet hole
        cylinder(h=GY_WALL * 2,r=GROMMET,$fa=1);
    }
}

module gy521_grommet_stub() {
    
   difference() {
        // start with cuboid
        translate([(GY_X * 2) + 10 - GY_WALL, (GROMMET*2)-((GROMMET*2)*0.95), GY_WALL]) cube([GY_WALL,(GROMMET*2)*0.9,GROMMET*2]);

        // subtract circle
        color("white") translate([
            (GY_X * 2) + 9.99,
            GROMMET,
            GROMMET + GY_WALL + 1.25])
        rotate([90,0,90])
        translate([0,0,-1.6]) 
        cylinder(h=GY_WALL+0.02,r=GROMMET,$fa=1);

        // subtract upper half of cuboid
        translate([
            (GY_X * 2) + 9.99 - GY_WALL, 
            -0.01, 
            GY_WALL + 2.5
        ]) cube([GY_WALL+0.02,GROMMET*2+0.02,GROMMET*2+0.02]);
    }
}

module gy521_lid() {
    color("#f7e400") translate([GY_X + 10,0,0]) openbox_lid([GY_X,GY_Y],1.6,offset=0.8);

    translate([0,GY_Y - (GY_WALL * 2) - (GROMMET * 2) ,0]) gy521_grommet_stub();
}

// Generate pieces
difference() {
    gy521_main_box();
    gy521_grommet_hole();
}
difference() {
    gy521_lid();
    // subtract a gap for the grommet thickness
    translate([
        GY_X*2+10-(GY_WALL*3),
        GY_Y - (GY_WALL * 2) - (GROMMET * 2.25),
        GY_WALL+0.01
    ]) 
        cube([GY_WALL*2,(GROMMET*3),GROMMET*2]);     
    // subtract the screw hole
    translate([GY_X*2+10-4.5,4.5,-0.01]) cylinder(h=GY_WALL*2+0.02,r=1);
}
