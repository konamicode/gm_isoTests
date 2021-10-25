/// @description Insert description here
// You can write your code in this editor

if (sprite_index == sprTarget) {
image_speed = 0;
image_index = 0;
}

if (sprite_index == spr_bullet)
{
	instance_destroy(actorParent);
}