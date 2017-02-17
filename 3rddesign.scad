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
steepness = 17.5;
$fn = 500;


module halfhollowcyl() {
    intersection() {
        difference() {
            cylinder(h, outerr, outerr);
            cylinder(h, innerr, innerr);
        }
        translate([0, -outerr, 0]) {
            cube([outerr, 2*outerr, h]);
        }
    }
}

module secondhhc() {
    translate([0, 0, 0]) {
        mirror([1, 0, 0]) {
            halfhollowcyl();
        }
    }
}

module cylwdiff() {
    difference() {
        halfhollowcyl();
        translate([0, 0, h + 2*outerr]) {
            rotate([0, steepness, 0]) {
                translate([-3*outerr, -3*outerr, -3*outerr]) {
                    cube([6*outerr, 6*outerr, 6*outerr]);
                }
            }
        }
    }
}

module secondcwd() {
    difference() {
        secondhhc();
        translate([0, 0, h + 2*outerr]) {
            rotate([0, steepness, 0]) {
                translate([-3*outerr, -3*outerr, -3*outerr]) {
                    cube([6*outerr, 6*outerr, 6*outerr]);
                }
            }
        }
    }
}

module support() {
    intersection() {
        difference() {
            cylinder(1.5, outerr + 10, outerr + 10);
            cylinder(1.5, outerr, outerr);
        }
        translate([0, -(outerr + 10), 0]) {
            cube([outerr + 10, 2*(outerr + 10), 1.5]);
        }
    }
}

module innerthingy1() {
    intersection() {
        rotate([0, -steepness, 0]) {
            translate([0, 0, -20]) {
                intersection() {
                    translate([0, 0, 20]) {
                        rotate([0, steepness, 0]) {
                            translate([-4*innerr, -1*innerr, -1.5]) {
                                cube([8*innerr, 2*innerr, 2]);
                            }
                        }
                    }
                    cylinder(h, innerr - 0.2, innerr - 0.2);
                }
            }
        }
        translate([0, -innerr, -3]) {
            cube([innerr + 2, 2*innerr, h]);
        }
    }
}

module innerthingy2() {
    intersection() {
        rotate([0, -steepness, 0]) {
            translate([0, 0, -20]) {
                intersection() {
                    translate([0, 0, 20]) {
                        rotate([0, steepness, 0]) {
                            translate([-4*innerr, -1*innerr, -1.5]) {
                                cube([8*innerr, 2*innerr, 2]);
                            }
                        }
                    }
                    cylinder(h, innerr - 0.2, innerr - 0.2 );
                }
            }
        }
        mirror([1, 0, 0]) {    
            translate([0, -innerr, -3]) {
                cube([innerr + 2, 2*innerr, h]);
            }
        }
    }
}

module servoholder() {
    difference() {
        translate([-outerr, 0, 0]) {
            union() {
                cube([outerr - 3, motorlength + outerr + 3, 3]);
                cube([outerr - 3, outerr + 2, 6]);
            }
        }
        cylinder(h, outerr, outerr);
    }
}

module flatmaker() {
    difference() {
        translate([0, -1.15*pennyradius, 0]) {
            cube([outerr + 2, 2.3*pennyradius, 10]);
        }
        cylinder(h, outerr, outerr); 
    }
}

module servoarmextention() {
    linear_extrude(height=3, center = true, convexity = 10, twist = 0) {
        translate([-2*pennyheight, 0, 0]) {
            square([4*pennyheight, 2.3*pennyradius]);
        }
        translate([-2, 0, 0]) {
            square([4, 50]);
        }
    }
}

//cylwdiff();

//support();

translate([-10, 0, 0]) {    
    secondcwd(); 
    mirror([1, 0, 0]) {
        support();
    }
}

//translate([30, 0, 1.5]) {
//    innerthingy1();
//}

//translate([-45, 0, 1.5]) {
//    innerthingy2();
//}

//translate([0, 30, 0]) {
//    servoholder();
//}

//translate([0, 40, 0]) {
//    flatmaker();
//}

//translate([30, 15, 1.5]) {
//   servoarmextention();
//}