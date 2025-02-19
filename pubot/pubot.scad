include <BOSL2/std.scad>

$fn = $preview ? 16 : 64;

// PLA / Neptune 4 Pro
$slop = 0.25;

slit = 2 * $slop;
cube_edge_length = 60;
head_width = 30;
head_length = 24;
head_thickness = 8;
neck_length = cube_edge_length - head_thickness;
neck_width = 20;
neck_thickness = head_thickness;
arm_width = 10;
arm_length = 40;
foot_thickness = 8;

module half_body(anchor, spin, orient) {
  attachable(anchor, spin, orient, size = [cube_edge_length / 2, cube_edge_length, cube_edge_length], cp = [cube_edge_length / 4, cube_edge_length / 2, cube_edge_length / 2]) {
    diff()
      cube(size = [cube_edge_length / 2, cube_edge_length, cube_edge_length], anchor = anchor, spin = spin, orient = orient) {
        attach(TOP, TOP, align = FRONT+LEFT, inside = true) cube([(head_width + slit) / 2, head_thickness + slit, head_length + slit]);
        attach(TOP, TOP, align = FRONT+LEFT, inside = true) cube([(neck_width + slit) / 2, cube_edge_length, neck_thickness + slit]);
        attach(RIGHT, RIGHT, align = TOP, inside = true) cube([arm_width + slit, 2 * arm_width + slit, arm_length + slit]);
        attach(BOTTOM, BOTTOM, inside = true) cube([cube_edge_length / 2, cube_edge_length, foot_thickness + slit]);
      }
    children();
  }
}

module arm_1() {
  cube([arm_width, arm_width, arm_length]);
}

module arm_2() {
  cube([arm_width, arm_width, arm_length]);
}

module foot() {
  cube([(cube_edge_length - slit) / 2, cube_edge_length, foot_thickness]);
}

module half_neck() {
  cube([neck_width / 2, neck_length - $slop, neck_thickness]);
}

module neck() {
  cube([neck_width, neck_length - $slop, neck_thickness]);
}

module half_head() {
  cube([head_width / 2, head_thickness, head_length]);
}

module head() {
  cube([head_width, head_thickness, head_length]);
}

module half_all() {
  half_body() {
    attach(TOP, TOP, align = FRONT+LEFT, inside = true) half_head();
    attach(TOP, TOP, align = BACK+LEFT, inside = true) half_neck();
    back((arm_width + slit / 2) / 2) attach(RIGHT, RIGHT, align = TOP, inside = true) arm_1();
    fwd((arm_width + slit / 2) / 2) attach(RIGHT, RIGHT, align = TOP, inside = true) arm_2();
    attach(BOTTOM, BOTTOM, align = RIGHT, inside = true) foot();
  }
}

module body() {
  right(cube_edge_length / 4) half_body();
  xflip() right(cube_edge_length / 4) half_body();
}

// right(cube_edge_length / 4) half_all();
// xflip() right(cube_edge_length / 4) half_all();

// body();
// arm_1();
// arm_2();
neck();
// head();
// foot();
