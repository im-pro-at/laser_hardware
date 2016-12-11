include <config.scad>;

module megamound()
{
    translate([-110/2,-15,0])
    difference()
    {
        translate([3,3,0])
        {
            cc=[ [15.24,50.8],[90.17,50.8],
                        [66.04,35.56],[66.04,7.62],
                        [13.97,2.54],[96.52,2.54]];
            difference()
            {   
                union()
                {
                    translate([-3,-3,0])
                        cube([110,60,3]);
                    for(c=cc)
                    translate([c[0],c[1],1])
                        cylinder(h=3-1+3,r=6/2);
                }
                
                for(c=cc)
                translate([c[0],c[1],-1])
                    cylinder(h=3+3+2,r=3/2 + play);
            }
        }
        
        for(d=[1,-1])
        translate([110/2+d*80/2,15,-1])
            cylinder(h=3+2,r=3/2+play);
        
    }
}

megamound();