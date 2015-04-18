// 00str00der v2 by Free Beachler
// Apache 2 License

/////// Global Settings ////////
o = 0.001;

filament_dia = 3;
filament_dia_tolerance = 0.1;	// +/- tolerance
filament_slot = 1;

belt_len = 90 * 2;  // for gt2 pulleys #of teeth x 2mm pitch

bowden = 0;	// 0 for bowden, 1 for direct drive
base_width = 30;
base_thickness = 4;
tower_height = 52;
pushfit_dia = 0.375*25.4;	// for bowden
pushfit_h = 0.25*25.4;		// for bowden
hob_pulley_offset = 3;	// move hob pulley up/down w/respect to drive pulley z-axis plane

knurled_bolt_dia = 6;
knurled_bolt_len = 65 + 5;	// + 5 for head
knurled_bolt_thread_len = 24;
knurled_bolt_knurl_pos = knurled_bolt_len - 24 - 10;	// pos from head
knurled_bolt_hob_width = 10;

bearing_sleeve = 1;		// 1 for sleeve bearings, 0 for roller bearings
bearing_id = 6.02 + 0.05;
bearing_od = 12.7 + 0.07;
bearing_height = 9.6;
bearing_flange_dia = 14.2;

idler_width = 30;
idler_leadout = 30;
idler_height = 13;
idler_roller_z_offset = 2.1;
idler_roller_leadout_offset = 0;

idler_bolt_dia = 6;
idler_bolt_len = 45;
idler_roller_dia = 20;	// diameter of idler roller
idler_roller_thickness = 5;
idler_bearing_od = 12;
idler_washer_dia = idler_bearing_od - 2;
idler_washer_thickness = 3;

/*
bearing_sleeve = 0;		// 1 for sleeve bearings, 0 for roller bearings
bearing_id = 8;
bearing_od = 22;
bearing_height = 16;
bearing_flange_dia = 13.5;
*/

/// gt2 pulley dias indexed by tooth size
gt2_pulley_dias = [ -1,
	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
	-1, -1, -1, -1, -1, 10.19, 10.82, -1, -1, -1,
	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
	-1, -1, -1, -1, -1, 22.92, -1, -1, -1, -1,
	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
	-1, -1, -1, -1, -1, -1, -1, -1, -1, 38.2,
	-1, 39.47, -1, -1, 41.38, -1, -1, -1, -1, -1];
