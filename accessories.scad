h = 35;
innerr = 11.5;
outerr = 13.5;
pennyradius = 10;
pennyheight = 1.52;
length1 = 10;
motorlength = 24;
servothickness = 12;
armlength = 90;

module rod(rodheight) {
    translate([-1.5, -1.5, 0]) {
        cube([3, 3, rodheight]);
    }
}

module armholder() {
    difference() {
        translate([outerr - 2, -3.5, 0]) {
            cube([8, 7, 20]);
        }
        cylinder(h, outerr, outerr);
    }
}

module holderwrod(depth) {
    difference() {
        armholder();
        translate([outerr + 3, 0, 20 - depth]) {
            rod(depth);
        }
    }
}

module armextend() {
    cube([8, armlength, 3]);
}

module transarm() {
    translate([35, 30, 0]) {
        armextend();
    }
}

module armwhole(degrees) {
    difference() {
        transarm();
        translate([39, 35, 0]) {
            rotate([0, 0, degrees]) {
                rod(3);
            }
        }
    }
}

rod(40);

holderwrod(10);

armwhole(18.6278632);