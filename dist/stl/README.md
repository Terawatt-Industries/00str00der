This folder contains pre-compiled 00str00der STLs from OpenSCAD.  To determine which to print choose the 00str00der*.stl file that matches your belt/pulley combination.

-- Files --
00str00der*.stl		- 00str00der tower
wadeidler.stl		- wade's idler for 00str00der
mntplate_jk.stl		- mount plate to attach to Kuehling's x-carriage at http://www.thingiverse.com/thing:18657

-- 00str00der STL naming convention --
Please follow this filename convention to choose the appropriate STL file and when contributing:
00str00der[_bowden]_(num-teeth-big-pulley)TBP_(num-teeth-small-pulley)TSP_(num-teeth-gt2-belt)TB.stl

For example:
00str00der_65TBP_16TSP_88TB.stl = 00str00der tower for 65 teeth large pulley, 16 teeth small pulley, and 88 teeth belt.
00str00der_bowden_65TBP_16TSP_88TB.stl = ditto above with bowden = 1

-- Slicing Settings --
100% solid rectilinear infill.  The tower and idler experience significant stress during use and should be solid.

-- Bowden Configuration --
The 'bowden' keyword in a STL file means the tower has a hole for a press-fit adapter for PTFE tubing instead of a hole for a J-head hotend.  Only use these files if you want the Bowden configuration.

-- Customize --
If you want a custom belt/pulley combination then you'll want to customize the OpenSCAD source code in src/00str00der.scad and re-compile it.