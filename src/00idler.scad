// 00str00der v2 by Free Beachler
// Apache 2 License

use <MCAD/nuts_and_bolts.scad>
include <00_config.scad>
use <00_functions.scad>
use <idler_roller.scad>

$fn=50;

translate([-idler_leadout / 2 - idler_leadout / 8, 0, idler_roller_z_offset * -1]) roller_and_bolt();

00idler();

module 00idler(width = idler_width, leadout = idler_leadout, height = idler_height, rzo = idler_roller_z_offset, rxo = idler_roller_leadout_offset, ibd = idler_bolt_dia, ibl = idler_bolt_len, ird = idler_roller_dia, irt = idler_roller_thickness, ibo = idler_bearing_od, iwd = idler_washer_dia, iwt = idler_washer_thickness, o = o) {
	translate([-leadout / 2 - leadout / 8, 0, -rzo * 2]) {
		00idler_base();
		translate([leadout * 0.75 - o, 0, 0]) 00idler_fulcrum_base();
	}
}

module 00idler_base(width = idler_width, leadout = idler_leadout, height = idler_height, rzo = idler_roller_z_offset, rxo = idler_roller_leadout_offset, ibd = idler_bolt_dia, ibl = idler_bolt_len, ird = idler_roller_dia, irt = idler_roller_thickness, ibo = idler_bearing_od, iwd = idler_washer_dia, iwt = idler_washer_thickness, o = o) {
	difference() {
		minkowski() {
		union() {
			hull() {
			translate([-5 / 2, 0, 0]) cube([leadout + 5 * 2, width - 2 * 2, height], center = true);
			// support for washers on idler bolt
			for (i = [-1, 1]) {
			translate([rxo, ibl / 2 * i - 7.5 * i - (2 * i), rzo - 5]) rotate([0, 90, 90]) {
				difference() {
					cylinder(r = 6 * 2, h = 5, center = true);
					translate([8 + o, 0, 0]) cube([16, 24, 5 + 1], center = true);
				}
			}
			}
			} 	// hull
			}	// union
			rotate([0, 0, 0]) cylinder(r = 2, h = 0.001, center = true);
		}	//mink
		// subtract roller and bolt
		// subtract bolt
		translate([rxo, 0, rzo + ibd / 2 + height / 2]) rotate([90, 0, 0]) cube([ibd, ibd + height, 50], center = true);
		translate([rxo, 0, rzo]) rotate([90, 0, 0]) cylinder(r = ibd / 2 + 0.1, h = width * 2, center = true);
		// slightly rotate for captive nuts
//		translate([rxo, 0, rzo]) rotate([0, 90, 0]) roller_and_bolt();
		// finish roller extraneous
		translate([rxo, 0, rzo]) rotate([90, 90, 0]) scale([1, 1, 1.4]) cylinder(r = ibo / 2 + o * 2, h = irt, center = true);
		// finish captive nut slot
		translate([rxo, -iwt - 2.5, rzo + 4]) rotate([90, 90, 0]) scale([1, 1, 1.25]) nutHole(6);
		translate([rxo, iwt + 8.75, rzo + 4]) rotate([90, 90, 0]) scale([1, 1, 1.25]) nutHole(6);
		translate([rxo, -iwt - 2.5, rzo]) rotate([90, 90, 0]) scale([1, 1, 1.4]) cylinder(r = 11.5 / 2 + o, h = 9, center = true);
		translate([rxo, iwt + 2.5, rzo]) rotate([90, 90, 0]) scale([1, 1, 1.4])  cylinder(r = 11.5 / 2 + o, h = 9, center = true);
		// remove extraneous around roller bushing
		translate([rxo, -iwt - 0.9, rzo]) rotate([90, 0, 0]) cylinder(r = ibo / 2, h = iwt + 0.5, center = true);
		translate([rxo, iwt + 0.9, rzo]) rotate([90, 0, 0]) cylinder(r = ibo / 2, h = iwt + 0.5, center = true);
		translate([rxo, -iwt - 0.9, rzo + ibo / 2]) cube([ibo, iwt + 0.5, ibo], center = true);
		translate([rxo, iwt + 0.9, rzo + ibo / 2]) cube([ibo, iwt + 0.5, ibo], center = true);
		// roller freedom
		translate([rxo, 0, rzo]) rotate([90, 0, 0]) cylinder(r = ird / 2 + 2, h = irt + 0.2, center = true);
		// idler freedom
		translate([leadout / 2 + leadout / 16 + 2, 0, rzo + 2]) 00idler_fulcrum_arms();
		// idler tension screwholes
		for (y = [1, -1]) {
			translate([-leadout / 2 - 5 / 2, y * (width / 3 - width * 0.03), 0]) 00idler_tension_screwhole(width, height);
		}
	}	// difference
}

module 00idler_tension_screwhole(width = idler_width, height = idler_height, angle_range = 15) {
		for (m = [-1, 1]) {
			for (rot = [-angle_range, -angle_range * 2/3, -angle_range * 2 / 6, 0]) {
				translate([0, 0, 0]) rotate([0, m * rot, 0]) cylinder(r = (4 + 1) / 2, h = height * 3, center = true);
			}
		}
}

module 00idler_bolt(bd = idler_bolt_dia, len = idler_bolt_len, o = o) {
	color("Gray", 1) cylinder(r = bd / 2, h = len, center = true);
}

module roller_and_bolt(ibd = idler_bolt_dia, ibl = idler_bolt_len, ird = idler_roller_dia, irt = idler_roller_thickness, ibo = idler_bearing_od, iwd = idler_washer_dia, iwt = idler_washer_thickness, o = o) {
	rotate([90, 0, 0]) {
		terawatt_idler_roller(ibd, ird, irt, ibo, 1, iwd, iwt);
		00idler_bolt();
		for (i = [-1, 1]) {
			translate([0, 0, (((irt + iwt) / 2 - 2.5 * i) + 4) * i]) rotate([0, 0, 0]) nutHole(6);
		}
		for (i = [-1, 1]) {
			translate([0, 0, (((irt + iwt) / 2 - 2.5 * i) + 5) * i]) rotate([0, 0, 0]) nutHole(6);
		}
		for (i = [-1, 1]) {
			translate([0, 0, (((irt + iwt) / 2 - 2.5 * i) + ibl / 2.75) * i]) rotate([0, 0, 0]) nutHole(6);
		}
	}	// rotate
}

module 00idler_fulcrum_base(width = idler_width, leadout = idler_leadout, height = idler_height, rzo = idler_roller_z_offset, rxo = idler_roller_leadout_offset, ird = idler_roller_dia) {
	difference() {
		union() {
			hull() {
				translate([-4, 0, 0]) cube([leadout / 2 - 4, width / 2, height], center = true);
				translate([0, 0, rzo + 2]) rotate([90, 0, 0]) cylinder(r = (4 * 3) / 2, h = width / 2, center = true);
			}	// hull
		}	// union
	// mount screw hole
	translate([0, 0, rzo + 2]) rotate([90, 0, 0]) cylinder(r = 3 / 2 + 0.2, h = width, center = true);
	} // difference
}

module 00idler_fulcrum_arms(width = idler_width) {
	difference() {
		rotate([90, 0, 0]) cylinder(r = 10, h = width + 5, center = true);
		cube([20 + o, width / 2 + o, 20 + o], center = true);
	}
}

