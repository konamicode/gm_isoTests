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

if keyboard_check_pressed(vk_space)
{
	rotate = true;
	camRotate = 0
}

if (rotate)
{
	//camRotate  = lerp(camRotate, 180, 0.02);
	camRotate += 1.5;
	heading = camRotate + 45;
	show_debug_message(camRotate);
	if (180 -camRotate <= 1.5)
	{
		camRotate = 0;
		heading = 45;
		rotate = false;
	}
	heading += camRotate;
}

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

if keyboard_check_pressed(vk_escape)
	game_end();
	
UpdateCameraPos(target, camType.ortho);