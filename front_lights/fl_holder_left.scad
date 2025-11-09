$fn = 60;

module arc(r1, r2, a1, a2) {
    difference() {
        difference() {
            polygon([[0,0], [cos(a1) * (r1 + 50), sin(a1) * (r1 + 50)], [cos(a2) * (r1 + 50), sin(a2) * (r1 + 50)]]);
            circle(r = r2);
        }
        difference() {
            circle(r=r1 + 100);
            circle(r=r1);
        }
    }
}

module body() {
    difference() {
        union() {
            hull() {
                cylinder(2, d=14.5);
                translate([12,0,0])
                    cylinder(2, d=12);
                translate([7.36,-4.25,0])
                    cylinder(2, d=5.5);
                translate([7,6.53,0])
                    cylinder(2, d=9);
                translate([-0.33,7.79, 0])
                    cylinder(2, d=5);
            }

            difference() {
                union() {
                    difference() {
                        cylinder(11, d=14.5);
                        translate([-3.3,-3,2])
                            cylinder(12, d=2.6);
                    }
                    translate([7,6.53,0])
                        cylinder(10, d=9);
                    translate([-0.33,7.79, 0])
                        cylinder(6.8, d=5);
                }
                translate([12,0,2])
                    cylinder(10, d=12);
            }
            translate([12,0,0])
                cylinder(4.5, d=9);
            cylinder(11,d=9);
        }

        translate([-3.3,-3,0])
            cylinder(2, d=2);

        cylinder(3, d=2);
        translate([0,0,2]) {
            cylinder(5, d=5.3);
            translate([0,0,4.9]) {
                cylinder(3, d=6.5);
                translate([0,0,1.5]) {
                    cylinder(3, d=9);
                }
            }
        }

        translate([7.36,-4.25,0]) {
            cylinder(14, d=2);
            translate([0,0,2]) {
                cylinder(12, r=2.75);
            }
        }

        translate([12,0,0]) {
            cylinder(2, d=3);
            translate([0,0,1.5]) {
                cylinder(2, d=4.5);
                translate([0,0,1.5]) {
                    cylinder(2, d=6.5);
                }
            }
        }
                    
        translate([7,6.53,0]) {
            cylinder(2, d=2);
            translate([0,0,2]) {
                cylinder(5, d= 3);
                translate([0,0,4.5]) {
                    cylinder(2, d=4.5);
                    translate([0,0,1.5]) {
                        cylinder(5, d=7);
                        translate([0,0,2]) {
                            cylinder(5, d=9);
                        }
                    }
                }
            }
        }

        translate([-0.33,7.79, 0]) {
            cylinder(12, d=2);
            translate([0,0,6.8])
                cylinder(5, d=5);
        }

        translate([0,0, 8])
            linear_extrude(3)
                arc(8, 14.5/2, 22, 26);

        
        rotate(-33.4, [0,0,1])
        translate([4.2, -8, 11])
                rotate(25, [0,1,0])
                    cube([5,15,2]);
    }
}

body();