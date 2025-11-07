include <Round-Anything/polyround.scad>

thickness = 2;

plate_points = [
    [ 0, 0, 3 ],
    [ 0, 50, 0 ],
    [ 66.1, 50, 0 ],
    [ 66.1, 41, 4 ],
    [ 73.9, 41, 4 ],
    [ 73.9, 50, 0 ],
    [ 80, 50, 1 ],
    [ 80, 7, 1 ],
    [ 75.4, 7, 1 ],
    [ 75.4, 14.5, 3.5 ],
    [ 68.6, 14.5, 3.5 ],
    [ 68.6, 7, 1 ],
    [ 115 - 50, 7, 3 ],
    [ 115 - 50, 0, 3 ],
];

esc_points = [
    [ 0, 0, 1 ],
    [ 0, 5, 1 ],
    [ -5, 5, 2 ],
    [ -5, 26, 2 ],
    [ 0, 26, 1 ],
    [ 0, 31, 1 ],
    [ 14, 31, 0 ],
    [ 15, 33, 0 ],
    [ 21, 33, 0 ],
    [ 22, 31, 0 ],
    [ 37, 31, 1 ],
    [ 37, 19, 1 ],
    [ 40, 19, 1 ],
    [ 40, 12, 1 ],
    [ 37, 12, 1 ],
    [ 37, 0, 1 ],
];

difference() {
    difference() {
        polyRoundExtrude(plate_points, thickness, 0, 0);
        translate([60.8, 42.3, 0])
            cylinder(h = thickness, d=3, $fn=20);
        translate([7.7, 42.3, 0])
            cylinder(h = thickness, d=3, $fn=20);
    }
    translate([18, 2, 0]) {
        polyRoundExtrude(esc_points, thickness, 0, 0);
    }
    translate([18 + 18, 1, 0]) {
        //cylinder(thickness, d=1, $fn=30);
    }
}


