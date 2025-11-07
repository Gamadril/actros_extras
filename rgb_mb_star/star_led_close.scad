$fn = 50;

difference() {
    cylinder(3, d=12);
    translate([0,0,0.6]) {
        cylinder(5, d=11);
    }
    translate([-2.75,-2.75,0]) {
        cube([5.5,5.5,1]);
    }
}

