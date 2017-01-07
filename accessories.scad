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
    translate([-3, -3, 0]) {
        cube([6, 6, rodheight]);
    }
}

module armholder() {
    difference() {
        translate([outerr - 3, -6.5, 0]) {
            cube([15, 13, 20]);
        }
        cylinder(h, outerr, outerr);
    }
}

module holderwrod(depth) {
    difference() {
        armholder();
        translate([outerr + 6, 0, 20 - depth]) {
            rod(depth);
        }
    }
}

module armextend() {
    cube([14, armlength, 3]);
}

module transarm() {
    translate([20, 10, 0]) {
        armextend();
    }
}

module armwhole(degrees) {
    difference() {
        transarm();
        translate([27, 17, 0]) {
            rotate([0, 0, degrees]) {
                rod(3);
            }
        }
    }
}

translate([0, 20, 3]) {
    rotate ([90, 0, 0]) rod(40);
}

holderwrod(15);

armwhole(20.3441013);