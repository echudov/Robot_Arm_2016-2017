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
steepness = 20;


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

module innerthingies() {
    intersection() {
        rotate([0, -steepness, 0]) {
            translate([0, 0, -20]) {
                intersection() {
                    translate([0, 0, 20]) {
                        rotate([0, steepness, 0]) {
                            translate([-3*innerr, -1*innerr, -1.5]) {
                                cube([6*innerr, 2*innerr, 3]);
                            }
                        }
                    cylinder(h, innerr, innerr);
                    }
                }
            }
        }
        translate([0, -innerr, 0]) {
            cube([innerr, 2*innerr, h]);
        }
    }
}
cylwdiff();

translate([-10, 0, 0]) {
    secondcwd();
}

innerthingies();