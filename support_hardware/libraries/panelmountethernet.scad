// Panel mount Ethernet cutout

$fa=1;
$fs=0.4;

module ethernet_mount() {
    difference() {
        //cube([36,1.6,26]);
        rotate([90,0,0]) translate([0,12,0]) union() {
            cube([16.2,13.6,1.62],center=true); // center hole
            translate([-13.5,-1,-0.81]) cylinder(r=2,h=1.62);
            translate([13.5,-1,-0.81]) cylinder(r=2,h=1.62);
        };
    };
}
//translate([-18,-0.8,0]) cube([36,10,1.6]);
    