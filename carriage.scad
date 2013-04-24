include <configuration.scad>;

separation = 40;
thickness = 6;
horn_thickness = 8;
belt_width = 5;
belt_x = 5.6;
belt_z = 7;

module carriage() {
  // Timing belt (up and down).
  translate([-belt_x, 0, belt_z + belt_width/2]) %
    cube([1.7, 100, belt_width], center=true);
  translate([belt_x, 0, belt_z + belt_width/2]) %
    cube([1.7, 100, belt_width], center=true);
  difference() {
    union() {
      // Main body.
      translate([0, 0, thickness/2])
        cube([27, 32, thickness], center=true);
      // Ball joint mount horns.
      difference() {
        intersection() {
          cube([separation, 40, 3*horn_thickness], center=true);
          translate([0, 20, horn_thickness/2]) rotate([0, 0, 45])
            cube([40, 40, horn_thickness], center=true);
        }
        cube([20, 100, 100], center=true);
      }
      // Belt clamps.
      intersection() {
         translate([5, 0, thickness + belt_width/2]) 
           cube([13, 12, belt_width+6], center=true);
         translate([1, 0, thickness + belt_width/2]) rotate([0, 0, 45])
           cube([11, 11, 20], center=true);
      }
      difference() {
        translate([10, 0, thickness + belt_width/2])
          cube([7, 32, belt_width+6], center=true);
         translate([1, 0, thickness + belt_width/2]) rotate([0, 0, 45])
           cube([15, 15, 20], center=true);
      }
    }
    // Screws for linear slider.
    for (x = [-10, 10]) {
      for (y = [-10, 10]) {
        translate([x, y, thickness]) #
          cylinder(r=m3_wide_radius, h=30, center=true, $fn=12);
      }
    }
    // Screws for ball joints.
    translate([0, 16, horn_thickness/2]) rotate([0, 90, 0]) #
      cylinder(r=m3_wide_radius, h=60, center=true, $fn=12);
  }
}

carriage();