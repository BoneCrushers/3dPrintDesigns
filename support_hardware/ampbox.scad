// Amplifier box 
// for The Bone Crusher (Bone Conduction Headset Project)

// design by Flint Million - 11-2023

// History:
//  v3 - switch to panel mount Ethernet jacks
//       enlarge box for easier wire management
//         and to fit ethernet jacks better
//  v2 - fix 3.5mm hole size
//       fix hole spacing for amps
//  v1 - initial test
//       * oops mistyped the size of the 3.5mm jack holes
//         (should have been 6mm, not 8mm)
//       * amp holes too close together

// Note - OpenSCAD (and STL) does not explicitly define the "unit".
// However, the default is to treat one unit in SCAD as one millimeter.
// If you are trying to figure out this model's details, consider that all numbers represent millimeter sizes.

// use some convenience libraries
use <libraries/openbox.scad>
use <libraries/screwpost.scad>
use <libraries/amp_mount.scad>
use <libraries/panelmountethernet.scad>

$fs = 0.4; // 0.4mm minimum feature size for 3d printing

// Static values storing the literal size of the MAX98306 PCB
MX_PCB_X = 28; MX_PCB_Y = 24; MX_PCB_Z = 1.6;

// Sizes of the full MX module including attachments, solder joins etc
MX_X = MX_PCB_X;        // no extensions across board
MX_Y = MX_PCB_Y + 5;    // includes right angle Dupont pins
MX_Z = MX_PCB_Z + 17.4; // includes height of jumper pin + jumper

// Hole sizes
//AVI_HOLE = 16.4;        // spec sheet says 16mm, give 0.4mm for tolerance
PHONE_HOLE = 6.4;       // measured with caliper at 6mm, give 0.4mm for tolerance
DC_HOLE_1 = 12;         // measured with caliper at 11.6mm
DC_HOLE_2 = 10.6;       // measured with caliper at 10.3mm

WALL = 1.6;             // 1.6mm wall thickness

// Box thickness is currently arbitrary but we'll make it 50.8mm (2 inches).
BOX_Z = 60.8;

J_DIST_FROM_TOP = 12;
D_DIST_FROM_BOTTOM = WALL + 8;
//A_DIST_FROM_TOP = 8;
A_DIST_FROM_TOP = 28;
L_DIST_FROM_BOTTOM = WALL + 11;

// The size (x,y) of the box will be:
//   * two walls
//   * two amps
//   * 10mm clearance between each amp and edge in x axis (3 clearances)
//   * 20mm clearance between each amp in y axis
//   * extra 10mm clearance in the front and back for cabling, screw posts...

BOX_X = (WALL * 2) + (MX_X * 2) + 60;
BOX_Y = (WALL * 2) + (MX_Y * 2) + 70;

module amp_mainbox() {
    
    // Generate the box and remove the mounting holes for the connectors
    difference() {

        // Main box frame
        color("#f7e400") openbox([BOX_X,BOX_Y,BOX_Z]);

        // Four holes for the 3.5mm jacks
        // To compute the formula for jack positioning we will determine the *center point* for each jack.
        // To do this we simply take the available width and divide it by one more than the number of jacks.
        // This gives us the distance between center points for each of the four jacks.
        // Then we can figure out the left point per jack by subtracting the radius from each center point.

        C_DIST = BOX_X / 5;

        for (J = [1 : 4]) {
            color("green") translate([C_DIST * J, 0, BOX_Z - J_DIST_FROM_TOP - PHONE_HOLE])
                // moving UPWARDS from cylinder, at this point the cylinder's center point is at 0,0,0 and it's rotated vertically.
                translate([0,WALL*2,PHONE_HOLE / 2])
                rotate([90,0,0])
                cylinder(h=WALL*3,r=PHONE_HOLE / 2);
        }

        // One hole for the barrel power jack with straightened sides for keying
        // Center the hole along the x axis.
        color("red") translate([BOX_X / 2,-WALL,D_DIST_FROM_BOTTOM]) amp_dc_hole();

        // Two panel mount ethernet mount points
        A_DIST = BOX_X / 3;
        for (J = [1 : 2]) {
            color("cyan") translate([A_DIST * J + (J == 2 ? 6 : -6) + WALL, BOX_Y - WALL, BOX_Z - A_DIST_FROM_TOP])
                scale([1,3,1])
                ethernet_mount();
        }

        // // Two holes for the aviation jacks
        // A_DIST = BOX_X / 3;

        // for (J = [1 : 2]) {
        //     color("cyan") translate([A_DIST * J + WALL, BOX_Y - WALL, BOX_Z - A_DIST_FROM_TOP - AVI_HOLE])
        //         // moving UPWARDS from cylinder, at this point the cylinder's center point is at 0,0,0 and it's rotated vertically.
        //         translate([0,WALL*2,AVI_HOLE / 2])
        //         rotate([90,0,0])
        //         cylinder(h=WALL*3,r=AVI_HOLE / 2);
        // }

        // a 5mm hole for a power LED
        // slightly undersized for a snug fit (v2)
        // Put the hole directly below the rightmost 3.5mm jack
        color("red") translate([C_DIST * 4, 0, L_DIST_FROM_BOTTOM])
            translate([0,WALL*2+0.1,2.6])
            rotate([90,0,0])
            cylinder(h=WALL*3,r=2.4);

        // a 5mm hole for a power switch
        // Put the hole directly below the leftmost 3.5mm jack
        color("red") translate([C_DIST * 1, 0, L_DIST_FROM_BOTTOM])
            translate([0,WALL*2,2.5])
            rotate([90,0,0])
            cylinder(h=WALL*3,r=2.5);

    }
    
    // Add lid screw posts
    SP_DIST=0.5; // 0.5mm from edges of box
    translate([3+SP_DIST,3+SP_DIST,WALL-0.01]) screwpost(h=BOX_Z - WALL - 2, r=3, t=2, sh=10);
    translate([BOX_X - (3+SP_DIST),3+SP_DIST,WALL-0.01]) screwpost(h=BOX_Z - WALL - 2, r=3, t=2, sh=10);
    translate([BOX_X - (3+SP_DIST), BOX_Y - (3+SP_DIST),WALL-0.01]) screwpost(h=BOX_Z - WALL - 2, r=3, t=2, sh=10);
    translate([3+SP_DIST,BOX_Y - (3+SP_DIST),WALL-0.01]) screwpost(h=BOX_Z - WALL - 2, r=3, t=2, sh=10);

    // Each amplifier needs two little screw posts.
    // Amps are mounted with Duponts facing *forward* so we measure from the back.
    // Example: first amp PCB edge is 10mm from both left and back wall,
    // and screw post is 1.2mm in from edge.
    // Screw hole diameter is 2mm, post diamater is 6mm
    // So the screw hole left and top position must be 3mm from the screw hole
    // Math: Since screw hole is 1.2mm in on both axes, screw post edge is simply 1.8mm from corner of PCB.

    // V2 - NO MORE AMP SCREW POSTS, Instead we do ampbox mounts.
    // for (AMP = [0 : 3]) {
    //     X_ADD = (AMP % 2 == 1); // if amp % 2 is not 0, shift on X axis
    //     Y_ADD = (floor(AMP / 2) == 1); // if amp / 2 > 0, shift on Y axis

    //     // for amp 0
    //     AMP_CORNER_X = WALL + 10 - 3.0;
    //     AMP_CORNER_Y = BOX_Y - WALL - 25 + 1.8;

    //     // if add x, shift over by one amp + 10mm gap
    //     AMP_CORNER_X2 = X_ADD ? AMP_CORNER_X + MX_X + 20 : AMP_CORNER_X;
    //     // same for y
    //     AMP_CORNER_Y2 = Y_ADD ? AMP_CORNER_Y - MX_Y - 20 : AMP_CORNER_Y;

    //     color("#480059") translate([AMP_CORNER_X2, AMP_CORNER_Y2, WALL]) screwpost(h=6,r=3,t=2,sh=6);
    //     color("#480059") translate([AMP_CORNER_X2 + (MX_PCB_X - 4.8), AMP_CORNER_Y2, WALL]) screwpost(h=6,r=3,t=2,sh=6);

    // }

    // The amp mount plates are 23.4mm (x) by 26.4mm (y)
    AMP_PLATE_X = 23.4;
    AMP_PLATE_Y = 26.4;

    for (AMP = [0 : 3]) {
        X_ADD = (AMP % 2 == 1); // if amp % 2 is not 0, shift on X axis
        Y_ADD = (floor(AMP / 2) == 1); // if amp / 2 > 0, shift on Y axis

        // for amp 0
        AMP_CORNER_X = WALL + 25 - 3.0;
        AMP_CORNER_Y = BOX_Y - WALL - 40 + 1.8;

        // if add x, shift over by one amp + 10mm gap
        AMP_CORNER_X2 = X_ADD ? AMP_CORNER_X + AMP_PLATE_X + 30 : AMP_CORNER_X;
        // same for y
        AMP_CORNER_Y2 = Y_ADD ? AMP_CORNER_Y - AMP_PLATE_Y - 30 : AMP_CORNER_Y;

        color("#480059") translate([AMP_CORNER_X2, AMP_CORNER_Y2, WALL - 0.01]) amp_mount();

    }
}

module amp_dc_hole() {

    // this is a bit convoluted but it'll subtract the two sides from the circle
    CUTOUT_OUTER = DC_HOLE_1 + 10;

    difference() {
        // first we form the hole
        translate([0,WALL*3,DC_HOLE_1 / 2])
        rotate([90,0,0])
        cylinder(h=WALL*3,r=DC_HOLE_1 / 2);

        difference() {
            color("blue") translate([-(CUTOUT_OUTER/2),-WALL-0.1,-5])
                cube([CUTOUT_OUTER,WALL*3+0.2,CUTOUT_OUTER]);        
            color("cyan") translate([-(DC_HOLE_2/2),-WALL-0.1,-5])
                cube([DC_HOLE_2,WALL*3+0.2,CUTOUT_OUTER]);
        }
    }
}

module amp_lid() {

    difference() {
        // Make lid first
        openbox_lid([BOX_X,BOX_Y],offset=WALL/2);
        // Remove screw holes
        color("blue") translate([WALL+2-0.1,WALL+2-0.1,-0.01]) cylinder(r=1.6,h=WALL*2+0.02);
        color("blue") translate([BOX_X - (WALL+2-0.1),WALL+2-0.1,-0.01]) cylinder(r=1.6,h=WALL*2+0.02);
        color("blue") translate([BOX_X - (WALL+2-0.1),BOX_Y - (WALL+2),-0.01]) cylinder(r=1.6,h=WALL*2+0.02);
        color("blue") translate([WALL+2-0.1,BOX_Y - (WALL+2-0.1),-0.01]) cylinder(r=1.6,h=WALL*2+0.02);
    }
}
amp_mainbox();
color("#480059") translate([BOX_X+10,0,0]) amp_lid();

