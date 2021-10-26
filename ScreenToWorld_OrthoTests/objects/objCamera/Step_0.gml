/// @description Insert description here
// You can write your code in this editor

if mouse_wheel_up() {
	zoom += 0.125;	
	
	show_debug_message(pitch)
}
if mouse_wheel_down() {
	zoom -= .125;	
	show_debug_message(pitch)
}

zoom = clamp(zoom, 0.25, 1);

UpdateCameraPos(target, camType.ortho);

if keyboard_check_pressed(vk_up)
{
	window_scale += 1;
	window_scale = clamp(window_scale, 1, 6);
	show_debug_message(window_scale);	
	SetupGameWindow(window_scale)	
}

if keyboard_check_pressed(vk_down)
{
	window_scale -= 1;
	window_scale = clamp(window_scale, 1, 6);
	show_debug_message(window_scale);
	SetupGameWindow(window_scale)	
}

