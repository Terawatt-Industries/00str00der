use <MCAD/motors.scad>
use <MCAD/nuts_and_bolts.scad>

// Calculate parameters for pulley separation
function aVal(belt_len, bigP, smallP) = (belt_len / 2) - 0.7855 * (bigP + smallP);
function bVal(a, bigP, smallP) = a / (bigP - smallP);
function cVal(a, corr) = a / corr;

///// Calculate the correction factor
///// fit from tabulated data @ http://www.york-ind.com/print_cat/engineering.pdf
function corr(b) = 0.001937038323*pow(b,10) - 0.05808154202*pow(b,9) + 0.761293059*pow(b,8) - 5.736122913*pow(b,7) + 27.47727309*pow(b,6) - 87.33413058*pow(b,5) + 186.371874*pow(b,4) - 263.6175218*pow(b,3) + 236.7515116*pow(b,2) - 122.301777*pow(b,1) + 28.86267614;

module fillet(rad,height) {
	translate([-rad,-rad,0])
	difference() {
		translate([0,0,-height/2]) cube([rad-0.05,rad-0.05,height]);
cylinder(h=height+1,r=rad,center=true);
	}
}

module nutSlot(slot,tolerance,size=4) {
	union() {
		for (i=[0:0.5:slot]) {
			translate([i,0,0]) nutHole(size,tolerance=tolerance);
		}
	}
}

module large_pulley_w_hob() {
	difference() {
		union() {
			color("DarkGreen",1) translate([0,0,6]) cylinder(r=57.3/2,h=11.2);
			color("DarkGreen",1) translate([0,0,6]) cylinder(r=59/2,h=1);
			color("DarkGreen",1) translate([0,0,17.2]) cylinder(r=59/2,h=1);
			color("DarkGreen",1) translate([0,0,0]) cylinder(r=17.5/2,h=6.5);
		}
		cylinder(r=4,h=50,center=true);
	}
	color("Gray",1) translate([0,0,18]) rotate([0,180,0]) boltHole(8,length=60,tolerance=0.5);
}

module hotend_w_screws() {
	union() {
		translate([0,0,-35]) cylinder(r=5/16*25.4 + 0.25,h=35);
		translate([0,6+3/2-0.25,-4.76-3/2-0.75]) rotate([0,-90,0]) cylinder(r=3/2 + 0.3,h=50,center=true);
		translate([0,-6-3/2+0.25,-4.76-3/2-0.75]) rotate([0,-90,0]) cylinder(r=3/2 + 0.3,h=50,center=true);
	}
}

module stepper_w_pulley() {
	stepper_motor_mount(17);
	translate([0,0,5])
	union() {
		color("DarkGreen",1) translate([0,0,6]) cylinder(r=17/2,h=11.2);
		color("DarkGreen",1) translate([0,0,6]) cylinder(r=16.4/2,h=1);
		color("DarkGreen",1) translate([0,0,17.2]) cylinder(r=17/2,h=1);
		color("DarkGreen",1) translate([0,0,0]) cylinder(r=17.5/2,h=6.5);
	}
}

module stepper_w_pulley2() {
	translate([0,0,-13-6]) cube(42.3,center=true);
	translate([0,0,5])
	union() {
		color("DarkGreen",1) translate([0,0,6]) cylinder(r=28.5/2,h=50,center=true);
		color("DarkGreen",1) translate([31/2,31/2,0]) cylinder(r=3/2+0.05,h=50,center=true);
		color("DarkGreen",1) translate([-31/2,31/2,0]) cylinder(r=3/2+0.05,h=50,center=true);
		color("DarkGreen",1) translate([31/2,-31/2,0]) cylinder(r=3/2+0.05,h=50,center=true);
		color("DarkGreen",1) translate([-31/2,-31/2,0]) cylinder(r=3/2+0.05,h=50,center=true);
	}
}

module 608_bearing(tolerance=0.1) {
	difference() {
		union() {
			color("FireBrick",1) cylinder(r=22/2+tolerance,h=7,center=true);
			color("FireBrick",1) cylinder(r=13.5/2,h=9,center=true);
		}
		cylinder(r=8/2,h=9+0.1,center=true);
	}
}