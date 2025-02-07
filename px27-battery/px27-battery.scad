include <BOSL2/std.scad>
include <BOSL2/shapes3d.scad>

$fn = $preview ? 16 : 64;

diff()
  cylinder(h = 20 - 0.2, d = 13.25 - 0.2) {
    attach(BOT, BOT, inside = true)
      regular_prism(n = 8, h = 4, id = 6 + 0.4);
    attach(TOP, TOP, inside = true)
      cylinder(h = 16, d = 11.55 + 0.2);
    attach(RIGHT, RIGHT, inside = true)
      cube([7, 0.4, 20]);
  }
