thickness = 1.5;

difference() {
    union() {
        cube([140 + 2 * thickness, 26 + 2 * thickness, 25 + thickness]);
        translate([140 + thickness, 20, 0]) {
            cube([12, 9, 25 + thickness]);
        }
    }
    translate([thickness, thickness, thickness]) {
        cube([140, 26, 26]);
    }

    translate([20, 20 ,0]) {
        cylinder(thickness, d=3, $fn= 40);
    }
    translate([20, 7 ,0]) {
        cylinder(thickness, d=3, $fn= 40);
    }
    translate([112 + 20, 20 ,0]) {
        cylinder(thickness, d=3, $fn= 40);
    }
    translate([112 + 20, 7 ,0]) {
        cylinder(thickness, d=3, $fn= 40);
    }


    translate([140 + thickness, 20, thickness]) {
        cube([12 - thickness, 9 - thickness, 26]);
    }

    rotate(-90, [1, 0, 0]) {
        for (i = [0:3]) {
            translate([29 * i + 25, -14 , -5]) 
                cylinder(h = 40, d = 20, $fn = 50);  
        }
    } 
}

// 2, 1.3