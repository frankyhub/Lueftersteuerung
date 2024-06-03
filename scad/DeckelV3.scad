//               Box und Deckel 28.07.2021 khf

//************************   Auswahl   *****************************
//                   1:Grundkörper  2:Deckel 

                           part = "2";

//******************************************************************


//************************   Parmeter   *****************************
x = 145;  //Breite
y = 120;  //Länge
z = 30;  //Höhe
d = 3;   //Wand-Dicke
b = 3;   //Durchmesser Bohrung
//******************************************************************

$fn=60;
include <ma_lib/constants.scad>
use <ma_lib/shapes.scad>

print_part();

module print_part() 
 {
	if (part == "1") {
		Box();
	} 
    else if (part == "2") {
		Deckel();
	} 
}

//------- Box  -------------
module Box()
{
color("Gainsboro")
difference() {
cuboid([x,y,z], fillet=b);

translate([0, 0, d])
cuboid([x-d,y-d,z+1], fillet=b);

translate([-y-y/2, -x-x/2, z/2-d])
cube(size = [x+300,y+300,d]);    
}
//Schraublöcher-----------
color("Ivory")
union() {
difference() {
translate([x/2-b-1, y/2-b-1, -z/2+d])
cylinder(h = z-(d*2), d=b+2);
translate([x/2-b-1, y/2-b-1, -z/2+d])
cylinder(h = z-(d+2), d=b);
}

difference() {
translate([-x/2+b+1, y/2-b-1, -z/2+d])
cylinder(h = z-(d*2), d=b+2);
translate([-x/2+b+1, y/2-b-1, -z/2+d])    
cylinder(h = z-(d+2), d=b);    
}

difference() {
translate([-x/2+b+1, -y/2+b+1, -z/2+d])
cylinder(h = z-(d*2), d=b+2);
translate([-x/2+b+1, -y/2+b+1, -z/2+d])
cylinder(h = z-(d+2), d=b);
}


difference() {
translate([x/2-b-1, -y/2+b+1, -z/2+d])
cylinder(h = z-(d*2), d=b+2);
translate([x/2-b-1, -y/2+b+1, -z/2+d])
cylinder(h = z-(d+2), d=b);    
}
}
} 

//------- Deckel-------------
module Deckel(){
color("Silver")
difference() {

cuboid([x,y,z-27], fillet=1, center=true);
    
translate([x/2-b-1, y/2-b-1, -3])
cylinder(h = d+d, d=b);
    
translate([-x/2+b+1, y/2-b-1, -3])
cylinder(h = d+d, d=b);    

translate([-x/2+b+1, -y/2+b+1, -3])
cylinder(h = d+d, d=b);

translate([x/2-b-1, -y/2+b+1, -3])
cylinder(h = d+d, d=b);    
}
}
//------------------------










