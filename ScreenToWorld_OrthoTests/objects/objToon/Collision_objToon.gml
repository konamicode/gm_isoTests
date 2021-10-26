/// @description Insert description here
// You can write your code in this editor


if (depth > other.depth  && actorParent.object_index == objPlayer) {
	other.image_alpha = 0.5;
}

//check if other is a bullet and it's actorParent is not my actorParent
var _bulletActor = other.actorParent;

if (_bulletActor.object_index == objBullet) &&  (_bulletActor.creator != actorParent.id) {

	var _dx = lengthdir_x(_bulletActor.spd, _bulletActor.movedir);
	var _dy = lengthdir_y(_bulletActor.spd, _bulletActor.movedir);
	if position_meeting(_bulletActor.x, _bulletActor.y, actorParent.id) || position_meeting(_bulletActor.x + _dx, _bulletActor.y + _dy, actorParent.id)
	{
		if (rootType == root.actor)
		{		
			alarm[0] = 20;		
		}		
		image_speed = 1;
		show_debug_message("collide!");
		instance_destroy(_bulletActor);
		instance_destroy(other);
	}
}
