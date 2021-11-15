/// @description Insert description here
// You can write your code in this editor

//objCamera.UpdateCameraPos();

var old_x = x;
var old_y = y;
//var drawCoord = world_to_screen(x, y, z, objCamera.viewmat, objCamera.projmat);
//var _x = drawCoord[0]/ (1 * objCamera.window_scale);
//var _y = drawCoord[1]/ (1 * objCamera.window_scale);
//x = _x;
//y = _y;

//objCamera.ResetCamera();
matrix_set(matrix_world, matrix_build(x, y, z - sprite_yoffset, -60, 0, 45, 1, 1, 1));
draw_sprite(sprite_index, image_index, 0, 0);
matrix_set(matrix_world, matrix_build_identity());
draw_rectangle_color(bbox_left, bbox_top, bbox_right, bbox_bottom, c_aqua, c_aqua, c_aqua, c_aqua, true);
//x = old_x;
//y = old_y;

