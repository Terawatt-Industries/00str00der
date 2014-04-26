// authors:  thingiverse (link), l. miller, f. beachler
// see (link) for GPLv3 license

use <MCAD/motors.scad>
use <MCAD/nuts_and_bolts.scad>
use <00_functions.scad>
use <wadeidler.scad>
$fn=100;

/////// Global Settings ////////
bowden = 0;
pushfit_dia = 0.375*25.4;
pushfit_h = 0.25*25.4;

filament_hole = 3.3;
filament_slot = 1;

// TODO move to a config SCAD, see other TODOs
/////// Global Parameters Calculation ////////
/// Enter pulley diameters HERE
//bigP = 37.69;    // large pulley diameter - ???
//smallP = 22.4;  // small pulley diameter - ???
bigP = 38.2;	// large pulley diameter - 60T plastic
//bigP = 40.9;    // large pulley diameter - 65T plastic
//bigP = 38.96;    // large pulley diameter - 62 alum
smallP = 10.2;  // small pulley diameter - 16T alum
//smallP = 10.8;  // small pulley diameter - 17T alum
belt_len = 90 * 2;  // for gt2 pulleys #of teeth x 2mm pitch

motor_maxdist = 34.85;  //ctc dist from motor center to hob center at zero offset

00str00der_main();

module 00str00der_main(bowden = bowden, pushfit_dia = pushfit_dia, pushfit_h = pushfit_h, filament_hole = filament_hole, filament_slot = filament_slot, bigP = bigP, smallP = smallP, belt_len = belt_len, motor_maxdist = motor_maxdist) {
   assign(AVal = aVal(belt_len, bigP, smallP)) {
	assign(BVal = bVal(AVal, bigP, smallP)) {
	assign(correction = corr(BVal)) {
	assign(CVal = cVal(AVal, correction)) {
	assign(block_offset = cVal(AVal, correction) - motor_maxdist) {
		echo(AVal);
		echo(BVal);
		echo(CVal);
		echo(correction);
		echo(block_offset);
		00str00der(bowden, pushfit_dia, pushfit_h, filament_hole, filament_slot, bigP, smallP, belt_len, motor_maxdist, AVal, BVal, CVal, correction, block_offset);
	// uncomment this to see pulleys and bearings
	// pulleys_and_bearings();
	}}}}}
}

module pulleys_and_bearings(bowden = bowden, pushfit_dia = pushfit_dia, pushfit_h = pushfit_h, filament_hole = filament_hole, filament_slot = filament_slot, bigP = bigP, smallP = smallP, belt_len = belt_len, motor_maxdist = motor_maxdist, AVal, BVal, CVal, correction, block_offset) {
	translate([5,12,0]) rotate([0,90,0]) large_pulley_w_hob();
	translate([1.35,12,0]) rotate([0,90,0]) 608_bearing();
	translate([-17,12,0]) rotate([0,90,0]) 608_bearing();
	translate([-8,12+22/2+8/2-0.5,0]) rotate([0,90,0]) 608_bearing();
	translate([-6,19,0]) color("Blue",1) cylinder(r=3.5/2,h=100,center=true);
	translate([0,-52+42.3/2,-5]) rotate([0,90,0]) stepper_w_pulley(); 
	translate([6,22,-34]) rotate([90,0,0]) rotate([0,-90,0]) wadeidler();
}

// TODO parametrize this module and _all_ dependent modules
module 00str00der(bowden = bowden, pushfit_dia = pushfit_dia, pushfit_h = pushfit_h, filament_hole = filament_hole, filament_slot = filament_slot, bigP = bigP, smallP = smallP, belt_len = belt_len, motor_maxdist = motor_maxdist, AVal, BVal, CVal, correction, block_offset) {
	union() {
		difference() {
			union() {
				extruder_base(bowden, pushfit_dia, pushfit_h, filament_hole, filament_slot, bigP, smallP, belt_len, motor_maxdist, AVal, BVal, CVal, correction, block_offset);
				// Position the extruder block
				translate([-7,block_offset,0]) rotate([0,0,180]) extruder_block(bowden, pushfit_dia, pushfit_h, filament_hole, filament_slot, bigP, smallP, belt_len, motor_maxdist, AVal, BVal, CVal, correction, block_offset);
				// Add mounts for hinge
				translate([-6,9+block_offset,11/2-42.3/2-5.5]) cube([12.5,26,8],center=true);
				translate([-6,17+block_offset,-17]) rotate([0,90,0]) cylinder(r=10/2,h=12.5,center=true);
				translate([-12 + 0.01,11+block_offset,11/2-42.3/2-5.5]) rotate([0,0,-90]) fillet(2,8);
				translate([0 - 0.01,11+block_offset,11/2-42.3/2-5.5]) rotate([0,0,180]) fillet(2,8);
			}
			/// Make a hole for the filament 3.5mm wide w/ a little slot room
			for (i = [0:0.25:filament_slot]) {
				translate([-6,block_offset+6.75-i-filament_slot/2,0]) color("Blue",1) cylinder(r=filament_hole/2,h=100,center=true);
			}
			for (i = [0:0.25:1.25]) {
				translate([-6,block_offset+6.75-i,0]) color("Blue",1) cylinder(r=3.5/2,h=100,center=true);
			}

			if (bowden == 0) {
				// Make a hole for the hotend (j-head style)
				translate([-6,block_offset+6.75-filament_slot,-20.5]) hotend_w_screws();
			} else {
				translate([-6,block_offset+6.75-filament_slot,-32.2+pushfit_h/2]) cylinder(r=pushfit_dia/2,h=pushfit_h,center=true);
				//mounting holes
				translate([0,-3,-26]) rotate([0,90,0]) cylinder(r=2.05,h=100,center=true);
				translate([0,7,-26]) rotate([0,90,0]) cylinder(r=2.05,h=100,center=true);
				translate([-15,7,-26]) rotate([0,90,0]) nutSlot(10,0.1);
				translate([-15,-3,-26]) rotate([0,90,0]) nutSlot(10,0.1);
			}

			// Make a hole for the hinge mount
			translate([0,block_offset+17,-16.5]) rotate([0,90,0]) cylinder(r=2 + 0.2,h=100,center=true);
		}

		//Add a solid layer for better prints -- will have to cut hole after
		if (bowden == 0) {
			translate([-6,block_offset+6.75-filament_slot,-20.75]) cylinder(r=(5/16*25.4)+0.25,h=0.25);
		} else {
			translate([-6,block_offset+6.75-filament_slot,-32.2+pushfit_h-0.05]) cylinder(r=(5/16*25.4)+0.25,h=0.25);
		}
		translate([-6,block_offset+6.75,-20.75]) cylinder(r=(5/16*25.4)+0.25,h=0.25);
	}
}

// TODO add parameters for block dimensions such as filament
// diameter - currently fixed
module extruder_block(bowden = bowden, pushfit_dia = pushfit_dia, pushfit_h = pushfit_h, filament_hole = filament_hole, filament_slot = filament_slot, bigP = bigP, smallP = smallP, belt_len = belt_len, motor_maxdist = motor_maxdist, AVal, BVal, CVal, correction, block_offset) {
	difference() {
		minkowski() {

			// Main block
			translate([0,0,-4]) cube([24,18,44.3],center=true);

			// Contour edges with minkowski
			translate([-1,0,0]) rotate([0,90,0]) cylinder(r=2,h=4,center=true);
		}

		// Make slots for the bolts
		// TODO parametrize
		translate([-9, 8, 16]) rotate([90, 0, 0]) cylinder(r=4/2+0.5, h=50, center=true);
		translate([7, 8, 16]) rotate([90, 0, 0]) cylinder(r=4/2+0.5, h=50, center=true);
		translate([-9, 3, 10+16]) rotate([0, 0, 90]) rotate([0, 90, 0]) nutSlot(10, 0.1, size=4);
		translate([7, 3, 10+16]) rotate([0, 0, 90]) rotate([0, 90, 0]) nutSlot(10, 0.1, size=4);

		// Clear the hobbed bolt
		//% translate([12,-2,0]) rotate([0,90,0]) large_pulley_w_hob();
		translate([12 - 0.01, -2, 0]) rotate([0,90,0]) cylinder(r = 8 / 2 + 0.2, h=100, center=true);

		// Make spots for the 608 bearings that retain hob
		translate([11.35,-2,0]) rotate([0,90,0]) 608_bearing();
		translate([-13,-2,0]) rotate([0,90,0]) 608_bearing();

		// Cut a slot for the 608 bearing that presses on the filament
		translate([-1 - 0.5, -16, 0]) rotate([0,90,0]) 608_bearing();
		translate([-1 + 0.5, -16, 0]) rotate([0,90,0]) 608_bearing();

		/// Make a hole for the filament
		//for (i = [0:0.25:0.75]){
		//translate([-1,-6-i,0]) color("Blue",1) cylinder(r=3.5/2,h=100,center=true);}

		// Cut some room for the bearing to press against hob
		translate([-1, -6, 0]) color("Blue",1) cube([8,6,12.5],center=true);
		//translate([-1, -8.01, 2.5]) color("Blue",1) cube([8,6,16],center=true);

		// Clear some unnecessary overhang that won't print well
		translate([11.35, -9, 12]) cube([7,20,20],center=true);
		translate([-13, -9, 12]) cube([7,20,20],center=true);
	}
}

// TODO add parameters for base dimensions - currently fixed
module extruder_base(bowden = bowden, pushfit_dia = pushfit_dia, pushfit_h = pushfit_h, filament_hole = filament_hole, filament_slot = filament_slot, bigP = bigP, smallP = smallP, belt_len = belt_len, motor_maxdist = motor_maxdist, AVal, BVal, CVal, correction, block_offset) {
	difference() {
		minkowski() {
			difference() {
				translate([-11+6,-15.5+block_offset/2,11/2-42.3/2-7]) cube([24,71+block_offset,15],center=true);
				translate([-8,21+block_offset,-19.5]) cube([100,24,10],center=true);
			}
			translate([-5+4,0,0]) rotate([0,90,0]) cylinder(r=2,h=4,center=true);
		}
		// mount screws
		translate([1, -4.5, -20]) rotate([0,180,0]) cylinder(r = 2.2, h = 35,center=true);
		translate([-13, -4.5, -20]) rotate([0,180,0]) cylinder(r = 2.2, h = 35,center=true);
		//translate([-8, -23, -20]) rotate([0,180,0]) cylinder(r = 2.2, h = 35,center=true);
		translate([-8, -43, -20]) rotate([0,180,0]) cylinder(r = 2.2, h = 35,center=true);
		//translate([-8, -23, -10.5]) rotate([0,180,0]) cylinder(r = 3.2, h = 35,center=true);
		translate([-8, -43, -10.75]) rotate([0,180,0]) cylinder(r = 4.75, h = 35,center=true);

		// Add a slotted motor mount
		for (i = [-2:0.5:2]) {
		translate([0,-52+42.3/2+i,-5]) rotate([0,90,0]) stepper_w_pulley2();
		}
	}
}

