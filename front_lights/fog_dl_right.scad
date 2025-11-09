$fn=60;

module base() {
    hull() {
        circle(d = 12);
        translate([-18.8, -4, 0])
            circle(1);
        translate([-17.8, 4.9, 0])
            circle(1.5);
    }
}

module mount() {
    hull() {
        circle(d = 12);
        translate([-23.4, 2.5, 0])
            circle(4);
        translate([-18.8, -4, 0])
            circle(1);
    }
}

module inner() {
    hull() {
        circle(d=8.5);
        translate([-18, 3.2, 0])
            circle(0.3);
        translate([-18.4, -3.2, 0])
            circle(0.35);
    }
}

module daylight() {
    polygon([
        [0, -1.3],
        [0, 1.3],
        [-18.434, 1.3],
        [-18.617, -1.3]
    ]);
}

module body() {
    difference() {
        union() {
            linear_extrude(5)
                base();
            translate([0,0,3])
                linear_extrude(2)
                    mount();
            translate([0,0,5])
                linear_extrude(3.3)
                    inner();
            translate([0,0,8])
                linear_extrude(4)
                    daylight();
        }
        // fog light led hole
        cylinder(20, d=2);
        translate([0,0,1])
            cylinder(20, d=6.4);
        translate([0,0,2])
            cylinder(20, d=8.5);
        translate([0,0,5])
            cylinder(20, d=12);
        translate([-23.4,2.5,0])
            cylinder(20, d=2.5);
        translate([0,0, 1])
            rotate(-87.5, [0,0,1])
            linear_extrude(1)
                polygon([
                    [0,0.65],
                    [0,-0.65],
                    [4.2,-0.65],
                    [4.2,0.65],
                ]);
        translate([-17, -0.7, 1])
            cube([10,1.4,9]);
        translate([-17, -0.7, 11])
            cube([10,1.4,3]);
        translate([-16.2, 0, 9])
            cylinder(3, d=1.2);
        translate([-14.1, 0, 9])
            cylinder(3, d=1.2);
        translate([-12, 0, 9])
            cylinder(3, d=1.2);
        translate([-9.9, 0, 9])
            cylinder(3, d=1.2);
        translate([-7.8, 0, 9])
            cylinder(3, d=1.2);
        // daylight led hole
        translate([-12.4, -0.7, 0])
            cube([2,1.4,1]);

        // pcb holes
        translate([-6, -4, 0])
            cylinder(3, d=1.5);
        translate([-17.8, 4.9, 0])
            cylinder(3, d=1.5);
    }
}

body();


