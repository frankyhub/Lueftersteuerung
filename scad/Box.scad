//               Box und Deckel 29.07.2021 khf

//************************   Auswahl   *****************************
//                   1:Grundkörper  2:Deckel 

                           part = "1";

//******************************************************************


//************************   Parmeter   *****************************
x = 145;  //Breite
y = 120;  //Länge
z = 50;  //Höhe
d1 = 4;   //Wand-Dicke mind. 3mm
b1 = 3;   //Durchmesser Bohrung mind. 3mm
//******************************************************************


a=3;
d= d1<a ? 3 : d1;

c=3;
b= b1<c ? 3 : b1;

difference() {
print_part();

//Frontloch
translate(v = [55, 0, 0]) {
rotate([0, 90, 0])
cylinder(h = 20, d=6);
}


//Kabeldurchführung
translate(v = [0, 70, -15]) {
 rotate([90, 0, 0])   
cylinder(h = 20, d=6);
}


/*

//Schraublöcher
translate(v = [-55, -45, -35]) {
rotate([0, 0, 0])
cylinder(h = 20, d=3);
}

translate(v = [55, -45, -35]) {
rotate([0, 0, 0])
cylinder(h = 20, d=3);
}

translate(v = [55, 45, -35]) {
rotate([0, 0, 0])
cylinder(h = 20, d=3);
}
translate(v = [-55, 45, -35]) {
rotate([0, 0, 0])
cylinder(h = 20, d=3);
}

*/
}









module print_part() 
 {
	if (part == "1") {
		Box();
	} 
    else if (part == "2") {
		Deckel();
	} 
}

include <box/box_lib.scad>;



