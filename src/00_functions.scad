// 00str00der v2 by Free Beachler
// Apache 2 License

use <MCAD/motors.scad>
use <MCAD/nuts_and_bolts.scad>

// Calculate parameters for pulley separation
function aVal(belt_len, hobP, driveP) = (belt_len / 2) - 0.7855 * (hobP + driveP);
function bVal(a, hobP, driveP) = hobP > driveP ? a / (hobP - driveP) : a / (hobP + driveP);
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

module nutSlot(slot, tolerance, size = 4) {
	union() {
		for (i=[0:0.5:slot]) {
			translate([i,0,0]) nutHole(size,tolerance=tolerance);
		}
	}
}

module slot(radius, length, depth) {
	translate([0, -length / 2, 0]) rotate([0, 90, 0]) cylinder(r = radius, h = depth * 2, center = true);
	translate([0, 0, 0]) cube([depth * 2, length, radius * 2], center = true);
	translate([0, length / 2, 0]) rotate([0, 90, 0]) cylinder(r = radius, h = depth * 2, center = true);

}

module pulley(pulley_dia, flange_dia = 3, bore_dia = 8) {
	difference() {
		union() {
			color("Green",1) translate([0,0,6]) cylinder(r = pulley_dia / 2, h=11.2);
			color("Green",1) translate([0,0,6]) cylinder(r = pulley_dia / 2 + flange_dia / 2, h=1);
			color("Green",1) translate([0,0,17.2]) cylinder(r = pulley_dia / 2 + flange_dia / 2, h=1);
			color("DarkGreen",1) translate([0,0,0]) cylinder(r = 17.5/2, h=6.5);
		}
		cylinder(r = bore_dia / 2, h=50, center=true);
	}
}

module terawatt_knurled_bolt(len, dia, thread_len, knurl_pos, knurl_width) {
	union() {
		difference() {
			color("Gray",1) translate([0, 0, 0]) rotate([0,180,0]) boltHole(dia - 0.1, length = len - 1, tolerance = 0.5);
			translate([0, 0, -knurl_pos]) rotate([0,180,0]) cylinder(r = dia / 2 + 1, h = knurl_width, center = true);
		}
		color("Black",1) translate([0, 0, -len + thread_len / 2]) rotate([0,180,0]) cylinder(r = dia / 2, h = thread_len, center = true);
		color("Silver",1) translate([0, 0, -knurl_pos]) rotate([0,180,0]) cylinder(r = dia / 2 - 0.1, h = knurl_width, center = true);
	}
}

module hotend_w_screws() {
	union() {
		color("Black", 1) translate([0, 0, -35]) cylinder(r=5/16 * 25.4 + 0.25,h=35);
		// mnt screws
		color("Gray", 1) translate([0, 6 + 3/2 - 0.25, -4.76 - 3/2 - 0.75]) rotate([0,-90,0]) cylinder(r = 3/2 + 0.3, h = 50, center = true);
		color("Gray", 1) translate([0, -6 - 3/2 + 0.25, -4.76 - 3/2 - 0.75]) rotate([0, -90, 0]) cylinder(r = 3/2 + 0.3, h = 50, center = true);
	} 
}

module roller_bearing(id = 8, od = 22, height = 16, flange_dia = 13.5, tol = 0.1) {
	difference() {
		union() {
			color("FireBrick",1) cylinder(r = od / 2 + tol, h = height / 2 - 1, center=true);
			color("FireBrick",1) cylinder(r = flange_dia / 2 + tol, h = height / 2 + 2, center=true);
		}
		cylinder(r = id / 2, h = height * 2 + tol, center=true);
	}
}

module sleeve_bearing(id = 8.03, od = 15.9, height = 10.8, flange_dia = 17.4, tol = 0.1) {
	difference() {
		union() {
			translate([0, 0, (height + 1) / 2 - tol]) color("Purple",1) cylinder(r1 = od / 2 + tol, r2 = od / 2 - (od * sin(5 / 2)) + tol, h = height, center=true);
			color("Brown",1) cylinder(r = flange_dia / 2 + tol, h = 1, center=true);
		}
		cylinder(r = id / 2, h = height * 3 + tol, center=true);
	}
}

module stepper_w_pulley(pulley_dia) {
	stepper_motor_mount(17);
	translate([0, 0, 5]) pulley(pulley_dia, 3, 5);
}

module pulleys_and_bearings(hobP, driveP, CVal, hpoff, hob_dia, bsleeve, bid, bod, bht, bfdia, sep) {
	assign(offCVal = cos(asin(hpoff / CVal)) * CVal) {
	translate([bht * 1.5 + 3.5, 0, hpoff]) rotate([0, 90, 0]) pulley(hobP);
	if (bsleeve) {
		translate([sep, 0, hpoff]) rotate([0, 90, 180]) sleeve_bearing(bid, bod, bht, bfdia);
		translate([-sep, 0, hpoff]) rotate([0, 90, 0]) sleeve_bearing(bid, bod, bht, bfdia);
	} else {
		translate([sep, 0, hpoff]) rotate([0, 90, 0]) roller_bearing(bid, bod, bht, bfdia);
		translate([-sep, 0, hpoff]) rotate([0, 90, 0]) roller_bearing(bid, bod, bht, bfdia);
	}
	translate([bht + 5, -offCVal, 0]) rotate([0, 90, 0]) stepper_w_pulley(driveP); 
	}
}

module filament(fd = 3.3) {
	color("Blue",1) cylinder(r=fd / 2, h=100, center=true);
}

