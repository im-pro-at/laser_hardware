include <config.scad>;
use <corner.scad>;
use <roller.scad>;
use <slot.scad>;
use <spacer.scad>;
use <nema.scad>;
use <beltclamp.scad>;

d_roller=(31.9+31)/2;


module rpvxy_plate()
{
    difference()
    {
        union()
        {
            translate([0,+27/2,-34-3/2])
                cube([d_roller+20,60+27,3],center=true);
        }
        
        for(dx=[1,-1])
        for(dy=[1,-1])
        translate([dx*d_roller/2,dy*(60+27-20)/2+27/2,-34-4])
            cylinder(h=5,d=3+play);
        for(d=[1,-1])
        translate([d*32/2,+27/2,-34-4])
            cylinder(h=5,d=3+play);

        for(dx=[1,-1])
        for(dy=[1,-1])
        translate([dx*32/2,dy*27/2+27/2,-34-4])
            cylinder(h=5,d=6+play);
    }    
}

module rpvxy_joiner()
{
    difference()
    {
        union()
        {
            translate([0,+27/2,-10-3/2])
                cube([9,27+20,3],center=true);
            
            translate([0,27/2,-10-(20+4-8.8)/2])
                cylinder(h=(20+4-8.8)/2,d=7);
        }
        
        for(dy=[0,27])
        translate([0,dy,-10-4])
            cylinder(h=5,d=3+play);

        translate([0,+27/2,-10-10])
            cylinder(h=11,d=3+play);
    }    
}


//Roller + corner
module rpvxy(motor=true,debug=false,print=false)
rotate([0,print?(motor?1:-1)*90:0,0])
{
    if(print==false)
    for(d1=[1,-1])
    for(d2=[1,-1,0])
    translate([d1*d_roller/2,d2*(60+27-20)/2+27/2,-20-2])
    {
        if(d2==-1)
        translate([0,0,22])
        rotate([0,0,-90*d2+90])
            corner(h1=10,h2=10,
                d1=3+play,d2=3+play);
        
        for(d=[1,-1])
        if(d2!=0 || d!=1)
        translate([0,0,d*(8.8/2+(20+4-8.8)/4)])
            spacer(7,3+play,(20+4-8.8)/2);
        vroller();
    }
    
    //Motor/Bearing holder:
    difference()
    {
        union()
        {
            translate([-(d_roller+20)/2,10+27,-10])
                cube([d_roller+20,20,3]);
            translate([-(d_roller+20)/2,10+27,-10])
                cube([d_roller+20,3,20]);
            translate([(motor?1:-1)*(d_roller+20-3)/2,10+20/2+27,0])
                cube([3,20,20],center=true);
            translate([-(d_roller+20)/2,-10,10])
                cube([d_roller+20,75+(motor?20:-8),7]);
            for(d=[0,10])
            if(motor==false)
                translate([0,26+27,-10+1.5])
                    cylinder(h=20,r=6/2+play);	
        }
        
        //Nema Mount
        translate([0,26+27,0])
        {

            if(motor)
            translate([0,0,10])
            {
                translate([0,0,-1])
                cylinder(h=9,r=nema23_id/2);	
                translate([0,0,-20-1])  
                {
                    cylinder(h=5,r=13/2);	
                    rotate([0,0,90])
                    translate([0,-13/2,0])
                        cube([13/2+1,13,5]);
                }
                dd=nema23_screw_d/2;
                for(d=[[dd,dd],[-dd,-dd],[dd,-dd],[-dd,dd]])
                translate([d[0],d[1],0])
                {
                    translate([0,0,-1])
                        cylinder(h=8+2,r=5/2+play);
                    translate([0,0,-5+M5_nut_h])
                        cylinder(h=1+M5_nut_h,r=M5_nut_d/2,$fn=6);
                } 
            }        
            if(motor==false)
            {
                translate([0,0,-10-1])
                    cylinder(h=31,r=3/2+play);	
                translate([0,0,0])
                    cube([11,11,11],center=true);
            }
        }
        //roller mount
        for(d=[1,-1])
        translate([d*d_roller/2,20+27,-10-1])
            cylinder(h=5,r=(3+play)/2);
        
        
        //holder Mounts
        for(dx=[1,-1])
        for(dy=[0,27])
        translate([dx*d_roller/2,dy,10-1]){
            cylinder(h=9,r=(3+play)/2);
            translate([0,0,6])
                cylinder(h=3,r=8/2);
        }
        for(d=[1,-1])
        translate([d*d_roller/2,10-1+27,0])
        rotate([270,0,0])
            cylinder(h=5,r=(3+play)/2);
                
    }
    
    if(print==false)
        rpvxy_plate();
    
    if(print==false)
    for(x=[-d_roller/2,d_roller/2])
    translate([x,0,0])
        rpvxy_joiner();
    
    if(debug)
    {
        translate([(motor?-1:1)*23,0,0])
        rotate([0,90,0])
        {
            vslot(100);
            translate([0,27,0])
                vslot(100);
        }
        translate([0,0,-20-2])
        rotate([90,0,0])
            vslot(100);
        
        if(motor)
        translate([0,26+27,17])
        rotate([-180,0,0])
        {
            nema23(3,[true,false,true,false]);
            translate([0,0,12])
            rotate([180,0,0])
                narrow_pulley(5, 18, 8, 22, 1.8, 12, 18);
        }
        
    }
}


rpvxy(true,true,false);

*rotate([180,0,0])
rpvxy_joiner();

*rpvxy_plate();

*rpvxy(false,false,true);

