This folder contains pre-compiled 00str00der STLs from OpenSCAD.  To determine which to print choose the 00str00der*.stl file that matches your belt/pulley combination.  The same idler and adapter plate will work with all tower 00str00der*.stl files.

-- Files --
00dapter.stl		- adapter to attach budaschnozzle instead of j-head - see below
00str00der*.stl		- 00str00der tower; see below for naming convention
wadeidler.stl		- wade's idler for 00str00der
mntplate_jk.stl		- mount plate to attach to Kuehling's x-carriage at http://www.thingiverse.com/thing:18657

-- 00str00der STL naming convention --
Please follow this filename convention to choose the appropriate STL file to print, and when contributing:
00str00der[_bowden]_(num-teeth-big-pulley)TBP_(num-teeth-small-pulley)TSP_(num-teeth-gt2-belt)TB.stl

For example:
00str00der_60TBP_16TSP_88TB.stl :: 00str00der tower for 60 tooth large pulley, 16 tooth small pulley, and 88 tooth belt.
00str00der_bowden_60TBP_16TSP_88TB.stl :: ditto above with bowden = 1
00str00der_65TBP_17TSP_90TB.stl :: 00str00der tower for 65 tooth large pulley, 17 tooth small pulley, and 90 tooth belt.

-- Slicing Settings --
100% solid infill for 00str00der*.stl, wadeidler.stl, 00dapter.stl because they experience significant stress during use and should be solid.  The mount plate (mntplate_jk.stl) does not experience much stress and can use less material at ~50% infill, 2mm shell horizontal+vertical.  A 2mm shell is dependent on layer thickness and nozzle diameter you use when printing.

-- Bowden Configuration --
The 'bowden' keyword in a STL file means the tower is bored for a press-fit adapter for PTFE tubing, rather than having a hole for a J-head-compatible hotend; and the side-mounting holes for the j-head are excluded also.  Only use these files if you want a Bowden setup.

-- 00dapter --
The 00dapter provides compatibility with a budaschnozzle hotend.  It should work with Budaschnozzle 1.x and 2.x designs.  The budapter is designed to fit in the j-head slot in the 00str00der tower.  It protrudes from the bottom of the tower to fill the space created by the adapter plate mount.  Thus it is intended to be used with the adapter plate (mntplate_jk.stl).  This setup requires M4x30mm screws instead of the M4x20mm often used to attach to the x-carriage.  The budaschnozzle is too large to fit through the cavity in the adapter plate, so it cannot be mounted on top of the adapter plate.  When assembled the order of parts from top to bottom is:  
. 00str00der tower w/00dapter
. adapter plate (mntplate_jk.stl)
. budaschnozzle adapter plate
. x-carriage.

The budapter is not intended for use with the bowden-style 00str00der tower since the bowden-style uses the press-to-fit connector.

-- Customize --
If you want a custom belt/pulley combination then you'll want to customize the OpenSCAD source code in src/00str00der.scad and re-compile it.