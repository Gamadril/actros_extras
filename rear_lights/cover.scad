include <Round-Anything/polyround.scad>
use<cover_cutout.scad>
use<cover_segment.scad>

h_o = 9;
w_o = 27;

h_i = 7.1;
w_i = 25.4;

h_seg = h_o-2*0.6;

points_o = [
    [0, 0, 0],
    [w_o, 0, 1.5],
    [w_o, h_o, 1.5],
    [0, h_o, 0],
];

points_i = [
    [0, 0, 0],
    [w_i, 0, 1],
    [w_i, h_i, 1],
    [0, h_i, 0],
];

r = 164;
difference() {
    linear_extrude(4.5)
        polygon(polyRound(points_o, 50));

    translate([1, (h_o-h_i)/2, 0.8])
        linear_extrude(4)
            polygon(polyRound(points_i, 50));

    rotate([-90, 0, 0])
        translate([0, -r-2.25, 0])
            cylinder(h_o, r, r, $fn=500);               
    
    translate([9.8, 0.6, 0])
        segment(4.1, h_seg, 0.8);

    translate([19, 0.6, 0])
        segment(4.1, h_seg, 0.8);
}
//translate([9.8, 0.6, -0.2])
//    segment(4.1, h_seg, 1.2);

//translate([19, 0.6, -0.2])
//    segment(4.1, h_seg, 1.2);

translate([6, 0.6 + 1.8, 0])
    cutout(1.8, h_seg-2*1.8, 1);


