$fn = 100;

inner_diam = 27.5;
thickness = 1;
led_inner_diam = 10;
led_height = 2.5;

difference()
{
  union()
  {
    difference()
    {
      union()
      {
        cylinder(4, d = inner_diam + 2 * thickness);
        hull()
        {
          translate([ 20, 4, 0 ]) cylinder(thickness, d = 6);
          translate([ -20, 4, 0 ]) cylinder(thickness, d = 6);
        }
      }
      translate([ 0, 0, thickness ]) cylinder(5, d = inner_diam);
      translate([ 20, 4, 0 ]) cylinder(thickness, d = 2);
      translate([ -20, 4, 0 ]) cylinder(thickness, d = 2);
    }
    cylinder(thickness + led_height, d = led_inner_diam + thickness);
  }
  translate([ 0, 0, thickness]) cylinder(5, d = led_inner_diam);
  translate([ 0, -0.3, thickness ]) cube([ (inner_diam + 2 * thickness) / 2, 0.6, 6 ]);
}