This folder contains pre-compiled 00str00der STLs from OpenSCAD.  Right now the only belt length supported is 90T GT2.

-- Files --
00dapter.stl		- adapter to attach budaschnozzle instead of j-head - see below
00str00der*.stl		- 00str00der tower
00idler.stl		- 00str00der idler
mntplate_jk.stl		- mount plate to attach to Kuehling's x-carriage at http://www.thingiverse.com/thing:18657

-- 00str00der STL naming convention --

-- Slicing Settings --
100% solid infill recommended but not required for 00str00der*.stl, 00idler.stl, 00dapter.stl, they experience significant stress during use and should be solid.  The mount plate (mntplate_jk.stl) does not experience much stress and can use less material at ~50% infill, 2mm shell horizontal+vertical.  A 2mm shell is dependent on layer thickness and nozzle diameter you use when printing.

-- 00dapter --
The 00dapter provides compatibility with a budaschnozzle hotend.  It should work with Budaschnozzle 1.x and 2.x designs.  The budapter is designed to fit in the j-head slot in the 00str00der tower.  It protrudes from the bottom of the tower to fill the space created by the adapter plate mount.  Thus it is intended to be used with the adapter plate (mntplate_jk.stl).  This setup requires M4x30mm screws instead of the M4x20mm often used to attach to the x-carriage.  The budaschnozzle is too large to fit through the cavity in the adapter plate, so it cannot be mounted on top of the adapter plate.  When assembled the order of parts from top to bottom is:  
. 00str00der tower w/00dapter
. adapter plate (mntplate_jk.stl)
. budaschnozzle adapter plate
. x-carriage.

The budapter is not intended for use with the bowden-style 00str00der tower since the bowden-style uses the press-to-fit connector.

-- Customize --
If you want a custom belt/pulley combination then you'll want to customize the OpenSCAD source code in src/00str00der.scad and re-compile it.