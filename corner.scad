include<config.scad>

module corner(h1=10,h2=10,d1=3+play,d2=3+play,s1=0,s2=0,)
{
    translate([0,-h1-s1,-h2-s2])
    difference()
    {
        union()
        {
            translate([-10,0,0])
            {
                cube([20,h1*2,3]);
                cube([20,3,h2*2]);
            }
            
            for(d=[1,-1])
            translate([-3/2+d*(10-3/2),0,0])
                cube([3,h1*2,h2*2]);
        }
        
        translate([-11,h1*2,0])
        rotate([atan(h1/h2),0,0])
            cube([22,sqrt(h1*h1+h2*h2),sqrt(h1*h1+h2*h2)*2]);
        
        //hole
        translate([0,h1+s1,-1])
            cylinder(h=5,d=d1);
        translate([0,4,h2+s2])
        rotate([90,0,0])
            cylinder(h=5,d=d2);
    }    
}

module corner2()
{
    translate([0,-10,0])
    rotate([0,0,180])
    translate([0,10,10])
        corner();
    translate([0,10,0])
    translate([0,10,10])
        corner();
}


corner();


