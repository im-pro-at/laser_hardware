include <config.scad>;
use <slot.scad>;
use <nema.scad>;
use <rpvxy.scad>;


module nemaholder(mirror=false,debug=false)
{
    dside=mirror?-60:-3;
    difference()
    {
        union()
        {
            translate([10,-60,-65+20])
                cube([3+4,60,65]);

            translate([-10,dside,-45])
                cube([20+1,3,45]);
        }
        
        //nema 23:
        translate([10+3+4,-30,-16])
        rotate([0,-90,0])
        translate([0,0,-1])
        {
            h=3+4;
            cylinder(h=h+2,r=nema23_id/2);	
            dd=nema23_screw_d/2;
            for(d=[[dd,dd],[-dd,-dd],[dd,-dd],[-dd,dd]])
            translate([d[0],d[1],0])
            {
                cylinder(h=h+2,r=5/2+play);
                translate([0,0,h+1-M5_nut_h])
                    cylinder(h=M5_nut_h+5,r=M5_nut_d/2,$fn=6);
            } 
        }
        
        //mount holse
        translate([0,dside+4,-10])
        rotate([90,0,0])
            cylinder(h=3+2,r=3/2+play);
        for(d=[1,-1])
        translate([10-1,-30+d*15,10])
        rotate([0,90,0])
        {
            cylinder(h=4+3+2,r=3/2+play);
            translate([0,0,5])
                cylinder(h=3+1,r=8/2+play);
        }
    }


    if(debug)
    {
        translate([10+3+4,-30,-16])
        rotate([0,-90,0])
        {
            nema23();
            translate([0,0,17])
            narrow_pulley(5, 18, 8, 22, 1.8, 12, 18);
        }
    }
}


module nemaholder_bearing(mirror=false,debug=false)
{
    dside=mirror?30-3:0;
    difference()
    {
        union()
        {
            for(d=[1,-1])
            translate([-3/2+d*(10-3/2),0,-30])
                cube([3,30,30]);
            translate([-10,0,-3])
                cube([20,30,3]);
            translate([-10,dside,-30])
                cube([20,3,30]);
            for(d=[1,-1])
            translate([d*(10-3/2-1/2),15,-16])
            rotate([0,-90,0])
                cylinder(h=3+1,r=7/2+play,center=true);	
        }
        
        //bearing hole:
        for(d=[1,-1])
        translate([d*(10-3/2),15,-16])
        rotate([0,-90,0])
            cylinder(h=3+4,r=5/2+play,center=true);	
        //mount holse
        translate([0,4+dside,-10])
        rotate([90,0,0])
            cylinder(h=3+2,r=3/2+play);
        for(d=[1,-1])
        translate([0,15,-4])
        {
            cylinder(h=3+2,r=3/2+play);
        }

        
    }   
    
    
    if(debug)
    {
        translate([10+3+4,15,-16])
        rotate([0,-90,0])
        {
            translate([0,0,17])
            narrow_pulley(5, 18, 8, 22, 1, 10, 10);
        }
            
    }    
}

*translate()
{
    translate([0,100,0])
        nemaholder(false,true);

    translate([0,-100,0])
        nemaholder_bearing(false,true);

    translate([0,-20,32])
    {
        //Roller + corner
        rpvxy(false);

        //Tslots
        for(d=[1,-1])
        translate([130,d*110,-22-20])
        rotate([0,90,0])
            vslot(300,0.5);

        //vslots querstange
        translate([0,0,-22])
        rotate([90,0,0])
            vslot(240,0.5);
        translate([100,0,0])
        rotate([0,90,0])
            vslot(260,0.5);
    }
}

*rotate([0,90,0])
    nemaholder(true);

rotate([0,180,0])
    nemaholder_bearing(true);
