

use <\lib\lib.scad>
$fn=60;
// Choose Part
part = "3"; // [1:Case Only,2:Cover Plate Only,3:Both]

// Width of the case
width = 145;

// Depth of the case
depth = 145;

// Height of the case
height = 50;

// Material thickness of the case and plates
material_thickness = 4;

// Corner radius of rounded corners
corner_radius = 5;

// Hole offset
hole_offset = 0; //[1:14]

// Hole diameter
hole_diameter = 3;

print_part();

module print_part() {
	if (part == "1") {
		base();
	} else if (part == "2") {
		plate();
	} else if (part == "3") {
		both();
	} else {
		both();
	}
}

module both(){
    

	base();
	translate([0,0,height])
		plate();
}






module base(){
	// All dimensions in mm
	x = width;
	y = depth;
	z = height;


difference() {
	union(){
		for (i=[ [hole_offset,hole_offset, 0],
				[hole_offset,y-hole_offset, 0],
				[x-hole_offset,hole_offset, 0],
				[x-hole_offset,y-hole_offset, 0] ])

		difference(){
			translate([x/2, y/2, height/2]){
			  roundedBox([x, y, height-0.01], 5, true);
			}
			translate([material_thickness, material_thickness, 0]) {
				linear_extrude(height=z)
				square(size = [x-(material_thickness*2), y-(material_thickness*2)], center = false);
		   	}
            //
               translate(v = [72.5, 20, 45])
               rotate([90, 0, 0])
            cylinder(h = 125, d =6);         
         }
	}
//Ausschnitt
translate(v = [-10, 4, 0])
cube(size = [160,160,50]);
    
    
    
}






}

module plate(){
	// All dimensions in mm
	x = width;
	y = depth;
	z = material_thickness;

	difference() {
		// create the base
		translate([x/2, y/2, z/2]){
		  roundedBox([x, y, z], corner_radius, true);
		}
		// Create 4 holes
		for (i = [ [hole_offset,hole_offset, -10],
			[hole_offset,y-hole_offset, -10],
			[x-hole_offset,hole_offset, -10],
			[x-hole_offset,y-hole_offset, -10] ])
		{
			translate(i) {
				linear_extrude(height = z + 10)
				circle(r=(hole_diameter/2));
			}
		}
            //Lüfterloch
            translate(v = [72.5, 73.5, -10])
            cylinder(h = 25, d =115);
	
    
    //Schraublöcher
translate(v = [10, 15, -10]) {
rotate([0, 0, 0])
cylinder(h = 20, d=3);
}

translate(v = [135, 15, -10]) {
rotate([0, 0, 0])
cylinder(h = 20, d=3);
}

translate(v = [10, 134, -10]) {
rotate([0, 0, 0])
cylinder(h = 20, d=3);
}
translate(v = [135, 134, -10]) {
rotate([0, 0, 0])
cylinder(h = 20, d=3);
}
}    



}



