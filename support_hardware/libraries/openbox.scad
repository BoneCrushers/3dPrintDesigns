// generates an open-top box and lid
// by Flint Million
// November 2023

module openbox(size,ww=1.6,center=false) {

    // Generates a box with an open top.
    
    // size = dimensions of the box (either single value for cube or list for x,y,z)
    // ww = width of walls
    // center = center all axes over origin

    // Set the x, y, and z based on the input
    // if the input is a list, extract the three elements
    // otherwise copy the single element to all three axes (cube)
    x = is_list(size) ? size[0] : size;
    y = is_list(size) ? size[1] : size;
    z = is_list(size) ? size[2] : size;

    // Determine translate factors based on whether center is set or not
    // If center is not set box will sit in the positive quadrant entirely, starting at 0,0,0
    // If center is set box will be centered around the origin on all three axes
    tx = center ? 0 : x/2;
    ty = center ? 0 : y/2;
    tz = center ? -z/2 : 0;
    
    translate([tx,ty,tz]) {
        // Extrude and translate square and hole
         
        linear_extrude(height=z) 
        difference() {
            minkowski() {
                square([x-2.4,y-2.4],center=true);
                circle(r=1.2);
            }
            offset(-ww) square([x,y],center=true);
        }
        
        // Form the bottom of the box
        // Z is 0.01 units higher to avoid touching (not intersecting) walls
        translate([0,0,ww/2]) cube([x,y,ww+0.01],center=true);
    }
}

module openbox_lid(size,ww=1.6,offset=0.4,center=false) {
    // Generates a lid for a box made with openbox.
    
    // size = x and y dimensions of the box (either single value for square or list for x,y)
    // ww = width of walls
    // offset = How much smaller to make the inset (0.4mm is a good size - if it's exactly the same odds are the lid won't fit due to tolerances)
    // center = center all axes over origin

    x = is_list(size) ? size[0] : size;
    y = is_list(size) ? size[1] : size;
    
    tx = center ? -x/2 : 0;
    ty = center ? -y/2 : 0;
    tz = center ? -ww : 0;
    
    translate([tx+1.2,ty+1.2,tz]) {
        // Generate lid
        minkowski() {
            cube([x-2.4,y-2.4,ww-1.2]);
            cylinder(r=1.2,height=1);
        }
        // Generate inner lid
        translate([ww+offset,ww+offset,ww-0.01]) cube([x-(ww*2)-(offset*2),y-(ww*2)-(offset*2),ww+0.01]);
    }
}
