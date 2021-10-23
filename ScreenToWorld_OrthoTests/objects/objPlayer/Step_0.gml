/// @description Insert description here
// You can write your code in this editor

var ray = screen_to_world(window_mouse_get_x(), window_mouse_get_y(), objCamera.viewmat, objCamera.projmat);

cur_x = ray[0] * ray[5] / -ray[2] + ray[3];
cur_y = ray[1] * ray[5] / -ray[2] + ray[4];



if position_meeting(cur_x, cur_y, objActor)
{
	if position_meeting(cur_x, cur_y, id)
		draw_color = c_aqua;
	else
		draw_color = c_red;
}
else 
	draw_color = c_green;

if mouse_check_button_pressed(mb_left)
{

	if !position_meeting(cur_x, cur_y, objActor) && (objCursor.my_order == order.move)
	{

		new_x = (cur_x div 32 * 32) + sprite_get_xoffset(sprite_index);
		new_y = (cur_y div 32 * 32) + sprite_get_yoffset(sprite_index);
	
		///grid movement
		//mp_grid_add_instances(global.grid, objObstacle, true);
		with objActor {
			if (id != other.id)
				mp_grid_add_instances(global.grid, id, false);
		}
		if mp_grid_path(global.grid, my_path, x, y, new_x, new_y, true)
			path_start(my_path, 4, path_action_stop, true);
	}
	

	
	if objCursor.my_order == order.attack {
		//get direction of cursor
		var aimDirection = point_direction(x, y, cur_x, cur_y);
		//make bullet and move it in the direction of the cursor
		var bullet = instance_create_layer(x, y, "Instances", objBullet);
		bullet.movedir = aimDirection;
	}

	
}

if point_distance(x, y, new_x, new_y) > 1
{
	//old movement code
	//x = lerp(x, new_x, 0.05);
	//y = lerp(y, new_y, 0.05);
	
	
	var movedir = point_direction(x, y, new_x, new_y);
	
	if  between(movedir, 45, 225 )
		my_toon.sprite_index = sprPlayerBack;
	else
		my_toon.sprite_index = sprPlayer;
		
	if between(movedir, 135, 315 ) 
		my_toon.image_xscale = -1;
	else
		my_toon.image_xscale = 1;
}
else {
	x = new_x;
	y = new_y;
	my_toon.sprite_index = sprPlayer;	
	my_toon.image_xscale = 1;	
}

if keyboard_check_pressed(ord("1"))
	room_goto(Room1);

if keyboard_check_pressed(ord("2"))
	room_goto(Room2);
	
if keyboard_check_pressed(ord("3"))
	room_goto(Room3);
	
if keyboard_check_pressed(vk_escape)
	game_end();