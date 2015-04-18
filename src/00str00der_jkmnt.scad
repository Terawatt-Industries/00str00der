// 00str00der-jkmnt is a mounting plate to attach an 00str00der base
// to Jonas Kuehling's x-carriage (http://www.thingiverse.com/thing:18657)
// authors:  f. beachler
// license:  Creative Commons Commercial 3.0 share-alike w/attribution

use <MCAD/nuts_and_bolts.scad>
// For complete model with attached 00str00der and x-carriage uncomment these lines and enter the file-path below to the x-carriage you're using.
//use <00str00der.scad>
//use <../[path_to_xcarriage]/jonaskueling_x-carriage/jonaskuehling_x-carriage_lm8uu.scad>

$fn = 50;
plate_thickness = 4 + 3;
plate_width = 105;
plate_leadout = 65;
%translate([0, 0, 0]) simonkuehling_x_carriage();
%translate([15 + 5.75, -8 + 2, -1 * (plate_thickness + 32.2)]) rotate([0, 180, 90]) 00str00der_main();
color("FireBrick",1) mntplate_jk(plate_thickness, plate_width, plate_leadout, 4 + 0.7);

module mntplate_jk(t, w, l, m4d) {
	difference() {
		// base
		union() {
			difference() {
				minkowski() {
					difference() {
						translate([22, 0, -t / 2]) cube([w - 5, l - 5, t], center = true);
						// remove some material
						translate([50, -28, -t / 2]) cube([w / 2, l / 4, t + 0.02], center = true);
						translate([50, 28, -t / 2]) cube([w / 2, l / 4, t + 0.02], center = true);
					}
					cylinder(r=5 / 2, h = 0.01, center=true);
				}
				// hotend cavity
				minkowski() {
					union() {
						cylinder(r=40 / 2 - 4, h = 12.5 + t, center=true);
						// cavity ears
						translate([-17, -11, -t / 2])
							cylinder(r=10 / 2 - 1, h = 12.5 + t, center=true);
						translate([-17, 11, -t / 2])
							cylinder(r=10 / 2 - 1, h = 12.5 + t, center=true);
					}
					rotate([0, 90, 0]) cylinder(r=3, h = 0.01, center=true);
				}
			}
			// strain relief tabs
			translate([20, 0, -t / 2]) cube([5, l, t], center = true);
			for (y = [22 + 5, -22 - 5]) {
				translate([-27, y, -t / 2]) {
					mnt_strainrelief(t, m4d);
				}
				translate([18, y + (y > 0 ? 1 : -1), -t / 2]) {
					mnt_strainrelief(t, m4d);
				}
			}
		}
		// carriage mnt holes
		mntholes_jk(t, m4d);
		// extruder mnt holes
		translate([15 + 5.75, -8 + 2, -t - 10]) rotate([0, 180, 90]) mntholes_00str00der(t, m4d);
		// strain relief holes
		for (y = [22 + 5, -22 - 3]) {
			translate([-27, y, -t / 2]) {
				mnt_strainrelief_holes(t, m4d);
			}
			translate([18, y + (y > 0 ? 3 : -3), -t / 2]) {
				mnt_strainrelief_holes(t, m4d);
			}
		}
	}
}

module mntholes_00str00der(t, m4d) {
		for (x = [1, -13]) {
			translate([x, -4.5, -t * 2 - 0.01]) rotate([0,180,0]) cylinder(r = 2.2, h = t + 5,center=true);
			// countersink holes
			translate([x, -4.5, -t * 2 - 0.01 - 2]) rotate([0,180,0]) cylinder(r = 3.9, h = t,center=true);
		}
		for (x = [-8]) {
			translate([x, -43, -t * 2 - 0.01]) rotate([0,180,0]) cylinder(r = 2.2, h = t + 5,center=true);
			// countersink holes
			translate([x, -43, -t * 2 - 0.01 - 3]) nutHole(4, "mm", 0.25);
		}
}

module mntholes_jk(t, m4d) {
		for (i = [0 : 1]) {
			rotate(180*i)
				for (hole = [-1 : 1]) {
					rotate(hole*22)
						translate([0, 25, -t - 0.01])
							cylinder(r = m4d / 2, h = t + 0.1);
				}
		}
}

module mnt_strainrelief(t, m4d) {
	cylinder(r=15 / 2 + 1, h = t, center=true);
}

module mnt_strainrelief_holes(t, m4d) {
	translate([1, -1, 0.01]) {
		rotate([0,180,0]) cylinder(r = 2.2, h = t + 5, center=true);
		// countersink holes
		translate([0, 0, 2]) cylinder(r = 3.9, h = t,center=true);
	}
}