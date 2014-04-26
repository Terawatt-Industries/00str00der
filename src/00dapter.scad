/*
00dapter SCAD by Free Beachler
inspired by http://www.thingiverse.com/thing:21412

Adapts existing J-Head/RepRapFab-compatible extruder, such as Wade's or Greg Frost's extruder designs, to a Budaschnozzle-compatible one.  Helps to reduce filament kinking.  This version has a parameter for the 00str00der-jkmnt adapter plate.  With this parameter enabled and an adapter plate the 00str00der is compatible with most Budaschnozzle setups.
*/

$fn = 100;

jhead_mnt_depth = 9.5;
d = (5/16 * 25.4 + 0.25 + 0.55) * 2;
fw = 3.5;
rnd = 2;
nippleheight = 1.5;
mntplate = 1;	// 1 for use with mounting plate mntplate_jk; 0 otherwise -- do not use other values
mntplate_thickness = 7 * mntplate;		// note weird use of flag

translate([0, 0, 0]) 00dapter();

module 00dapter(base_height = jhead_mnt_depth, d = d, fw = fw, rnd = rnd, nippleheight = nippleheight, mntp = mntplate, mntph = mntplate_thickness) {
 assign(h = base_height + mntph) {
  difference() {
    union() {
      // base
      rotate([0, 0, 90]) cylinder(r = d / 2 - 0.1, h = h - rnd, center=false);
      translate([0, 0, h - rnd])
      intersection() {
          rotate([0, 0, 90]) cylinder(r = d / 2 - 0.1, h = rnd, center=false);
		  translate([0, 0, 0]) sphere(d / 2);
      }
      // nipple
      translate([0, 0, h]) {
        difference() {
          cylinder(r1 = 4, r2 = fw / 2 + 0.1, h = nippleheight, center = false);
          translate([-d / 2, -d / 2, nippleheight - 0.1]) cube([d, d, nippleheight * 3]);
        }
      }
    }
  // filament hole
  rotate([0, 0, 90]) cylinder(r = fw / 2, h = h * 4, center=true);
  }
 }
}
