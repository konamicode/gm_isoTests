/// @description Insert description here
// You can write your code in this editor

objCamera.UpdateCameraPos();

matrix_set(matrix_world, matrix_build(x, y, z, 0, 0, 0, 1, 1, 1));

vertex_submit(vbuffer, pr_trianglelist, texture);
draw_point_colour(x, y, c_fuchsia);
matrix_set(matrix_world, matrix_build_identity());
draw_rectangle_color(bbox_left, bbox_top, bbox_right, bbox_bottom, c_red,c_red, c_red, c_red, true);

for (var i = 0; i < array_length(verts); i++) {
	vert = verts[i];
	var _x = vert[0];
	var _y = vert[1];
	var _z = vert[2];

	var screenCoord = world_to_screen(x, y, z, objCamera.viewmat, objCamera.projmat);
	var _offx = (screenCoord[0] / (1 * objCamera.window_scale));
	var _offy = (screenCoord[1] / (1 * objCamera.window_scale));
	
	var drawCoord = world_to_screen(_x, _y, _z, objCamera.viewmat, objCamera.projmat);
	var _newx = (drawCoord[0] / (1 * objCamera.window_scale) - 1);
	var _newy = (drawCoord[1] / (1 * objCamera.window_scale) - 1);	
	
	objCamera.ResetCamera();
	

	//draw_point_color(_newx, _newy, c_red);
	
	//draw_point_color(_offx, _offy, c_aqua);

	
	objCamera.UpdateCameraPos();
}

draw_set_color(c_yellow);
//draw_line(x, y, width_x, width_y);
//draw_line(x, y, x, -depth_x);
draw_set_color(c_white);
//	objCamera.ResetCamera();
//	draw_set_halign(fa_left)
//draw_text(x+ 60, y + 100, "mesh projection");

objCamera.UpdateCameraPos();
	
