h = 35; 
innerr = 11.5;
outerr = 13.5;
pennyradius = 10;
pennyheight = 1.52;
length1 = 10;
motorlength = 24;
servothickness = 12;

module hollowcylinder() {
    difference() {
        cylinder(h, outerr, outerr);
        cylinder(h, innerr, innerr);
    }
}

module halfcylinder () {
    intersection() {
        hollowcylinder();
        translate([0,-outerr,0]) {
            cube([outerr,2*outerr,100]);
        }
    }
}

module rotatedhalfcyl() {
    translate([-40, 0, 0]) {
        rotate([0, 0, 180]) {
            halfcylinder();
        }
    }
}

module innerportion() {
    difference() {
        cylinder(2, innerr, innerr);
        cylinder(3, innerr - 6, innerr);
        
    }
}

module innerhalf(){
    intersection() {
        innerportion();
        translate([0, -innerr, 0]) cube([innerr, 2*innerr, 5]);
    }
}

module transinnerhalf() {
    translate([-40, 0, 0]) {
        rotate([0, 0, 180]) innerhalf();
    }
}

module pennystuff(length) {
    difference() {
        translate([outerr - 6, -1.2*pennyradius, 0]) {
                difference() {
                    cube([length*length1, 2.4*pennyradius, h]);
                    translate([0, 0.15*pennyradius, 2]) cube([length*length1, 2.1*pennyradius, h]);
            }
        }
        cylinder(h, outerr, outerr);
    }
}

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

module extention() {
    servoholder();
    translate([-0.5*servothickness, 22 + outerr, 0]) {
        cube([3 + servothickness, motorlength + 6, h]);
    }
}

module extentionminus() {
    difference() {
        extention();
        translate([-0.5*servothickness, 22 + outerr + 3, 0]) {
            cube([servothickness, motorlength, h]);
        }
    }
}

module entrance() {
    translate([-2, 0, 0]) pennystuff(2);
}

module exit() {
    rotate([0, 0, 180]) {
        translate([38, 0 , 0]) pennystuff(2.5); 
    }  
}

module finger() {
    difference() {
        cube([1.75*pennyradius, 120, 0.8*pennyheight]);
        translate ([0.5*1.75*pennyradius, 115, 0]) cylinder(pennyheight, 1.75*pennyradius, 1.75*pennyradius);
    }
}

module transfinger() {
    translate([-50, 30, 0]) finger();
}

module joint(degrees) {
    translate([-12.5 - 40, 0, 0]) {
        rotate([0, 0, -degrees]) {
            difference() {
                union() {
                    cube([3, 45.26, h + 12]);
                    translate([-1.5, 45.26 - 15, 0]) {
                        cube([6, 20, h + 12]);
                    }
                }
                translate([1.5, 45.26 , 0]) {
                    cylinder(h + 12, 2, 2);
                }
            }
        }
    }
}

module exitandcyl() {
    translate([-40, 0, 0]) {
        translate([-2*outerr, -outerr, 0]) cylinder(h + 12, outerr, outerr);
        translate([-2.5*length1, -1.2*pennyradius, 0]) cube([2.5*length1, 2.4*pennyradius, h + 12]);
    }
}
module jointminus(degrees) {
    difference() {
        joint(degrees);
        exitandcyl();
    }
}

module extracylinder() {
    translate([0, 39.5, 0]) {
        difference() {
            cube([9, 8, 15]);
            difference() {
                translate([0, 4, 0]) {
                    cylinder(15, 4, 4);
                }
            }
        }
        difference() {
            translate([0, 4, 0]) {
                cylinder(15, 4, 4);
            }
            translate([0, 4, 0]) {
                cylinder(15, 2, 2);
            }
        }
    }
}

innerhalf();

transinnerhalf();

rotatedhalfcyl();

halfcylinder();

entrance();

exit();

//transfinger();

extentionminus(); 

jointminus(16.0323394);

extracylinder();