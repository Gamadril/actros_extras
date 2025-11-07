include <Round-Anything/polyround.scad>

module esc_box(thickness) {
    difference() {
        union() {
        
        difference() {
            union() {
                hull() {
                    translate([60.8, 42.3, 0])
                        cylinder(h = thickness, d=7, $fn=20);
                    translate([7.7, 42.3, 0])
                        cylinder(h = thickness, d=7, $fn=20);
                }
                translate([16.5,33,0]) 
                    cube([40, 6, thickness]);
            }

            translate([60.8, 42.3, 0])
                cylinder(h = thickness, d=3.5, $fn=20);
            translate([7.7, 42.3, 0])
                cylinder(h = thickness, d=3.5, $fn=20);
        }
        
        translate([16.5, 0, 0]) {
            difference() {
                cube([40,34,7]);
                translate([1.5, 2, 0]) {
                    cube([37,31,5.5]);
                }
                translate([38.5,14,0]) {
                    cube([1.5, 7, 7]);
                }
                //translate([40 / 2, 1, 0])
                    //cylinder(h=3, d=1, $fn=20);
            }
        }
        }
        
        translate([33,32.5,0]) {
            cube([7, 1.5, 2]);
        }
    }
}

esc_box(1.5);
