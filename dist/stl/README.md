This folder contains pre-compiled 00str00der STLs from OpenSCAD.  To determine which to print choose the 00str00der*.stl file that matches your belt/pulley combination.

-- Files --
00dapter.stl		- adapter to attach budaschnozzle instead of j-head
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
100% solid rectilinear infill.  The tower and idler experience significant stress during use and should be solid.

-- Bowden Configuration --
The 'bowden' keyword in a STL file means the tower is bored for a press-fit adapter for PTFE tubing, rather than having a hole for a J-head-compatible hotend; and the side-mounting holes for the j-head are excluded also.  Only use these files if you want a Bowden setup.

-- Customize --
If you want a custom belt/pulley combination then you'll want to customize the OpenSCAD source code in src/00str00der.scad and re-compile it.