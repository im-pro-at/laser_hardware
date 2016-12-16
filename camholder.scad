include<config.scad>

rotate([90,0,0])
difference()
{
    union()
    {
        cube([32,12,3]);
        translate([(32-15)/2,0,0])
            cube([15,12,10]);
    }

    translate([32/2,13,7/2])
    rotate([90,0,0])
    {
        cylinder(h=14,r=7/2);
        translate([-7/2,-7,0])
            cube([7,7,14]);
    }
    for(d=[-1,1])
    translate([32/2+d*(32/2-3.5),12/2,-1])
        cylinder(h=5,r=3/2);
}