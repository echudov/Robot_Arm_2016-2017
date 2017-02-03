h = 120; 
innerr = 11.5;
outerr = 14.5;
pennyradius = 10;
pennyheight = 1.52;
length1 = 10;
motorlength = 24;
servothickness = 12;
hingewidth = 4.7625;
hingeheight = hingewidth*5/3;
railheight = 3;
railedge = 1.5;

$fn = 400;

module hollowcyl() {
    difference() {
        cylinder(h, outerr, outerr);
        cylinder(h, innerr, innerr);
    }
}

//creates a hollow halfcylinder with height h and hollow inside radius of innerr

module halfcyl() {
    difference() {
        hollowcyl();
        translate([-outerr, -outerr, 0]) {
            cube([outerr, 2*outerr, h]);
        }
    }
}

//halves the hollow cylinder for splitting apart

module innerfingers() {
    halfcyl();
    difference() {
        difference() {
            cylinder(2, innerr, innerr);
            cylinder(3, innerr - 6, innerr);
        }
        translate([-outerr, -outerr, 0]) {
            cube([outerr, 2*outerr, h]);
        }
    }
}

//creates the fingers for grabbing pennies
//adds the halfcylinder

module innerfingers2() {
    translate([-10, 0, 0]) {
        rotate([0, 0, 180]) {
            innerfingers();
        }
    }
}

//copies innerfingers() and rotates it 180 degrees to combine to a full cylinder

module rotationalholder() {
    translate([40, 0, 0]) {
        difference() {           
            translate([-13, outerr - 6, 0]) {
                cube([26, 10, 26]);
            }
            cylinder(h, outerr, outerr);
        }
    }
}

//the connection between the flipping over servo and the claw

module hingeholder(side) {
    translate([30, 30, 0]) {
        mirror([side, 0, 0]) {
            difference() {
                translate([0, outerr - 6, 0]) {
                    cube([0.5*hingewidth, 8, hingeheight]);
                }
                cylinder(h, outerr, outerr);
            }
        }
    }
}

//little gluable mounts for the hinge
//link: http://www.micromark.com/solid-brass-miniature-flush-hinges-pkg-of-6,6694.html

module servoholder() {
    difference() {
        translate([0, outerr- 7, 0]) {
            cube([motorlength - 10, 9, 20]);
        }
        cylinder(h, outerr, outerr);
    }
}

//gluable mount for the servo
//not full size to allow for extra useability



module extrudingthingy() {
    difference() {
        difference() {
            cylinder(railheight, outerr + 2*railedge + 0.5*servothickness + 1.2*pennyradius + 3, outerr + 2*railedge + 0.5*servothickness + 1.2*pennyradius + 3, $fn = 400);
            cylinder(railheight, outerr + 0.5*servothickness - 1.2*pennyradius - 3, outerr + 0.5*servothickness - 1.2*pennyradius - 3, $fn = 400);
        }
        translate([0, 0, 0.5*railheight]) {
            difference() {
                cylinder(0.5*railheight, outerr + railedge + 0.5*servothickness + 1.1*pennyradius + 3, outerr + railedge + 0.5*servothickness + 1.1*pennyradius + 3, $fn = 400);
                cylinder(0.5*railheight, outerr + railedge + 0.5*servothickness - 1.1*pennyradius - 3, outerr + railedge + 0.5*servothickness - 1.1*pennyradius - 3, $fn = 400);
            }
        }
    }
}

//creates the curved track/rails for the curved rod to follow

module hextrude() {
    translate([0, outerr + railedge + 0.5*servothickness, 0]) {
        intersection() {
            difference() {
                extrudingthingy();
                translate([-(outerr + 0.55*pennyradius - 2), -1.05*pennyradius - 2, 0]) {
                    cylinder(0.375*2*railheight, 1.05*pennyradius, 1.05*pennyradius);
                }
            }
            translate([0, -(outerr + 2*railedge + 0.5*servothickness + pennyradius + 6), 0]) {
                cube([(outerr + 2*railedge + 0.5*servothickness + 1.2*pennyradius + 3), 2*(outerr + 2*railedge + 0.5*servothickness + 1.2*pennyradius + 6), railheight]);
            }
        }
    }
}

//halves the extruder so its not a full circle
//moves it to the right place for it to do a demo (centers) and remove inner cylinder

module modifiedextrude() {
    translate([0, outerr + railedge + 0.5*servothickness, 0]) {
        intersection() {
            difference() {
                extrudingthingy();
                translate([-(outerr + 0.55*pennyradius - 2), -1.05*pennyradius - 2, 0]) {
                    cylinder(0.375*2*railheight, 1.05*pennyradius, 1.05*pennyradius);
                }
            }
            translate([0, -(outerr + 2*railedge + 0.5*servothickness + pennyradius + 6), 0]) {
                cube([(outerr + 2*railedge + 0.5*servothickness + 1.2*pennyradius + 3), outerr + 2*railedge + 0.5*servothickness + 1.2*pennyradius + 6, railheight]);
            }
        }
    }
}

module diffextrude(direction) {
    mirror([0, 0, direction]) {
        difference() {
            modifiedextrude();
            cylinder(h, outerr, outerr);
        }
    }
}

module diffextrudetwo(direction) {
    mirror([0, 0, direction]) {
        difference() {
            difference() {
                hextrude();
                cylinder(h, outerr, outerr);
            }
            translate([(outerr + 0.55*pennyradius + railedge), outerr + railedge + 0.5*servothickness, 0]) {
                cylinder(0.375*2*railheight, 1.05*pennyradius, 1.05*pennyradius);
            }
        }
    }
}

module holeextrude(direction) {
    mirror([0, 0, direction]) {
        difference() {
            hextrude();
            cylinder(h, outerr, outerr);
        }
    }    
}

//removes the inner cylinder so it does not pass through
//also allows for flipping around

module leftextrude(direction) {
    translate([-10, 0, 0]) {
        mirror([1, 0, 0]) {
            diffextrude(direction);
        }
    }
}

//mirrors it over to the other halfcylinder piece

module leftextrudetwo(direction) {
    translate([-10, 0, 0]) {
        mirror([1, 0, 0]) {
            diffextrudetwo(direction);
        }
    }
}

module extrudedemo() {
    translate([0, 0, 75 + railheight]) {
        diffextrude(1);
        leftextrude(1);
    }
    translate([0, 0, 75 - railheight]) {
        mirror([0, 0, 1]) {
            diffextrude(1);
            leftextrude(1);
        }
    }
}

//demo of how the extruder will work
//for the purpose of demonstration only 
//NOT FOR PRINTING WONT PRINT

module pusher() {
    intersection() {
        difference() {
            cylinder(0.375*2*railheight, outerr + railedge + 0.5*servothickness + 1.1*pennyradius + 2, outerr + railedge + 0.5*servothickness + 1.1*pennyradius + 2, $fn = 400);
            cylinder(0.375*2*railheight, outerr + railedge + 0.5*servothickness - 1.1*pennyradius - 2, outerr + railedge + 0.5*servothickness - 1.1*pennyradius - 2, $fn = 400);
        }
        translate([-(outerr + railedge + 0.5*servothickness + 1.1*pennyradius + 2), -(outerr + railedge + 0.5*servothickness + 1.1*pennyradius + 2), 0]) {
            cube([2*(outerr + railedge + 0.5*servothickness + 1.1*pennyradius + 2), outerr + railedge + 0.5*servothickness + 1.1*pennyradius + 2, 0.375*2*railheight]);
        } 
    }
}

//creates the pusher

module holepusher() {
    difference() {
        pusher();
        translate([outerr + 0.55*pennyradius - 2, -1.05*pennyradius - 2, 0]) {
            cylinder(0.375*2*railheight, 1.05*pennyradius, 1.05*pennyradius);
        }
    }
}

module fillerhalf() {
    difference() {
        cylinder(3, innerr - 0.05, innerr - 0.05);
        translate([0, -(innerr - 0.05), 0]) {
            cube([innerr - 0.05, 2*(innerr - 0.05), 3]);
        }
    }
}

module filler() {
    fillerhalf();
    mirror([1, 0, 0]) {
        translate([-10, 0, 0]) {
            fillerhalf();
        }
    }
}

module servoattach() {
    difference() {
        translate([outerr - 3, -5, 0]) {
            cube([15, 10, 3]);
        }
        cylinder(h, outerr, outerr);
    }
}

//creates the filler part for keeping pennies in

rotationalholder();

innerfingers();

innerfingers2();

//hingeholder(1);

//translate([4, 0, 0]) hingeholder(0);

//translate([-20, 0, 0]) {
//    hingeholder(1);
//    translate([4, 0, 0]) hingeholder(0);
//}

translate([20, 25, 0]) servoholder();

//extrudedemo();

//NOT FOR PRINTING 

translate([-60, 0, 0]) {
    filler();
}

translate([45, 65, 0]) {
    leftextrude(0);
    diffextrude(0);
}

//translate([-45, 65, 0]) {
//    leftextrude(0);
//    diffextrude(0);
//}

translate([-135, 65, 0]) {
    leftextrudetwo(0);
    holeextrude(0);
}

translate([0, -30, 0]) {
    holepusher();
}

translate([-20, 25, 0]) {
    mirror([1, 0, 0]) {
        servoholder();
    }
}

translate([20, 0, 0]) {
    servoattach();
}

//for second servo