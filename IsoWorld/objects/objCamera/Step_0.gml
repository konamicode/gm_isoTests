/// @description Insert description here
// You can write your code in this editor

//if keyboard_check_pressed(vk_up) {
//	global.zoomLvl -= 1;	
//	global.zoomLvl = clamp(global.zoomLvl, 0, array_length(global.zoom) - 1);
//	show_debug_message(global.zoom[global.zoomLvl]);
//}
//if keyboard_check_pressed(vk_down) {
//	global.zoomLvl += 1;	
//	global.zoomLvl = clamp(global.zoomLvl, 0, array_length(global.zoom) - 1);
//	show_debug_message(global.zoom[global.zoomLvl]);
//}

//if keyboard_check(vk_left)
//{
//	heading += 5;
//}

//if keyboard_check(vk_right)
//{
//	heading -= 5;
//}

if keyboard_check_pressed(vk_up)
{
	window_scale += 1;
	window_scale = clamp(window_scale, 1, 6);
	//show_debug_message(window_scale);	
	SetupGameWindow(window_scale)	
}

if keyboard_check_pressed(vk_down)
{
	window_scale -= 1;
	window_scale = clamp(window_scale, 1, 6);
	//show_debug_message(window_scale);
	SetupGameWindow(window_scale)	
}

if mouse_wheel_up() {
	pitch -= 1;	
}

if mouse_wheel_down() {
	pitch += 1;	
}


UpdateCameraPos(target, camType.ortho);