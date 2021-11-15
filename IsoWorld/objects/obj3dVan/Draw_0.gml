/// @description Insert description here
// You can write your code in this editor

objCamera.UpdateCameraPos();

matrix_set(matrix_world, matrix_build(x, y, z, 0, 0, 0, 1, 1, 1));
//vertex_submit(old_buffer, pr_trianglelist, texture);
vertex_submit(vbuffer, pr_trianglelist, texture);
matrix_set(matrix_world, matrix_build_identity());
draw_rectangle_color(bbox_left, bbox_top, bbox_right, bbox_bottom, c_red,c_red, c_red, c_red, true);

for (var i = 0; i < array_length(verts); i++) {
	vert = verts[i];
	var _x = vert[0];
	var _y = vert[1];
	var _z = vert[2];

	var screenCoord = world_to_screen(x, y, z, objCamera.viewmat, objCamera.projmat);
	var _offx = (screenCoord[0] / (1 * objCamera.window_scale))// - screenWidth/2;
	var _offy = (screenCoord[1] / (1 * objCamera.window_scale))//- screenWidth/2;
	
	var drawCoord = world_to_screen(_x, _y, _z, objCamera.viewmat, objCamera.projmat);
	var _newx = drawCoord[0] / (1 * objCamera.window_scale);
	var _newy = drawCoord[1] / (1 * objCamera.window_scale);	
	
	objCamera.ResetCamera();
	
	//matrix_set(matrix_world, matrix_build(-screenWidth/2, -screenHeight/2, 0, 0, 0, 0, 1, 1,1));
	//_offx -= screenWidth/2;
	//_offy -= screenHeight/2;
	//draw_point_color(_newx, _newy, c_red);
	
	//draw_point_color(_offx, _offy, c_aqua);

	//matrix_set(matrix_world, matrix_build_identity());
	
	objCamera.UpdateCameraPos();
}

