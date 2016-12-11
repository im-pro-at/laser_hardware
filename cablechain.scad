include <config.scad>;

module cablechain(w=12,round=true)
{
    difference()
    {
        union()
        {
            //base with hole
            d=round?8:0;
            translate([d,-(w+4-2*play)/2,0])
                cube([16-d,w+4-2*play,2]);
            for(dy=[1,-1])
            translate([0,-1+dy*(w+4-2-2*play)/2,0])
            {
                if(round==false)
                    cube([16,2,8]);
                translate([16-8,-1/2-play/4+1+dy*(1-play/2)/2,0])
                    cube([8,1+play/2,16]);
                translate([16/2,2,8])
                rotate([90,0,0])
                    cylinder(h=2,r=16/2);
            }
            
            //middel part
            for(dy=[1,-1])
            difference()
            {
                union()
                {
                    translate([16-2,-4/2+dy*(w+8-3+2*play)/2,0])
                        cube([6,4,16]);
                }            
                translate([0,-4/2+dy*(w+4+4-2*play)/2,0])
                {
                    translate([-2*play,0,-1])
                        cube([16+4*play,4,9]);
                    translate([16/2,4,8])
                    rotate([90,0,0])
                        cylinder(h=4,r=16/2+2*play);
                }
                translate([18,-1+dy*(w+8-6+2*play)/2,0])
                {
                    translate([-2*play,0,-1])
                        cube([16+4*play,2,8+1]);
                    translate([16/2,2,8])
                    rotate([90,0,0])
                        cylinder(h=2,r=16/2+2*play);
                }
            }                

            //side with snap
            for(dy=[1,-1])
            translate([18,-1+dy*(w+8-2+2*play)/2,0])
            {
                if(round==false)
                    cube([16,2,8]);
                translate([0,0,0])
                    cube([8,2,16]);
                translate([16/2,2,8])
                rotate([90,0,0])
                    cylinder(h=2,r=16/2);
                
                translate([16/2,1,8])
                rotate([dy*90,90+dy*90,0])
                difference()
                {
                    cylinder(h=3,r=8/2-play);
                    translate([-4,-1.5,3])
                    rotate([-21,0,0]) 
                        cube([8-play,8-play,3]);                
                }
            }
            
        }
        
        
        translate([16/2,0,8])
        rotate([90,0,0])
            cylinder(h=w+4+2,r=8/2+play,center=true);
        
        translate([17,0,14])
        rotate([90,0,0])
            cylinder(h=w+12,r=3/2+play,center=true);
        
    }
    
}

translate([-18,0,0])
    %cablechain();
cablechain(12,true);
translate([18,0,0])
    %cablechain();

