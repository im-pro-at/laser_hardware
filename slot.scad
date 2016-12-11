include<config.scad>;

//Vlost
module vslot(h,a=1)
{
    color(aluminum,a)
    translate([0,0,-h/2])
    difference()
    {
        union()
        {
            for(r=[0,90,180,270])
            rotate([0,0,r])    
            {
                translate([10-1.8/2,10-1.8/2,0])
                    cylinder(h=h,d=1.8);
                translate([10-1.8,-10+1.8/2,0])
                    cube([1.8,20-1.8,h]);
            }

            for(r=[0,90])
            rotate([0,0,45+r])    
            translate([-(sqrt(20*20+20*20)-1.8)/2,-1.8/2,0])
                cube([sqrt(20*20+20*20)-1.8,1.8,h]);

            translate([-3,-3,0])
                cube([6,6,h]);
        }
        translate([0,0,-1])
            cylinder(h=h+2,d=4.2);
        

        for(r=[0,90,180,270])
        rotate([0,0,r])    
        translate([0,10-1.8-5.58/2,0])
        rotate([0,0,45])    
        translate([0,0,-1])
            cube([10,10,h+2]);
        
    }
}

module tslot(h,a=1)
{
    color(aluminum,a)
    difference()
    {
        cube([40,40,h],center=true);
        
        for(a=[0,90,180,270])
        rotate([0,0,a])
        translate([0,20,0])
            cube([11,20,h+2],center=true);
    }
}

tslot(5);