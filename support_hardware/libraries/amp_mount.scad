BOARD_X = 18;
BOARD_Y = 22;

BOARD_SOLDER_HEIGHT = 3;
BOARD_THICK = 1.2;

WALL_THICKNESS = 1.6;

TOLERANCE = 1.2;
TOLERANCE_X_ADD = 1;

$fs=0.4;
$fa=1;

// Calculated values
BASE_X = BOARD_X + (WALL_THICKNESS * 2) + TOLERANCE + TOLERANCE_X_ADD;
BASE_Y = BOARD_Y + (WALL_THICKNESS * 2) + TOLERANCE;
BASE_HEIGHT = 4;

module amp_mount_base() {
    // Make the main base        
    cube([BASE_X,BASE_Y,WALL_THICKNESS]);
}

module amp_mount_walls() {
    
    union() {

        // Make X=0 wall
        translate([0,0,WALL_THICKNESS-0.01]) cube([WALL_THICKNESS,BASE_Y,BASE_HEIGHT + TOLERANCE]);
        // Make X=X wall
        translate([BASE_X - WALL_THICKNESS,0,WALL_THICKNESS-0.01]) cube([WALL_THICKNESS,BASE_Y,BASE_HEIGHT + TOLERANCE]);

        // Make Y=0 wall
        translate([0,0,WALL_THICKNESS-0.01]) cube([BASE_X,WALL_THICKNESS,BASE_HEIGHT + TOLERANCE]);
        // Make Y=Y wall
        translate([0,BASE_Y - WALL_THICKNESS,WALL_THICKNESS-0.01]) cube([BASE_X,WALL_THICKNESS,BASE_HEIGHT + TOLERANCE]);
        
    }
}

module amp_mount_surface() {
    // Internal mounting surface for the board. Leaves room for the soldered pins.

    PIN_SPACING = 3; // with some tolerance

    difference() {
        color("green")
            cube([BOARD_X + TOLERANCE + TOLERANCE_X_ADD + 0.02, BOARD_Y + TOLERANCE + 0.02, BOARD_SOLDER_HEIGHT]);

        union() {

            translate([-0.01,-0.01,-0.01]) 
                color("red") 
                cube([PIN_SPACING * 3 + 0.04, PIN_SPACING + 0.02, BOARD_SOLDER_HEIGHT + 0.02]);

            translate([BASE_X - (WALL_THICKNESS * 2) - (PIN_SPACING*2) - 0.01, -0.01, -0.01]) 
                color("red")
                cube([PIN_SPACING * 2 + 0.04, PIN_SPACING + 0.02, BOARD_SOLDER_HEIGHT + 0.02]);
            
            translate([-0.01, BASE_Y - (WALL_THICKNESS * 2) - (PIN_SPACING) - 0.01, -0.01])
                color("red")
                cube([PIN_SPACING * 2 + 0.04, PIN_SPACING + 0.04, BOARD_SOLDER_HEIGHT + 0.02]);

            translate([BASE_X - (WALL_THICKNESS * 2) - (PIN_SPACING*2) - 0.01, BASE_Y - (WALL_THICKNESS * 2) - PIN_SPACING - 0.01, -0.01])
                color("red")
                cube([PIN_SPACING * 2 + 0.04, PIN_SPACING + 0.04, BOARD_SOLDER_HEIGHT + 0.02]);

        }
    }
}

module amp_mount_retention_bump() {

    RADIUS = 1.2;

    difference() {
        rotate([0,270,0])
            difference() {

                color("blue")
                    rotate([270,0,0])
                    cylinder(h=BOARD_Y - 7.4, r=RADIUS);

                translate([0 - RADIUS - 0.01,-0.01,-0.01])
                    cube([RADIUS * 2 + 0.02, BOARD_Y - 5.4 + 0.02, RADIUS + 0.02]);
            }
        
        translate([0 - RADIUS - 0.01, -0.01, -0.01])
                cube([RADIUS * 2 + 0.02, BOARD_Y - 5.4 + 0.02, RADIUS + 0.02]);
    }
}

module amp_mount() {
    amp_mount_base();
    amp_mount_walls();
    translate([WALL_THICKNESS-0.01, WALL_THICKNESS-0.01, WALL_THICKNESS-0.01]) amp_mount_surface();
}

module amp_mount_retention_bumps() {}
    translate([WALL_THICKNESS,WALL_THICKNESS + 4.25, BASE_HEIGHT + BOARD_THICK + 0.4 + WALL_THICKNESS - 0.41])
        amp_mount_retention_bump();
    translate([BASE_X - WALL_THICKNESS,WALL_THICKNESS + 4.25, BASE_HEIGHT + BOARD_THICK + 0.4 + WALL_THICKNESS - 0.41])
        rotate([0,180,0])
        mirror([0,0,1])
        amp_mount_retention_bump();


