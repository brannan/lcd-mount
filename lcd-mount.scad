$fn = 32;

thickness = 2;

hole_dia = 3.25;

// Center to center spacing 
hole_spacing = 49.5;

// make bracket width wide enough for 2mm space around holes with flattened sides
width = hole_dia + 4 + 1;

// board height
board_height = 55;

// extrusion width
extrusion_width = 15;

// mount position
mount_pos = 30;

function hole_offset_x() = hole_dia / 2 + (board_height - hole_spacing - hole_dia) / 2;

//%translate([20, -7.5, 0]) cube([7.5,7.5,7.5]);

rotate([-90,0,0]) translate([0,-width/2,0])
difference(){
	make_bracket();
	translate([0,-5-width/2+.5,-30])
		cube([board_height, 5, 60]);
	translate([0,width/2-.5,-30])
			cube([board_height, 5, 60]);
}


module make_bracket(){
	difference(){
		union(){
			board_backing();
			board_supports();
			make_extrusion_mount();
		}
		
		holes();
	}
}

module make_extrusion_mount(){
	translate([mount_pos,-width/2, -extrusion_width]){
		difference(){
			translate([0, 0, thickness/2])
			union(){
				cube([thickness, width, extrusion_width - thickness/2]);
				translate([thickness/2,0,0]) rotate([-90,0,0])
					cylinder(r=thickness/2, h=width);
			}
			
	
			translate([-1, width/2,extrusion_width/2])
			rotate([0,90,0])
			cylinder(h=20, r= hole_dia/2);
		}
		
	}
	
}

module holes(){
	translate([hole_offset_x(), 0,-1]){
		cylinder(h=20, r= hole_dia/2);
		translate([49.5,0,0])  cylinder(h=20, r= hole_dia/2);
	}
}

module board_supports(){
	translate([hole_offset_x(), 0,-0.05]){
		cylinder(h=6, r= width/2);
		translate([49.5,0,0])  cylinder(h=6, r= width/2);
	}
}

module board_backing(){
	translate([width/2, -width/2,0])
	cube([board_height - width, width, thickness]);
}