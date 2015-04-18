// 00str00der v2 by Free Beachler
// based on 00str00der v1 by Lee Miller and Free Beachler
// Apache 2 License

use <MCAD/motors.scad>
use <MCAD/nuts_and_bolts.scad>
include <00_config.scad>
use <00_functions.scad>
use <00idler.scad>
use <idler_roller.scad>
$fn=100;

00str00der();

module 00str00der(bowden = bowden, bw = base_width, bt = base_thickness, pfdia = pushfit_dia, pfht = pushfit_h, fildia = filament_dia, filslot = filament_slot, hobP = gt2_pulley_dias[60], driveP = gt2_pulley_dias[16], belt_len = belt_len, hpo = hob_pulley_offset, hob_dia = knurled_bolt_dia, hob_len = knurled_bolt_len, hob_thread_len = knurled_bolt_thread_len, hob_pos = knurled_bolt_knurl_pos, hob_width = knurled_bolt_hob_width, bslv = bearing_sleeve, bid = bearing_id, bod = bearing_od, bht = bearing_height, bfdia = bearing_flange_dia, iwd = idler_width, ilo = idler_leadout, iht = idler_height, rzo = idler_roller_z_offset, rxo = idler_roller_leadout_offset, ibd = idler_bolt_dia, ibl = idler_bolt_len, ird = idler_roller_dia, irt = idler_roller_thickness, ibo = idler_bearing_od, iwd = idler_washer_dia, iwt = idler_washer_thickness) {
   assign(AVal = aVal(belt_len, hobP, driveP)) {
	assign(BVal = bVal(AVal, hobP, driveP)) {
	assign(correction = corr(BVal)) {
	assign(CVal = cVal(AVal, correction)) {
	assign(filhole = fildia + (fildia * fildia)) {
		echo(hobP);
		echo(driveP);
		echo(filhole);
		echo(AVal);
		echo(BVal);
		echo(CVal);
		echo(correction);
		color("Red", 1) extruder(AVal, BVal, CVal, correction, bowden, bw, bt, pfdia, pfht, filhole, filslot, hobP, driveP, belt_len);
		// uncomment this to see pulleys and bearings
		//translate([0, 22.65, 20]) extruder_assembly_parts(AVal, BVal, CVal, correction);
	}}}}}	// assigns
}

module extruder(AVal, BVal, CVal, correction, bowden = bowden, bw = base_width, bt = base_thickness, th = tower_height, pushfit_dia = pushfit_dia, pushfit_h = pushfit_h, filament_dia = filament_dia, filament_slot = filament_slot, hobP = gt2_pulley_dias[60], driveP = gt2_pulley_dias[16], belt_len = belt_len, hpo = hob_pulley_offset, hob_dia = knurled_bolt_dia, hob_len = knurled_bolt_len, hob_thread_len = knurled_bolt_thread_len, hob_pos = knurled_bolt_knurl_pos, hob_width = knurled_bolt_hob_width, bslv = bearing_sleeve, bid = bearing_id, bod = bearing_od, bht = bearing_height, bfdia = bearing_flange_dia, iwd = idler_width, ilo = idler_leadout, iht = idler_height, rzo = idler_roller_z_offset, rxo = idler_roller_leadout_offset, ibd = idler_bolt_dia, ibl = idler_bolt_len, ird = idler_roller_dia, irt = idler_roller_thickness, ibo = idler_bearing_od, iwd = idler_washer_dia, iwt = idler_washer_thickness) {
	extruder_base(AVal, BVal, CVal, correction, belt_len / 2, bw, bt);
	// tower
	translate([0, -3, 0]) extruder_tower(AVal, BVal, CVal, correction);
}

module extruder_base(AVal, BVal, CVal, correction, leadout = belt_len, bw = base_width, bt = base_thickness, th = tower_height, pushfit_dia = pushfit_dia, pushfit_h = pushfit_h, filament_dia = filament_dia, filament_slot = filament_slot, hobP = gt2_pulley_dias[60], driveP = gt2_pulley_dias[16], belt_len = belt_len, hpo = hob_pulley_offset, hob_dia = knurled_bolt_dia, hob_len = knurled_bolt_len, hob_thread_len = knurled_bolt_thread_len, hob_pos = knurled_bolt_knurl_pos, hob_width = knurled_bolt_hob_width, bslv = bearing_sleeve, bid = bearing_id, bod = bearing_od, bht = bearing_height, bfdia = bearing_flange_dia, iwd = idler_width, ilo = idler_leadout, iht = idler_height, rzo = idler_roller_z_offset, rxo = idler_roller_leadout_offset, ibd = idler_bolt_dia, ibl = idler_bolt_len, ird = idler_roller_dia, irt = idler_roller_thickness, ibo = idler_bearing_od, iwd = idler_washer_dia, iwt = idler_washer_thickness) {
	difference() {
	union() {
	// base foot
	hull() {
	// base foot
	translate([-bw / 2, -leadout / 2 + 10 / 2, -bt]) cube([bw, leadout - 10, bt], center = false);
	// fulcrum arms
	translate([0, leadout / 2 - iht / 2, ilo / 8 + 2]) rotate([0, 0, 90]) 00idler_fulcrum_arms(bw + 2.5);
	} // hull
	// motor mount face
	translate([0, -leadout / 4 - 10, 0]) {
	hull() {
		translate([-bw / 2, 10, -bt]) cube([bw, leadout / 4, bt], center = false);
		translate([-bw / 2,  (-leadout / 2 - 10) / 2, -bt]) cube([bw, leadout / 2, bt], center = false);
		hull() {
			translate([bw / 2, 0, 0]) cube([bt, -leadout / 2, 5], center = false);
			// style the face
			hull() {
				for (i = [-1, 1]) {
					translate([bw / 2, 20 * i, 5]) rotate([0, 90, 0]) cylinder(r = 7.5, h = bt, center = false);
				}
			}	// hull
		} // hull
	}	// hull
	}
	// riser between tower and motor
	difference() {
		union() {
		translate([-bw / 2, -AVal / 3 / 2, 0]) cube([bw, AVal / 4, th * 0.5], center = false);
		translate([0, AVal / 6 / 2, th / 2 - th / 2 - th * 0.6]) {
			difference() {
				// support on top of riser
				translate([0, 0, th]) rotate([45, -45, 90]) cube([th / 3, th / 3, th / 3], center = true);
				translate([0, th / 2, th]) rotate([0, 0, 0]) cube([th, th, th], center = true);
			}	// difference
		}
		} // union
		// mount screw holes
		for (i = [-1, 1]) {
			translate([i * bw / 3.65, - 2, th / 2 - 1 - o]) rotate([180, 0, 0]) boltHole(4, "mm", th);
		}
	}	// difference
	}	// union
	// cutout motor
	translate([-50 + bw / 2 + o, -leadout, 42]) rotate([0, 90, 0]) cube([42, leadout - AVal / 6, 50]);
	// cutout motor slide freedom
	translate([bw / 2 - o, -CVal / 2 - 10 / 2 -  2, AVal / 2 - 10]) slot(7.5, 10, bw);
	// cutout motor mnt slots
	translate([bw / 2 - o, -CVal + 3, bt + 0.5]) slot(3 / 2 + 0.2, 6, bw);
	translate([bw / 2 - o, -CVal + 10 + 24, bt + 0.5]) slot(3 / 2 + 0.2, 6, bw);
	// filament hole
	translate([0, bearing_od * 3 / 2 + hob_dia / 2 + 0.45, 0]) cylinder(r = (filament_dia + filament_dia * 0.15) / 2 + o, h = th * 2, center = true);
	// fulcrum cutout
	translate([0, leadout / 2, ilo / 8]) rotate([0, 0, 90]) cube([leadout / 4, bw * 0.55, ilo], center = true);
	translate([0, leadout / 2, ilo / 8]) rotate([0, 90, 0]) cylinder(r = 14, h = bw * 0.55, center = true);
	// fulcrum mount hole
	translate([0, leadout / 2 - iht / 2, rzo + 3.5]) rotate([0, 90, 0]) cylinder(r = 3 / 2 + 0.2, h = bw * 2, center = true);
	// hotend
	translate([0, bearing_od * 3 / 2 + hob_dia / 2 + 0.55, 10 - bt]) hotend_w_screws();
	// mount screw holes
	for (i = [-1, 1]) {
		translate([i * bw / 3.65, - 2, th / 2 + 1 - o]) rotate([180, 0, 0]) boltHole(4, "mm", th);
	}
	translate([0, -leadout / 2 - 8, bt - 6 - o]) rotate([180, 0, 0]) boltHole(4, "mm", th);
	translate([0, -leadout / 2 - 8, bt - 6 - o]) rotate([180, 0, 0]) cylinder(r = 4 / 2 + 0.2, h = bt * 3, center = true);
	} // difference
}

module extruder_tower(AVal, BVal, CVal, correction, leadout = belt_len, bw = base_width, bt = base_thickness, th = tower_height, pushfit_dia = pushfit_dia, pushfit_h = pushfit_h, filament_dia = filament_dia, filament_slot = filament_slot, hobP = gt2_pulley_dias[60], driveP = gt2_pulley_dias[16], belt_len = belt_len, hpo = hob_pulley_offset, hob_dia = knurled_bolt_dia, hob_len = knurled_bolt_len, hob_thread_len = knurled_bolt_thread_len, hob_pos = knurled_bolt_knurl_pos, hob_width = knurled_bolt_hob_width, bslv = bearing_sleeve, bid = bearing_id, bod = bearing_od, bht = bearing_height, bfdia = bearing_flange_dia, iwd = idler_width, ilo = idler_leadout, iht = idler_height, rzo = idler_roller_z_offset, rxo = idler_roller_leadout_offset, ibd = idler_bolt_dia, ibl = idler_bolt_len, ird = idler_roller_dia, irt = idler_roller_thickness, ibo = idler_bearing_od, iwd = idler_washer_dia, iwt = idler_washer_thickness) {
	difference() {
	union() {
	translate([-bw / 2, bearing_od * 0.5, 0]) cube([bw, bearing_od * 2, th], center = false);
	// tower ribs
	translate([0, bearing_od * 1.5, 0]) {
		for (x = [-bw / 2, bw / 2]) {
			for (y = [bearing_od]) {
				// rib
				translate([x, y, th - (th / 2 - hpo) / 2]) rotate([0, 0, 0]) cylinder(r = 2, h = th / 2 - hpo, center = true);
				translate([x, -y, th / 2]) rotate([0, 0, 0]) cylinder(r = 2, h = th, center = true);
				// bottom cap
				translate([x, y, th / 2 + hpo + -1 - o]) rotate([0, 0, 0]) cylinder(r1 = 0.5, r2 = 2, h = 2, center = true);
				translate([x, -y, -1 - o]) rotate([0, 0, 0]) cylinder(r1 = 0.5, r2 = 2, h = 2, center = true);
			}
		}
	}
	}	// union
	// cutout knurled bolt
	translate([0, AVal / 2 - bearing_od / 2 + 3, 20 + hpo]) rotate([0, 90, 0]) cylinder(r = hob_dia / 2 + 0.1 + o, h = bw * 2, center = true);
	translate([0, AVal / 2 - bearing_od / 2 + 3, 20 + hpo]) {
		for (i = [-1, 1]) {
//			translate([i * bw / 2, 0, 0]) rotate([0, 90, 0]) cylinder(r = bearing_od / 2 + 4, h = 5, center = true);
			translate([bw / 2 * i, 0, 0]) rotate([0, 90 * i, 180]) sleeve_bearing(bid, bod, bht, bfdia);
		}
	// filament hole
	translate([0, hob_dia / 2, 0]) cylinder(r = (filament_dia + filament_dia * 0.15) / 2 + o, h = th * 2, center = true);
	// slot for idler
	translate([0, bw / 4 + 3, hpo]) rotate([0, 90, 0]) scale([1.26, 1, 1.2]) terawatt_idler_roller(0, ird, irt, ibo, 1, iwd, iwt);
	translate([0, bw / 4, hpo]) cube([irt * 1.251, bw / 2, ird * 0.98], center = true);
	translate([0, bw / 2, hpo]) cube([irt * 2.5, bw / 2, ird * 0.58], center = true);
	}	// translate
	// idler tension screw holes
	for (y = [1, -1]) {
		translate([y * (iwd / 2) + y * (4.2), bw / 2, ilo + 13]) rotate([90, 90, 0]) 00idler_tension_screwhole(iwd, iht * 4, 5);
	}	// for
	// idler tension screw captive nut slots
	for (y = [1, -1]) {
		translate([y * (iwd / 2) + y * (4.2),  bw / 2, ilo + 18]) scale([1.1, 1, 1]) cube([14 / 2, 6 / 2, 15], center = true);
		translate([y * (iwd / 2) + y * (4.2),  bw / 2 + 1.5, ilo + 11]) rotate([90, 90, 0]) scale([1, 1.1, 1]) nutHole(4);
	}	// for
	// hotend
	translate([0, AVal / 2 - bearing_od / 2 + 6.09, 10 - bt]) hotend_w_screws();
	}	// difference
}

module extruder_assembly_parts(AVal, BVal, CVal, correction, bowden = bowden, bw = base_width, bt = base_thickness, th = tower_height, pfdia = pushfit_dia, pfht = pushfit_h, fildia = filament_dia, filslot = filament_slot, hobP = gt2_pulley_dias[60], driveP = gt2_pulley_dias[16], belt_len = belt_len, hpo = hob_pulley_offset, hob_dia = knurled_bolt_dia, hob_len = knurled_bolt_len, hob_thread_len = knurled_bolt_thread_len, hob_pos = knurled_bolt_knurl_pos, hob_width = knurled_bolt_hob_width, bslv = bearing_sleeve, bid = bearing_id, bod = bearing_od, bht = bearing_height, bfdia = bearing_flange_dia, iwd = idler_width, ilo = idler_leadout, iht = idler_height, rzo = idler_roller_z_offset, rxo = idler_roller_leadout_offset, ibd = idler_bolt_dia, ibl = idler_bolt_len, ird = idler_roller_dia, irt = idler_roller_thickness, ibo = idler_bearing_od, iwd = idler_washer_dia, iwt = idler_washer_thickness) {
		translate([hob_len - 35, -hob_dia / 2, hpo]) rotate([0, 90, 0]) terawatt_knurled_bolt(hob_len, hob_dia, hob_thread_len, hob_pos, hob_width);
		translate([0, -hob_dia / 2, 0]) pulleys_and_bearings(hobP, driveP, CVal, hpo, hob_dia, bslv, bid, bod, bht, bfdia, bw - pfht * 3 + 3.5);
		translate([0, ird / 2 + rzo / 2 + fildia / 2 + 3 / 2 + 2, -iht]) rotate([0, 90, -90]) {
			color("Yellow", 1) 00idler();
			translate([-ilo / 2 - ilo / 8, 0, rzo * -1]) {
				translate([rxo, 0, rzo]) roller_and_bolt();
			}
		}
		// hotend
		translate([0, 0, -18 + bt]) hotend_w_screws();
		// filament
		translate([0, 0, 0]) filament(fildia);
}


