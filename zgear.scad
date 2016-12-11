include <config.scad>;
include <inc/rack_and_pinion.scad>;

module zgearline(l=100)
{
    x=11-2*play;
    z=1.6+2.6-play*2;
    difference()
    {
        translate([-x/2,0,0])
        {
            difference()
            {
                cube([x,l,z]);
                
                translate([(6-play*3)/2,5,0.4])
                    cube([6-play*3,l-10,z+1]);
            }
            translate([x/2,(l-10.2)/2+5.2,z-5.4+1.8])
            rotate([0,0,90])
            rotate([270,0,0])
            translate([0,0,-6/2])
                rack(5.2,(l-10.2)/5.2,6,0);
        }    
        for(d=[[45,0,2.6+play],[-45,x-2.6-play,0]])
        translate([-x/2+d[1],-1,d[2]])
        rotate([0,d[0],0])
        translate([-1,0,-2])
            cube([6,l+2,2]);
        
        //M3 hole
        dy=4;
        for(y=[dy,l-dy])
        translate([0,y,-1])
        {
            cylinder(h=7,r=(3+play)/2);
            rotate([0,0,90])
                cylinder(h=M2_nut_h+1,r=M3_nut_d/2,$fn=6);
        }
    }
}

module zgear(){
    difference()
    {
        translate([0,0,-5/2])
            pinion(5.2,11,5,0);
        difference()
        {
            cylinder(h=7,r=5/2-play,center=true);
            translate([0,2.5+1-0.5-play,0])
                cube([5,2,9],center=true);
        } 
    }
}


//zgearline();

zgear();

/*
translate([-20,1.9,0])
    %cube([40,4,6]);

translate([0,5.4,0])
    rack(5.2,20,6-play*2,0);

translate([0,-3-2.5,3])
rotate([0,0,90])
    zgear();

//*/


