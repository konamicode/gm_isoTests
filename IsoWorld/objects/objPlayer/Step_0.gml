/// @description Insert description here
// You can write your code in this editor

var hor = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var vert = keyboard_check(ord("S")) - keyboard_check(ord("W"));

var movdist = point_distance(0, 0, hor, vert);
var movdir = point_direction(0, 0, hor, vert);
var spd = 1.5;
var hsp = hor * spd;
var vsp = vert * spd;

hsp = lengthdir_x(movdist * spd, movdir + 45);
vsp = lengthdir_y(movdist * spd, movdir + 45);


if (place_meeting(x + hsp, y, objEntity)) {
	while (!place_meeting(x + sign(hsp), y, objEntity)) {
		x += sign(hsp);
	}
	var _collide = instance_position(x + hsp, y, objEntity)
	if _collide != noone {
		if _collide.z >= 0
			hsp = 0;
	}
	hsp = 0;
}

if (place_meeting(x, y + vsp,  objEntity)) {
	while (!place_meeting(x, y + sign(vsp), objEntity)) {
		y += sign(vsp);
	}
	var _collide = instance_position(x, y + vsp, objEntity)
	if _collide != noone {
		if _collide.z >= 0
			vsp = 0;
	}
	vsp = 0;
}

var ramp = instance_position(x, y, obj3dRamp);
var tile = instance_position(x, y, obj3dTile);

if (ramp != noone)
{
	var ramp_depth = (ramp.bbox_top - ramp.bbox_bottom);
	var height = y - ramp.bbox_bottom;
	z = height * dtan(30);
} else if tile != noone {
	z = tile.z;
} else
	z = 0;
	

x += hsp;
y += vsp;