/// @description Insert description here
// You can write your code in this editor


if image_alpha < 1 {
	shader_set(shdr_dynaDither)

}

if (alarm_get(0) mod 7 == 0) {
	shader_set(shd_hitflash);
}



objCamera.ResetCamera();
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
//draw_text(x, bbox_bottom, string(depth));
objCamera.UpdateCameraPos();

shader_reset();