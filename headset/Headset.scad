$fa=1;
$fs=0.4;

module curved_top(r=1) {
    sphere(r);
    translate([0,0,-r+0.01]) cylinder(r,r,r);
}

module ellipse(x=97, y=118, z=1) {
    linear_extrude(z) rotate(90) resize([y,x]) translate([x/2, -x/2]) circle(x/2);
}

module ellipse_hollow(x=97, y=118, z=10, thickness=2) {
    difference() {
        ellipse(x, y, z);
        translate([thickness, thickness, -0.01]) ellipse(x-(thickness*2), y-(thickness*2), z+0.02);
    }
}

module ellipse_hollow2(x=97,y=118,z=10,thickness=2) {

    translate([x/2, y/2, 0]) linear_extrude(z) {
        difference() {
            scale([x/(2*thickness), y/(2*thickness), 1]) circle(thickness);
            offset(r = -thickness) scale([x/(2*thickness), y/(2*thickness), 1]) circle(thickness);
        }
    }
}

module base() {
    ellipse_hollow(x=97,y=118,z=0.6,thickness=25);
    // difference() {
    //     ellipse(x=97,y=118,z=0.6);
    //     translate([25,24,-0.01]) ellipse(x=47,y=70,z=1.02);
    // }
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

module headset(right=false) {
    // The main headphone base
    base();
    difference() {
        frame();
        if (right==true) {
            //Right
            translate([15.25, 9, 5]) cube([11, 7, 10.01]);
        }
        else {
            // Left
            translate([71.25, 9, 5]) cube([11, 7, 10.01]);
        }
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

    if (right==true) {
        // Right
        translate([-5, 118 / 2 - (20.4 / 2), 0.01]) strap_loop();
    }
    else {
        // Left
        translate([97 + 5, 118 / 2 - (20.4 / 2), 0.01]) mirror([1,0,0])  strap_loop();
    }
    // Top
    translate([38.3,118-2.6,0.01]) rotate(270) translate([-7.6,0,0]) strap_loop();

}

module headset_cover() {

    ellipse_hollow2(x=93,y=114,z=2,thickness=22);
    // difference() {
    //     ellipse(x=93,y=114,z=2);
    //     translate([22,20,-0.01]) ellipse(x=43,y=76,z=2.02);
    // }

    minkowski() {
        color("blue") translate([14,16,1.01]) translate([8.4,8.4]) cylinder(h=9, r=5.8);
        curved_top(1);
    }
    minkowski() {
        color("blue") translate([62,16,1.01]) translate([8.4,8.4]) cylinder(h=9, r=5.8);
        curved_top(1);
    }        
    minkowski() {
        color("blue") translate([14,81,1.01]) translate([8.4,8.4]) cylinder(h=9, r=5.8);
        curved_top(1);
    }
    minkowski() {
        color("blue") translate([62,81,1.01]) translate([8.4,8.4]) cylinder(h=9, r=5.8);
        curved_top(1);
    }

}

translate([2,2,0]) color("#f7e400") headset_cover();

//color("#faa",alpha=0.5) translate([0,0,0]) headset(right=false);

