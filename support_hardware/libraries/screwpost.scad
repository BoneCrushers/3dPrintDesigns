// generates screw posts 
// by Flint Million
// November 2023

module screwpost(h,r,t,sh)
{
    $fs=0.4;
    // Make a screw post.
    // h = height of entire post
    // r = radius of entire post
    // t = diameter of screw hole
    // sh = depth of screw hole

    difference() {
        // The main cylinder
        cylinder(h,r,r,$fa=360/45);
    
        // The screw hole
        translate([0,0,h - sh]) { cylinder(sh + 0.1,d=t); }
        // 0.1mm addition to translation/length to ensure the
        // hole "penetrates" the skin of the larger cylinder
    }
}
