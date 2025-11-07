include <Round-Anything/polyround.scad>

module inlay() {
    w = 24.5;
    h = 7;
    e = 11;

    points=[
        [0, 0, 0],
        [w, 0, 1],
        [w, h, 1],
        [0, h, 0],
    ];

    difference() {
        union() {
            difference() {
                linear_extrude(e)
                    polygon(polyRound(points, 50));
                translate([0, 0.2, 1.0])
                    cube([w, h-0.4, e]);
                //translate([21.7, 0, 1.0])
                //    cube([3, h, e]);
                translate([2.6, h/2, 0])
                    cube([1.4, 3, 2], true);
                translate([5.7, h/2, 0])
                    cube([1.4, 3, 2], true);
                translate([15.5, h/2, 0])
                    cube([1.4, 3, 2], true);
                translate([20.1, h/2, 0])
                    cube([1.4, 3, 2], true);
                translate([11.5, 4.3, 0])
                    cube([3, 1.4, 2], true);
                translate([23.9, h/2, 0])
                    cube([2, 3, 2], true);
            }
            translate([2.8, 0, 0])
                separator(0.2, h, e);
            translate([8.0, 0, 0])
                separator(0.2, h, e);
            translate([12.5, 0, 0])
                separator(0.2, h, e);
            translate([17.2, 0, 0])
                separator(0.2, h, e);
            translate([21.5, 0, 0])
                separator(0.2, h, e);
        }
        translate([9.8, 0.6, 0])
            cylinder(3.5, r=2.2, $fn=100);
        //translate([0, 0, 1.0])
        //    cube([2.95, h, e]);        
    }

    module separator(w,h,e) {
        a = 1.3;
        b = 1.8;
        t = 0.2;
        linear_extrude(e)
            polygon([
                [0, 0],
                [w, 0],
                [w+a, b],
                [w+a, h-b],
                [w, h],
                [0, h],
                [a, h-b],
                [a, b]
            ]);
    }
}

inlay();