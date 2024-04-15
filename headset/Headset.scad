$fa=1;
$fs=0.4;

module ellipse(x=97, y=118, z=1) {
    linear_extrude(z) rotate(90) resize([y,x]) translate([x/2, -x/2]) circle(x/2);
}

module ellipse_hollow(x=97, y=118, z=10, thickness=2) {
    difference() {
        ellipse(x, y, z);
        translate([thickness, thickness, -0.01]) ellipse(x-(thickness*2), y-(thickness*2), z+0.02);
    }
}

module base() {
    difference() {
        ellipse(x=97,y=118,z=0.6);
        translate([25,24,-0.01]) ellipse(x=47,y=70,z=1.02);
    }
}
module frame() {
    ellipse_hollow(x=97, y=118, z=15, thickness=2);
    translate([25, 24]) ellipse_hollow(x=47, y=70, z=15, thickness=2);
}

module transducer_holder() {
    difference() {
        cube([25.25, 18, 10]);
        translate([2, 2, -0.01]) cube([21.25, 14, 10.02]);
        translate([-0.01, -0.01, -0.01]) cube([4.02, 4.02, 10.02]);
        translate([-0.01, 13.99, -0.01]) cube([4.02, 4.02, 10.02]);
        translate([21.24, -0.01, -0.01]) cube([4.02, 4.02, 10.02]);
        translate([21.24, 13.99, -0.01]) cube([4.02, 4.02, 10.02]);
    }
}

module strap_loop() {
    difference() {
        cube([7.6, 20.4, 2]);
        translate([2, 2, -0.01]) cube([5.6, 16.4, 2.02]);
    }
}

// START CONSTRUCTION - RIGHT EARPIECE

module headset_right() {
    // The main headphone base
    base();
    difference() {
        frame();
        translate([15.25, 9, 5]) cube([11, 7, 10.01]);
    }

    // The holes for the pegs from the other half
    color("red") translate([16,18,0.01]) ellipse_hollow(x=17, y=17, z=11.25, thickness=2);
    color("red") translate([64,18,0.01]) ellipse_hollow(x=17, y=17, z=11.25, thickness=2);
    color("red") translate([16,83,0.01]) ellipse_hollow(x=17, y=17, z=11.25, thickness=2);
    color("red") translate([64,83,0.01]) ellipse_hollow(x=17, y=17, z=11.25, thickness=2);

    // The transducer holders
    translate([97 / 2 - (25.25 / 2), 5.5, 0.4]) transducer_holder();
    translate([97 / 2 - (25.25 / 2), 94.5, 0.4]) transducer_holder();
    translate([5.5, 118 / 2 - (25.25 / 2), 0.4]) translate([18, 0, 0]) rotate(90) transducer_holder();
    translate([74.5, 118 / 2 - (25.25 / 2), 0.4]) translate([18, 0, 0]) rotate(90) transducer_holder();

    // The strap loop
    translate([-5, 118 / 2 - (20.4 / 2), 0.01]) strap_loop();
}

module headset_cover() {

    difference() {
        ellipse(x=93,y=114,z=2);
        translate([24.5,24,-0.01]) ellipse(x=44,y=66,z=2.02);
    }

    color("blue") translate([14,16,0.01]) translate([8.4,8.4]) cylinder(h=10, r=6.2);
    color("blue") translate([62,16,0.01]) translate([8.4,8.4]) cylinder(h=10, r=6.2);
    color("blue") translate([14,81,0.01]) translate([8.4,8.4]) cylinder(h=10, r=6.2);
    color("blue") translate([62,81,0.01]) translate([8.4,8.4]) cylinder(h=10, r=6.2);

}

color("#480059") headset_right();

color("#f7e400") translate([100, 0, 0])  headset_cover();