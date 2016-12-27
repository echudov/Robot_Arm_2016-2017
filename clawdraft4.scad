h = 20;
innerr = 10.5;
outerr = 12.5;
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
        translate([outerr - 6, -1.15*pennyradius, 0]) {
                difference() {
                    cube([length*length1, 2.3*pennyradius, 2*pennyheight + 1]);
                    translate([0, 0.15*pennyradius, 2]) cube([length*length1, 2*pennyradius, 5]);
                    
                }
            }
        cylinder(h, outerr, outerr);
    }
}

module entrance() {
    translate([-2, 0, 0]) pennystuff(1);
}

module exit() {
    rotate([0, 0, 180]) {
        translate([38, 0 , 0]) pennystuff(1.3); 
    }  
}

innerhalf();

transinnerhalf();

rotatedhalfcyl();

halfcylinder();

entrance();

exit();
