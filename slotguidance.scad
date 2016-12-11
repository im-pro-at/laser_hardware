difference()
{
    cube([21,18,5]);
    
    translate([-1,(18-11)/2,5-2])
        cube([21+2,11,2+1]);
    
    translate([21/2,18/2,-1])
        cylinder(h=5+2,d=6);
}