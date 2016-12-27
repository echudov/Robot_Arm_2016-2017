h = 20;
innerr = 10.5;
outerr = 12.5;
pennyradius = 10;
pennyheight = 1.52;
length1 = 10;

module curvedend() {
    difference() {
        cube([1.85*pennyradius, 100, pennyheight]);
        translate ([0.5*1.85*pennyradius, 95, 0]) cylinder(pennyheight, 1.85*pennyradius, 1.85*pennyradius);
    }
}

curvedend();