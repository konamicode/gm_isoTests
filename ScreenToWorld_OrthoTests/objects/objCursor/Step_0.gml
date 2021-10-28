/// @description Insert description here
// You can write your code in this editor

var ray = screen_to_world(window_mouse_get_x(), window_mouse_get_y(), objCamera.viewmat, objCamera.projmat);

cur_x = ray[0] * ray[5] / -ray[2] + ray[3];
cur_y = ray[1] * ray[5] / -ray[2] + ray[4];


//if keyboard_check_pressed(vk_space)
//{
//	my_order = !my_order;
//}

//if (my_order == order.move)
image_blend = c_white;
//	sprite_index = sprCursorMove;
	
x = mouse_gui_x;
y = mouse_gui_y;

//show_debug_message(string(x) + ", " + string(y));
var _list = ds_list_create();
var _count = instance_position_list(mouse_gui_x, mouse_gui_y, objToon, _list, true);
if _count > 0 {
	var _canTarget = false;
	for (var i = 0; i < ds_list_size(_list); i++) {
		var _toon = _list[| i];
		if (_toon.actorParent.object_index) == objTarget {
		//show_debug_message("Hit 2d");
			_canTarget = true;
		} 

	}
	if  _canTarget 
	{
		sprite_index = sprCursorCrosshair;
		image_blend = c_red;	
	}	else
		sprite_index = sprCursorMove;
}	
else {
	
	image_blend = c_white;	
	//show_debug_message("Hit tile");
	if !position_meeting(cur_x, cur_y, objActor) {
		sprite_index = sprCursorMove;
		//x = (cur_x div 32) * 32;
		//y = (cur_y div 32) * 32;
	}
}

