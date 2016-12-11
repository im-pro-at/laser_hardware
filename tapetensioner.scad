include<config.scad>;
use<beltclamp.scad>;



module tapetensioner(nut=true,debug=false)
{
    difference()
    {
        cube([18,9,12],center=true);
        
        //M5 Mount
        translate([0,-1-9/2,0])
        rotate([-90,0,0])
        {
            cylinder(h=12+2,r=5/2+play);
            if(nut)
            rotate([0,0,90])
                cylinder(h=M5_nut_h+1,r=M5_nut_d/2,$fn=6);
        }
        
        //Beltclamp mount:
        for(d=[-1,1])
        translate([d*12/2,0,-12/2-1])
        {
            cylinder(h=12+2,r=3/2+play);
            rotate([0,0,90])
                cylinder(h=M3_nut_h+1,r=M3_nut_d/2,$fn=6);
        }
    }
    if(debug)
    {
        translate([0,0,3+12/2+0.75])
        rotate([180,0,0])
            beltclamp(12);
    }
}

/*
tapetensioner(false,true);

translate([0,-15,0])
    tapetensioner(true,true);

//rotate([0,180,0])
//    tapetensioner(false);

//beltclamp(12);
//*/


module tapetensioners_symetry(grip=false)
{
    difference()
    {
        translate([-24.4/2,-9/2,-4])
            cube([24.4,9,4]);
        
        //grip
        if(grip)
		translate(v = [0,0,-0.75])
		for ( i = [round(-9/2/2) : round(9/2/2)])
        translate(v = [0,2*i,0.75])
            cube(size = [6.5, 1.3, 0.75*2], center = true);
		
        //vertical mount:
        for(d=[-1,1])
        translate([d*10/2,0,-12/2-1])
        {
            cylinder(h=12+2,r=3/2+play);
            rotate([0,0,90])
            if(d==1)
                cylinder(h=M3_nut_h+1,r=M3_nut_d/2,$fn=6);
        }

        //Horizontal Mount
        for(dx=[1,-1])
        translate([dx*9,-1-9/2,0])
        rotate([-90,0,0])
        {
            cylinder(h=12+2,r=3/2+play);
            rotate([0,0,90])
            if(dx==(grip?1:-1))
                cylinder(h=M3_nut_h+1,r=M3_nut_d/2,$fn=6);
        }
        
    }
}

for(d=[0,1])
translate([d*26,0,0])
{
    tapetensioners_symetry(false);
    translate([0,12,0])
        tapetensioners_symetry(true);
}