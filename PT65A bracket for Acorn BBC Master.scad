/************************************************************************
	PT65A bracket for Acorn BBC Master.scad
    
	3D Printable PT65A PSU Mounting bracket for the Acorn BBC Master
    Copyright (C) 2019 Simon Inns
	    
    This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.
    
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    
    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
	
    Email: simon.inns@gmail.com
    
************************************************************************/

// Set this to 10 for development and 30 for producing the final
// shape for export to STL
$fn=30;

// Base plate is 165mm x 85mm (same size as original PSU)
// Note: This is the PCB size of the original power supply
basePlate_width = 85;
basePlate_length = 165;
basePlate_thickness = 2;

// Base plate screw holes are 157mm apart lengthwise and
// 75mm apart crosswise
basePlate_screwDistanceWidth = 75;
basePlate_screwDistanceLength = 157;

// Base plate screw holes are 4mm diameter
basePlate_screwHoleRadius = 4 / 2;

// PT65A is 127 x 76mm wide
pt65a_width = 76;
pt65a_length = 127;

// PT65A screw holes are 115.8mm apart lengthwise and
// 68.4mm apart crosswise
pt65a_screwDistanceWidth = 64.8;
pt65a_screwDistanceLength = 115.8;

// PT65A screw holes are 4mm diameter
pt65a_screwHoleRadius = 4 / 2;

// PT65A standoffs are 6mm diameter
pt65a_standoffRadius = 6 / 2;

// PT65A standoffs are 3mm high
pt65a_standoffHeight = 3;

// Text to include on the bracket
bracket_text = "www.waitingforfriday.com";
bracket_textSize = 3;

// Module to draw a rounded rectange style cube
module roundedCube(length, width, height, radius) {
    // Range check the radius to make sure it is in bounds of the
    // shape dimensions
    radius1 = (radius > width) ? width : radius;
    radius2 = (radius1 > height) ? height : radius1;
    
    translate([0, 0, height / 2]) {
        hull() {
            translate([length - radius2, width - radius2, 0]) {
                cylinder(r = radius2, h = height, center= true);
            }
            
            translate([length - radius2, radius2, 0]) {
                cylinder(r = radius2, h = height, center= true);
            }
            
            translate([radius2, width - radius2, 0]) {
                cylinder(r = radius2, h = height, center= true);
            }
            
            translate([radius2, radius2, 0]) {
                cylinder(r = radius2, h = height, center= true);
            }
        }
    }
}

// Module to draw a bracket
module bracket() {
    difference() {
        union() {
            // Draw the base plate (same dimensions as the original PSU)
            roundedCube(basePlate_width, 26, basePlate_thickness, 2);
            
            // 2 standoffs for mounting the PT65A to the base plate
            translate([(basePlate_width - pt65a_width) / 2,
                (basePlate_length - pt65a_length) / 2, 0]) {
                // Standoff 1
                translate([(pt65a_width - pt65a_screwDistanceWidth) / 2,
                    (pt65a_length - pt65a_screwDistanceLength) / 2, 0]) 
                {
                    cylinder(h = basePlate_thickness, r = pt65a_screwHoleRadius + 8);
                }
                
                // Standoff 2
                translate([pt65a_width - ((pt65a_width - pt65a_screwDistanceWidth) / 2),
                    (pt65a_length - pt65a_screwDistanceLength) / 2, 0]) 
                {
                    cylinder(h = basePlate_thickness, r = pt65a_screwHoleRadius + 8);
                }
            }
        }
        
        // 2 Screw holes for attaching the base plate to the case of the original PSU
        // Mounting screw hole 1 (4mm diameter) - case
        translate([(basePlate_width - basePlate_screwDistanceWidth) / 2,
            (basePlate_length - basePlate_screwDistanceLength) / 2, 0]) 
        {
            cylinder(h = basePlate_thickness, r = basePlate_screwHoleRadius);
        }
        
        // Mounting screw hole 2 (4mm diameter) - case
        translate([basePlate_width - ((basePlate_width - basePlate_screwDistanceWidth) / 2),
            (basePlate_length - basePlate_screwDistanceLength) / 2, 0]) 
        {
            cylinder(h = basePlate_thickness, r = basePlate_screwHoleRadius);
        }
        
        // 2 Screw holes for mounting the PT65A to the base plate
        translate([(basePlate_width - pt65a_width) / 2,
            (basePlate_length - pt65a_length) / 2, 0]) {
            // Mounting screw hole 1 (4mm diameter) - PT65A
            translate([(pt65a_width - pt65a_screwDistanceWidth) / 2,
                (pt65a_length - pt65a_screwDistanceLength) / 2, 0]) 
            {
                cylinder(h = basePlate_thickness, r = pt65a_screwHoleRadius);
            }
            
            // Mounting screw hole 2 (4mm diameter) - PT65A
            translate([pt65a_width - ((pt65a_width - pt65a_screwDistanceWidth) / 2),
                (pt65a_length - pt65a_screwDistanceLength) / 2, 0]) 
            {
                cylinder(h = basePlate_thickness, r = pt65a_screwHoleRadius);
            }
        }

        // Cut outs for clearance and to save some plastic
        translate([10, -10, 0]) {
            roundedCube((basePlate_width - 20), 20, basePlate_thickness, 2);
        }
        
        translate([20, 30-10, 0]) {
            roundedCube((basePlate_width - 40), 10, basePlate_thickness, 2);
        }

        // Emboss some text
        translate([basePlate_width / 2, 15, basePlate_thickness - 0.5]) {
            linear_extrude(height = 0.5) {
                text(bracket_text, font = "Liberation Sans", size = bracket_textSize, valign = "center", halign = "center");
            }
        }
    }

    // 2 standoffs for mounting the PT65A to the base plate
    translate([(basePlate_width - pt65a_width) / 2,
        (basePlate_length - pt65a_length) / 2, 0]) {
            
        // Standoff 1
        translate([(pt65a_width - pt65a_screwDistanceWidth) / 2,
            (pt65a_length - pt65a_screwDistanceLength) / 2, 0]) 
        {
            difference() {
                cylinder(h = pt65a_standoffHeight + basePlate_thickness, r1 = pt65a_standoffRadius + 2,
                    r2 = pt65a_standoffRadius);
                cylinder(h = pt65a_standoffHeight + basePlate_thickness, r = pt65a_screwHoleRadius);
            }
        }
        
        // Standoff 2
        translate([pt65a_width - ((pt65a_width - pt65a_screwDistanceWidth) / 2),
            (pt65a_length - pt65a_screwDistanceLength) / 2, 0]) 
        {
            difference() {
                cylinder(h = pt65a_standoffHeight + basePlate_thickness, r1 = pt65a_standoffRadius + 2,
                    r2 = pt65a_standoffRadius);
                cylinder(h = pt65a_standoffHeight + basePlate_thickness, r = pt65a_screwHoleRadius);
            }
        }
    }
}

// Main function

// Draw the first bracket
translate([0, 1, 0]) {
    difference() {
        bracket(); 
    }
}

// Draw the second bracket
translate([basePlate_width, -1, 0]) {
    difference() {
        rotate([0, 0, 180]) bracket(); 
    }
}

