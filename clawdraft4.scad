h = 20;
innerr = 11.5;
outerr = 13.5;
pennyradius = 10;
pennyheight = 1.52;
length1 = 10;

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

module entrance() {
    translate([-2, 0, 0]) pennystuff(2);
}

module exit() {
    rotate([0, 0, 180]) {
        translate([38, 0 , 0]) pennystuff(3); 
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

innerhalf();

transinnerhalf();

rotatedhalfcyl();

halfcylinder();

entrance();

exit();

transfinger();