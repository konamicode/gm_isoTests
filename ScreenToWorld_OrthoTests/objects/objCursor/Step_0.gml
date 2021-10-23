/// @description Insert description here
// You can write your code in this editor


if keyboard_check_pressed(vk_space)
{
	my_order = !my_order;
}

if (my_order == order.move)
	image_blend = c_white;
	sprite_index = sprCursorMove;
	
if (my_order == order.attack) {
	sprite_index = sprCursorCrosshair;
	if position_meeting(mouse_gui_x, mouse_gui_y, objToon)
	{
		image_blend = c_red;
	}
	else
		image_blend = c_white;	
}
	
x = mouse_gui_x;
y = mouse_gui_y;