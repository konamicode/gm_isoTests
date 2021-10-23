/// @description Insert description here
// You can write your code in this editor

var drawCoord = world_to_screen(x, y, z, objCamera.viewmat, objCamera.projmat);
x = drawCoord[0] * 2/objCamera.window_scale;
y = drawCoord[1] * 2/objCamera.window_scale;

//show_debug_message(drawCoord);

if image_alpha < 1 {
	shader_set(shdr_dynaDither)
	draw_self();
	shader_reset();
}

draw_self();



