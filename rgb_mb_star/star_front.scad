$fn = 100;

diam = 27.5;
height = 5;
holder_diam = 29;
thickness = 1;

difference()
{
  union()
  {
    translate([ 0, 0, -2 ]) cylinder(height, d = diam);
    cylinder(1, d = holder_diam);
  }
  translate([ 0, 0, -2 ])
  {
    cylinder(height - thickness, d = diam - thickness * 1.5);
  }

  cylinder(4, d = 2);
  translate([ 0, 8.3, 0 ])
  {
    cylinder(4, d = 0.9);
  }
}