// 00str00der v2 by Free Beachler
// based on 00str00der v1 by Lee Miller and Free Beachler
// Apache 2 License

use <00_functions.scad>
include <00_config.scad>

terawatt_idler_roller();

module terawatt_idler_roller(bd = idler_bolt_dia, od = idler_roller_dia, thick = idler_roller_thickness, ibd = idler_bearing_od, washers = 1, wd = idler_washer_dia, wthick = idler_washer_thickness) {
	difference() {
		color("Gray", 1) cylinder(r = od / 2, h = thick, center = true);
		cylinder(r = ibd / 2, h = thick * 2, center = true);
	}
	// bushing
	difference() {
		color("White", 1) cylinder(r = ibd / 2 - 0.1, h = thick, center = true);
		cylinder(r = bd / 2, h = thick * 2, center = true);
	}
	if (washers) {
		for (i = [-1, 1]) {
			difference() {
				translate([0, 0, i * thick / 2]) color("Yellow", 1) cylinder(r = wd / 2 - 0.1, h = wthick, center = true);
				cylinder(r = bd / 2, h = thick * 2, center = true);
			}
		}
	}
}