/// @description Insert description here
// You can write your code in this editor

if mouse_wheel_up() {
	pitch += 1;	
	
	show_debug_message(pitch)
}
if mouse_wheel_down() {
	pitch -= 1;	
	show_debug_message(pitch)
}

UpdateCameraPos(target, camType.ortho);

if keyboard_check_pressed(vk_up)
{
	window_scale += 1;
	window_scale = clamp(window_scale, 1, 6);
	SetupGameWindow()	
}

if keyboard_check_pressed(vk_down)
{
	window_scale -= 1;
	window_scale = clamp(window_scale, 1, 6);
	SetupGameWindow()	
}

