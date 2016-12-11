include <config.scad>;
use <corner.scad>;
use <roller.scad>;
use <slot.scad>;
use <spacer.scad>;
use <nema.scad>;
use <beltclamp.scad>;

d_roller=(31.9+31)/2;


//Roller + corner
module rpvyz(debug=false,print=false)
rotate([0,print?-90:0,0])
{
    union()
    {
        x= d_roller+3+play+2*5+8;
        y= d_roller+22;
        difference()
        {
            union()
            {
                for(dy=[-1,1])
                translate([0,dy*y/2,0])
                translate([0,0,-57/2-7])
                    cube([x,3,57],center=true);
                for(h=[-61,-34,-7])
                translate([0,0,h])
                translate([0,0,-3/2])
                    cube([x,y,3],center=true);

                for(p=[[0,4.5,2.5],[90,2.6,4.4]])
                rotate([0,0,p[0]])
                for(dx=[1,-1])
                for(dy=[1,-1])
                if(p[0]==0 || dy==1)
                translate([0,y/2,-57/2-7])
                translate([dx*d_roller/2,4,dy*28]) //21.5
                rotate([90,0,0])
                translate([0,0,p[2]])
                    cylinder(h=p[1],d=8);
            }
            
            for(h=[-61,-34,-7])
            translate([0,0,h])
            {
                for(dx=[1,-1])
                for(dy=[1,-1])
                translate([dx*d_roller/2,dy*d_roller/2,-5]){
                    if(h==-7 && dx==-1 && dy==1)
                    {
                        cylinder(h=7,d=6+play);
                    }
                    else if(h==-7 && dx==-1 && dy==-1)
                    {
                        translate([0.5,0,0])
                            cylinder(h=7,d=5+play);                        
                    }
                    else if((h!=-7 && dy==1) || (h==-7 && dy==1))
                    {
                        for(dd=[-1,1])
                        translate([0,dd*0.5,0])
                            cylinder(h=7,d=5+play);                        
                    }
                    else
                    {
                        cylinder(h=7,d=5+play);                        
                    }
                }
                if(h==-61)
                for(d=[1,-1])
                translate([0,d*32/2,-5])
                    cylinder(h=7,d=3+play);
            }

            translate([0,0,-61+3])
            for(d=[1,-1])
            translate([0,d*53/2,0])
            rotate([90,0,0])
            translate([0,0,-7/2])
                cylinder(h=7,d=5+play);


            for(r=[0,90])
            rotate([0,0,r])
            for(dx=[1,-1])
            for(dz=[1,-1])
            if(r==0 || dz==1)
            translate([0,y/2,0])
            translate([0,0,-57/2-7])
            translate([dx*d_roller/2,4,dz*28.5]) //21.5
            rotate([90,0,0])
            {
                translate([0,0,0])
                    cylinder(h=15,d=3+play);    
                   
                translate([-(M3_nut_w+play)/2,-5.5,7.1])
                    cube([M3_nut_w+play,10,M3_nut_h+play]);
                
                if(r==90)  
                {  
                    translate([-5/2,-(M3_nut_w+play)/2,7])
                        cube([5+play,M3_nut_w+play,8]);
                        
                    translate([0,0,10])
                    rotate([90,0,0])
                    translate([0,0,-5])
                        cylinder(h=10,d=M3_nut_w+play);    
                }
            }


        }
                
        //Motor Mound
        difference()
        {
            translate([-x/2,-y/2,-7])
            {
                rotate([180,0,0])
                {
                    difference()
                    {
                        cube([x+nema17_screw_d/2-2,nema17_screw_d+13,5]);
                        translate([42,11.5,-1])
                        rotate([0,0,0])
                            cube([40,40,5+2]);
                        translate([30.5+3,22,-1])
                        rotate([0,0,0])
                            cube([40,40,5+2]);
                    }
                    difference()
                    {
                        cube([3,nema17_screw_d+13,30]);
                        
                        translate([-1,-20,39])
                        rotate([-28,0,0])
                            cube([5,100,30]);

                    }
                }
            }
            
            delta=3;
            for(d=[-1,0,+1])
            translate([(d+1)/2*delta,0,0])
            translate([15.5,-49.5,-7-4-2])
            {
                if(d==0)
                {
                    translate([0,0,3])
                        cube([delta,nema17_id,8],center=true);	
                }
                else
                {
                    cylinder(h=8,r=nema17_id/2);	
                }
                for(i=[-nema17_screw_d/2,nema17_screw_d/2])
                for(j=[-nema17_screw_d/2,nema17_screw_d/2])
                translate([i,j,0])
                if(d==0)
                {
                    translate([0,0,3])
                        cube([delta,3+play,8],center=true);	
                }
                else
                {
                    cylinder(h=8,r=(3+play)/2);	
                }
            }        
        }
    }
    
    if(debug)
    for(h=[-49,-20-2,-20-2+10+2+3+2+10+1])
    for(d1=[1,-1])
    for(d2=[1,-1])
    translate([d1*d_roller/2,d2*d_roller/2,h])
    {
        for(d=[1,-1])
        if(d!=1 || h!=-20-2+10+2+3+2+10)
        translate([0,0,d*(8.8/2+(20+4-8.8)/4)])
            spacer(7,5+play,(20+4-8.8)/2);
        vroller();
    }
    if(debug)
    rotate([90,0,0])
    {        
            translate([0,-22,0])
            rotate([0,90,0])
                vslot(100);

            translate([0,-49,0])
            rotate([0,90,0])
                vslot(100);

            translate([0,3+2+1,20])
            rotate([0,0,0])
                vslot(100);
            
            //motor
            translate([15.5,-10,49.5])
                nema17smale();

    }        
}

rpvyz(false,true);
