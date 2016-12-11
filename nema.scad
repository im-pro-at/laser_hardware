include <config.scad>;

module narrow_pulley(bore_diameter, outside_diameter, width,
           flange_diameter, flange_width,
           hub_diameter, hub_width) {
  color(aluminum)
  difference() {
    union() {
      cylinder(r=outside_diameter/2, h=width+2*flange_width,
           center=true);
      // Flanges
      translate([0, 0, (width+flange_width)/2])
        cylinder(r=flange_diameter/2, h=flange_width, center=true);
      translate([0, 0, -(width+flange_width)/2])
        cylinder(r=flange_diameter/2, h=flange_width, center=true);
      translate([0, 0, 0.75*flange_width-hub_width/2])
        cylinder(r=hub_diameter/2,
             h=hub_width-width-1.5*flange_width,
             center=true);
    }
    // Bore
    cylinder(r=bore_diameter/2, h=2*hub_width, center=true);
  }
}

module nema17(screw_l=5,screws=[true,true,true,true]) {
  color([0.4, 0.4, 0.4]) 
  {
  translate([0, -nema17_l/2, 0])
  intersection() {
      cube([nema17_od, nema17_l, nema17_od], center=true);
      rotate([0, 45, 0]) cube([nema17_od*sqrt(2)-5, nema17_l, nema17_od*sqrt(2)-5], center=true);
  }
  translate([0, 2, 0]) rotate([90, 0, 0])
      cylinder(r=nema17_id/2, h=2+1);
  }
  color(steel)
  translate([0, -nema17_l/2+10, 0]) rotate([90, 0, 0])
    cylinder(r=2.5, h=nema17_l+21, center=true);
  translate([0,screw_l+4,0])
  for (a = [0, 90, 180, 270]) 
  	if(screws[a/90])
	rotate([0, a, 0]) {
    color([0.2, 0.2, 0.2]) translate([nema17_screw_d/2, 0, nema17_screw_d/2])
      rotate([90, 0, 0]) {
      translate([0, 0, 0]) cylinder(r=2.5, h=4);
      translate([0, 0, 0]) cylinder(r=1.5, h=screw_l+10);
    }
    color(steel) translate([nema17_screw_d/2, -3.5, nema17_screw_d/2])
      rotate([90, 0, 0]) cylinder(r=5, h=0.5);
  }
}

module nema17smale(screw_l=3,screws=[true,true,true,true]) {
  color([0.4, 0.4, 0.4]) 
  {
      translate([0, -40/2, 0])
      intersection() 
      {
          cube([nema17_od, 40, nema17_od], center=true);

          rotate([0, 45, 0]) 
            cube([nema17_od*sqrt(2)-5, 40, nema17_od*sqrt(2)-5], center=true);
      }
      translate([0, 2, 0]) rotate([90, 0, 0])
          cylinder(r=nema17_id/2, h=2+1);
  }

  color(steel)
  translate([0, -40/2-9+21.5, 0]) rotate([90, 0, 0])
    cylinder(r=2.5, h=40+21, center=true);

  translate([0,screw_l+4,0])
  for (a = [0, 90, 180, 270]) 
  	if(screws[a/90])
	rotate([0, a, 0]) {
    color([0.2, 0.2, 0.2]) translate([nema17_screw_d/2, 0, nema17_screw_d/2])
      rotate([90, 0, 0]) {
      translate([0, 0, 0]) cylinder(r=2.5, h=4);
      translate([0, 0, 0]) cylinder(r=1.5, h=screw_l+10);
    }
    color(steel) translate([nema17_screw_d/2, -3.5, nema17_screw_d/2])
      rotate([90, 0, 0]) cylinder(r=5, h=0.5);
  }
}

module nema23(has_back, is_cylinder){
  mplate = 56.9; //mounting plate width
  mplateH = 5; //mounting plate height

  ringR = 38.10 / 2; //ring radius
  ringH = 1.5; //ring thickness

  shaftR = 6.337/2; //shaft radius
  shaftH = 19;  //shaft lenght

  bodyL = 56.1; //46.5, 56.1, 77.7, 103.1, ...
  bodyInnerCube = 37.6;

  holeR = 5.21/2;
  holeL = 47.14/2; //distance between hole centres

  translate([0,0,-mplateH/2])
  difference(){
    union(){
      //mounting plate
      color([0.7,0.7,0.7]) cube(size = [mplate,mplate,mplateH], center = true);
      //ring
      color([0.7,0.7,0.7]) translate(v=[0,0,mplateH/2+ringH/2]) cylinder(r=ringR, h=ringH, center=true);
      //shaft front
      color([0.9,0.9,0.9]) translate(v=[0,0,mplateH/2+ringH+shaftH/2])cylinder(r=shaftR, h=shaftH, center=true);
      if (has_back == 1){
        color([0.9,0.9,0.9])  translate(v=[0,0,0-bodyL-shaftH/2]) cylinder(r=shaftR, h=shaftH, center=true);
      }
      //body
      if (is_cylinder == 1){
        color([0.1,0.1,0.1]) translate(v=[0,0,0-mplateH/2-bodyL/2]) cylinder(r=mplate/2, h=bodyL, center=true);
      }else{
        union(){
          color([0.1,0.1,0.1]) translate(v=[0,0,0-mplateH/2-bodyL/2]) cube(size = [bodyInnerCube, mplate, bodyL], center=true);
          color([0.1,0.1,0.1]) translate(v=[0,0,0-mplateH/2-bodyL/2]) cube(size = [mplate,bodyInnerCube, bodyL], center=true);
        }
      }
    }
    translate(v=[holeL,holeL,0]) cylinder(r = holeR, h = 2*mplateH, center=true);
    translate(v=[-holeL,holeL,0]) cylinder(r = holeR, h = 2*mplateH, center=true);
    translate(v=[-holeL,-holeL,0]) cylinder(r = holeR, h = 2*mplateH, center=true);
    translate(v=[holeL,-holeL,0]) cylinder(r = holeR, h = 2*mplateH, center=true);
  }
  
}

nema23();


