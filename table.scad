include <config.scad>;
use <slot.scad>;
use <corner.scad>;
use <roller.scad>;
use <rpvxy.scad>;
use <rpvyz.scad>;
use <nema.scad>;
use <nemaholder.scad>;
use <zgear.scad>;
use <beltclamp.scad>;
use <megamound.scad>;
use <spacer.scad>;

//       b
//  ------------
//       *
// l     *
//       *
//  ------------

woodd=12;

d_roller=(31.9+31)/2;

sliderw=40;
workl=500-100-2*woodd;
workb=400-60-2*woodd+65; //To support A4
workh=50;

levels=4;

posl=workl/2;
posb=workb/2;

open=0;

module dcube(d,center=false){
    cube(d,center=center);
    echo("Cube: ",d);
}

//tslot bottom
for(d=[1,-1])
translate([0,d*(workb+40)/2,-20/2-20/2])
rotate([0,90,0])
    vslot(workl+sliderw+20+40);

//botten Corner
for(dx=[1,-1])
for(dy=[1,-1])
translate([dx*(workl+sliderw)/2,dy*(workb+40)/2,-10])
rotate([0,0,90])
    corner2();

//vslot top
for(d=[1,-1])
translate([d*(workl+sliderw)/2,0,0])
rotate([90,0,0])
    vslot(workb+20+40);


//X Motors
for(d=[[0,1,0,false],[180,-1,60,true]])
rotate([0,0,d[0]])
translate([-(workl+sliderw)/2,
            d[1]*(workb+20)/2+d[2],
            -10])
    nemaholder(d[3],true);

//X Bearings
for(d=[[0,-1,0,false],[180,+1,-30,true]])
rotate([0,0,d[0]])
translate([-(workl+sliderw)/2,
            d[1]*(workb+20)/2+d[2],
            -10])
{
    nemaholder_bearing(d[3],true);
}   


//XMove
translate([0,-(workb)/2+posb,20+2])
{
    //Roller + corner
    for(d=[1,-1])
    translate([d*(workl+sliderw)/2,0,0])
    {
        rpvxy(d==1);
        translate([0,0,-40-1])
        rotate([0,0,0])
            beltclamp(32);
    }
    
    //vslot querstange
    translate([0,0,0])
    rotate([0,90,0])
    {
        vslot(workl+sliderw+20+20+20-8);
        translate([0,27,0])
            vslot(workl+sliderw+20+20+20-8);
    }
    //Y Motor
    translate([(workl+sliderw)/2,26+27,17])
    rotate([180,0,0])
    {
        nema23(3,[true,false,true,false]);
        translate([0,0,12])
        rotate([180,0,0])
            narrow_pulley(5, 18, 8, 22, 1.8, 12, 18);
    }   
    
    //Y Bearing
    translate([-(workl+sliderw)/2,26,16])
    rotate([-90,0,45])
    translate([0,12,0])
    rotate([90,0,0])
        narrow_pulley(5, 18, 8, 22, 1.8, 12, 12);
    
    //Ymode
    rotate([0,0,180])
    translate([-workl/2+posl,22,0])
    {
        translate([0,3+2,15+workh/2])
        rotate([0,0,0])
            vslot(80+workh);
        
        //Roller + corner
        rotate([-90,0,0])
            rpvyz();

        translate([0,-40-1-27,0])
        rotate([-90,90,0])
            beltclamp(32);

        rotate([-90,0,0])
        for(h=[-49,-20-2,-20-2+10+2+3+2+10])
        for(d1=[1,-1])
        for(d2=[1,-1])
        translate([d1*d_roller/2,d2*d_roller/2,h])
        {
            for(d=[1,-1])
            if(d!=1 || h!=-20-2+10+2+3+2+10)
            translate([0,0,d*(8.8/2+(20+4-8.8)/4)])
                spacer(7,3+play,(20+4-8.8)/2);
            vroller();
        }
                
        //Z Motor
        translate([15.5,-10,49.5])
        {
            nema17();
            translate([0,15,0])
            rotate([90,0,0])
                zgear();
        }
        translate([4.4,5,30])
        rotate([90,0,90])
            zgearline(100);
    }
    
}


//levels
translate([0,0,-19-workh])
{
    for(dl=[1,-1])
    color("SaddleBrown",0.3)
    translate([dl*(workl+100+woodd)/2-woodd/2,-(workb+60)/2,0])
        dcube([woodd,workb+60,+19+workh+100+workh-13]);
    
    color("SaddleBrown",0.3)
    translate([-(workl+100+2*woodd)/2,(workb+60+woodd)/2-woodd/2,0])
        dcube([workl+100+2*woodd,woodd,+19+workh+100+workh-13]);
    color("SaddleBrown",0.3)
    translate([-(workl+100+2*woodd)/2,-(workb+60+woodd)/2-woodd/2,0])
        dcube([workl+100+2*woodd,woodd,workh+9]);
}

translate([0,0,-19-workh+workh+9])
color("SaddleBrown",0.3)
translate([-(workl+100+2*woodd)/2,-(workb+60+woodd)/2-woodd/2,0])
rotate([140*open,0,0])
    dcube([workl+100+2*woodd,woodd,+19+workh+100+workh-13-(workh+9)]);


for(l=[2:levels])
translate([0,0,-19-l*workh])
{
    for(dl=[1,-1])
    color("SaddleBrown",0.3)
    translate([dl*(workl+100+woodd)/2-woodd/2,-(workb+60)/2,0])
        dcube([woodd,workb+60,workh]);
    
    for(db=[1,-1])
    color("SaddleBrown",0.3)
    translate([-(workl+100+2*woodd)/2,db*(workb+60+woodd)/2-woodd/2,0])
        dcube([workl+100+2*woodd,woodd,workh]);
}

translate([0,0,-19-levels*workh+-woodd])
color("SaddleBrown",0.3)
translate([0,0,woodd/2])
    dcube([workl+100+2*woodd,workb+60+2*woodd,woodd],center=true);

translate([0,0,workh+100])
color("SaddleBrown",0.3)
translate([0,0,-woodd/2])
translate([0,(workb+60+2*woodd)/2,0])
rotate([-50*open,0,0])
translate([0,-(workb+60+2*woodd)/2,0])
    dcube([workl+100+2*woodd,workb+60+2*woodd,woodd],center=true);














