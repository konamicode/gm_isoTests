/// @description Insert description here
// You can write your code in this editor
draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
var drawCoord = world_to_screen(x, y, z, objCamera.viewmat, objCamera.projmat);
var _newx = drawCoord[0] / (1 * objCamera.window_scale);
var _newy = drawCoord[1] / (1 * objCamera.window_scale);	
objCamera.ResetCamera();
matrix_set(matrix_world, matrix_build(_newx, _newy, z - sprite_yoffset, 0, 0, 0, 1, 1, 1));
draw_sprite_ext(sprite_index, image_index, 0, 0, 1, 1, image_angle, image_blend, image_alpha);

matrix_set(matrix_world, matrix_build_identity());

//draw_text(x, y + 100, "billboarded sprite");

objCamera.UpdateCameraPos();
