include <config.scad>;

module spacer(od,id,h)
{
    difference()
    {
        cylinder(h=h,d=od,center=true);
        cylinder(h=h+2,d=id,center=true);
    }
}


spacer(7,5+2*play,(20+4-8.8)/2); 
translate([0,0,-0.8/2])
    spacer(10,5+2*play,(20+4-8.8)/2-0.8); 
