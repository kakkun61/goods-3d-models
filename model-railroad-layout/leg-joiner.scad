include <BOSL2/std.scad>

$fn = $preview ? 16 : 64;

// Overture Air Wood PLA / Neptune 4 Pro
$slop = 0.25;

wall_thickness = 2;
stopper_height = 5;
stopper_thickness = 3;
cross_leg_height = 19;
cross_leg_width = 30;
hook_length = 7;
screw_hole_offset_top = 5;
screw_hole_diameter = 6.5;
screw_hole_offset_bottom = 5;
screw_thread_diameter = 3;

top_square_width = wall_thickness * 2 + cross_leg_height;
top_square_height = stopper_thickness + hook_length;
bottom_square_width = sqrt(top_square_width ^ 2 / 2);
bottom_square_height = screw_hole_offset_top + screw_hole_diameter + screw_hole_offset_bottom;
height = cross_leg_width + 2 * wall_thickness;
screw_hole_height = bottom_square_width - wall_thickness;

module sketch() {
  tag("a")
    square(
      size =
        [ bottom_square_width,
          bottom_square_height
        ]
      )
      attach(BACK, FRONT) {
        tag("b")
          right_triangle(size = bottom_square_width)
            attach("hypot", FRONT) {
              square(size = [top_square_width, top_square_height]);
              tag("c")
                square(size = [cross_leg_height + $slop, hook_length + $slop])
                  attach(BACK, FRONT)
                    square(size = [cross_leg_height - 2 * stopper_height + $slop, stopper_thickness]);
            };
      };
}

module leg_female()
  difference() {
    linear_extrude(height) show_only("a b") sketch();
    up(wall_thickness - $slop) linear_extrude(height - wall_thickness + $slop) show_only("c") sketch();
    back(screw_hole_offset_bottom + screw_hole_diameter / 2) up(height / 2) yrot(90) {
      cylinder(h = wall_thickness, d = screw_thread_diameter)
        attach(TOP, BOTTOM)
          cylinder(h = screw_hole_height, d = screw_hole_diameter);
    }
  }

module male()
  diff()
    cube(size = [cross_leg_height, cross_leg_width, hook_length])
      attach(TOP, BOTTOM, align = BACK)
        cube(size = [cross_leg_height - 2 * stopper_height, cross_leg_width, stopper_thickness])
          attach(TOP, TOP, inside = true)
            cylinder(d = screw_thread_diameter, h = wall_thickness)
              attach(BOTTOM, TOP)
                cylinder(d = screw_hole_diameter, h = hook_length + stopper_thickness - wall_thickness);

module stage_female() {
  module half()
    difference() {
      linear_extrude(height) show_only("b") sketch();
      up(wall_thickness - $slop) linear_extrude(height - wall_thickness + $slop) show_only("c") sketch();
    }
  xflip() half();
  half();
}

leg_female();

right(20) up(cross_leg_width) xrot(-90) male();

right(50) stage_female();

right(100) xflip() leg_female();
