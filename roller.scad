include <config.scad>;


module roller()
{
    difference()
    {
        union()
        {
            resize([19,19,6])
                sphere(d=1);
            translate([0,0,-3])
                cylinder(h=10,d=8);
        }
        translate([0,0,-4])
            cylinder(h=12,d=5);
    }
}

module vroller()
{
    color([0.3,0.3,0.3,1])
    difference()
    {
        union()
        {
            rotate_extrude(convexity =100)
            {
                translate([0,-5.78/2])
                    square([15.23/2,5.78]);

                translate([0,-8.8/2])
                    square([12.21/2,8.8]);
                
                translate([12.21/2,-8.8/2])
                rotate([0,0,45])
                    square([sqrt(pow((8.8-5.78)/2,2)
                        +pow((8.8-5.78)/2,2)),3]);
                translate([15.23/2,5.78/2])
                rotate([0,0,180-45])
                    square([sqrt(pow((8.8-5.78)/2,2)
                        +pow((8.8-5.78)/2,2)),3]);
            }
            
            cylinder(h=9,d=10,center=true);
        }

        cylinder(h=10.8,d=5,center=true);
    }
}


vroller();