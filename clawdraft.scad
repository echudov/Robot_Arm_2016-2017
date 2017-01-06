h = 35; //height of the entire structure
innerr = 11.5; //inner radius for cylinders
outerr = 13.5; //outer radius for cylinders
pennyradius = 10; //radius of a penny
pennyheight = 1.52; //height of a penny
motorlength = 24; //length of the motor (long side)
servothickness = 12; //thickness of the motor
armlength = 90;

x = 4; //length in the x direction for the points
y = innerr*2; //length in the y direction for the points
th = 2; //height of triangular prism

tripoints = [
    [x, th], //0
    [x, 0], //1
    [0, th] //2
];

module triangpris() {
    translate([0, -0.5*y, th]) {
        rotate([0, 0, 180]) {
            rotate([90, 180, 0]) {
                linear_extrude(height = y, center = 0, convexity = 10, twist = 0, slices = 20) {
                    polygon(tripoints);
                }
            }
        }
    }
}


//draws a triangular prism

module hollowcylinder() {
    difference() {
        cylinder(h, outerr, outerr);
        cylinder(h, innerr, innerr);
    }
}

//creates a hollow cylinder

module halfcylinder () {
    intersection() {
        hollowcylinder();
        translate([0,-outerr,0]) {
            cube([outerr,2*outerr,100]);
        }
    }
}

//halves the hollow cylinder

module rotatedhalfcyl() {
    translate([-40, 0, 0]) {
        rotate([0, 0, 180]) {
            halfcylinder();
        }
    }
}

//rotates halfcylinder to normal side of graph

module innerportion() {
    difference() {
        cylinder(th, innerr, innerr);
        
    }
}

//creates inner scooper only

module innerhalf(){
    intersection() {
        innerportion();
        translate([0, -innerr, 0]) cube([innerr, 2*innerr, 5]);
    }
}

//halves scooper portion

module triangprismed() {
    difference() {
        innerhalf();
        translate([0, -0.5*y, 0]) {
            cube([x, y, th]);
        }
    }
    intersection() {
        innerhalf();
        triangpris();
    }
}


//allows ends of the innerhalf to pick up pennies if they aren't exactly in the center of the claw

module transtrianged() {
    translate([-40, 0, 0]) {
        rotate([0, 0, 180]) triangprismed();
    }
}

//translated and rotated combined cylinder and scooperw/ triangpris ends



//beginning of additional stuff for claw such as the servoholder

module pennystuff(length) {
    difference() {
        translate([outerr - 6, -1.2*pennyradius, 0]) {
                difference() {
                    cube([length*pennyradius, 2.4*pennyradius, h]);
                    translate([0, 0.15*pennyradius, 3]) cube([length*pennyradius, 2.1*pennyradius, h]);
            }
        }
        cylinder(h, outerr, outerr);
    }
}

//entrance and exit structure for pennies (the walls coming from the halfcylinders)

module servoholder() {
    difference() {
        translate([0, outerr - 1, 0]) {
            cube([3, 22 + motorlength, h]);
        }
        translate([0, 0.5*outerr - 1, 0]) { 
            cylinder([2*outerr, 2*outerr, h]);
        }
    }
}

//the arm extending for the servo holder (excluding the other parts)

module extention() {
    servoholder();
    translate([-0.5*servothickness, 22 + outerr, 0]) {
        cube([3 + servothickness, motorlength + 6, h]);
    }
}

//the servo arm with the box for the servo (box still full)

module extentionminus() {
    difference() {
        extention();
        translate([-0.5*servothickness, 22 + outerr + 3, 0]) {
            cube([servothickness, motorlength, h]);
        }
    }
}

//excluding the servo from the arm (to be able to place servo into the arm)

module entrance() {
    translate([-2, 0, 0]) pennystuff(2);
}

//place where pennies enter (the walls coming out of the cylinders)

module exit() {
    rotate([0, 0, 180]) {
        translate([38, 0 , 0]) pennystuff(2.5); 
    }  
}

//place where pennies exit (the walls coming out of the cylinders)

module finger() {
    difference() {
        cube([1.75*pennyradius, 120, 0.8*pennyheight]);
        translate ([0.5*1.75*pennyradius, 115, 0]) cylinder(pennyheight, 1.75*pennyradius, 1.75*pennyradius);
    }
}

//pennypusher

module transfinger() {
    translate([-50, 30, 0]) finger();
}

//translated penny pusher to separate it from the rest of the designs

module rod(rodheight) {
    translate([-1.5, -1.5, 0]) {
        cube([3, 3, rodheight]);
    }
}

//rod for keeping servo arm in place when connected to servo

module armholder() {
    difference() {
        translate([outerr - 2, -3.5, 0]) {
            cube([8, 7, 20]);
        }
        cylinder(h, outerr, outerr);
    }
}

//attachment to the claw fingers for easy connection

module holderwrod(depth) {
    difference() {
        armholder();
        translate([outerr + 3, 0, 20 - depth]) {
            rod(depth);
        }
    }
}

//armholder with the hole for the rod

module armextend() {
    cube([8, armlength, 3]);
}

//arm for the servo extention

module transarm() {
    translate([20, 10, 0]) {
        armextend();
    }
}

//servo extention translated for fit

module armwhole(degrees) {
    difference() {
        transarm();
        translate([24, 15, 0]) {
            rotate([0, 0, degrees]) {
                rod(3);
            }
        }
    }
}

//servo extention with angled hole to fit the rod

module rod(rodheight) {
    translate([-2.5, -2.5, 0]) {
        cube([5, 5, rodheight]);
    }
}

//rod for keeping servo arm in place when connected to servo

module armholder() {
    difference() {
        translate([outerr - 3, -5.5, 0]) {
            cube([15, 11, 20]);
        }
        cylinder(h, outerr, outerr);
    }
}

//attachment to the claw fingers for easy connection

module holderwrod(depth) {
    difference() {
        armholder();
        translate([outerr + 6.5, 0, 20 - depth]) {
            rod(depth);
        }
    }
}

//armholder with the hole for the rod

module armextend() {
    cube([12, armlength, 3]);
}

//arm for the servo extention

module transarm() {
    translate([20, 10, 0]) {
        armextend();
    }
}

//servo extention translated for fit

module armwhole(degrees) {
    difference() {
        transarm();
        translate([26, 16, 0]) {
            rotate([0, 0, degrees]) {
                rod(3);
            }
        }
    }
}

//servo extention with angled hole to fit the rod

triangprismed();

transtrianged();

rotatedhalfcyl();

halfcylinder();

entrance();

exit();

//transfinger();

extentionminus();

translate([30, -50, 0]) {
    rod(40);
    holderwrod(10);
    armwhole(19.7760766);
}