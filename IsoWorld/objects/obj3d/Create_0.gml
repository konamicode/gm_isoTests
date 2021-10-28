/// @description Insert description here
// You can write your code in this editor

gpu_set_ztestenable(true);
gpu_set_alphatestenable(true)
gpu_set_zwriteenable(true);


bitmask = 0;
for (var i = 0; i <= 3 ; i++)
{
	var dx = lengthdir_x(32, i * 90);
	var dy = lengthdir_y(32, i * 90);
	if position_meeting(x + dx, y + dy, obj3d)
	{
		bitmask = bitmask | power(2, i);
	}
}


#region vertex format setup
// Vertex format: data must go into vertex buffers in the order defined by this
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_texcoord();
vertex_format_add_color();
global.vertex_format = vertex_format_end();
#endregion

vbuffer = vertex_create_buffer();
vertex_begin(vbuffer, global.vertex_format);

#region create the plane
vbuffer = vertex_create_buffer();
vertex_begin(vbuffer, global.vertex_format);
texture = sprite_get_texture(sprite_index, 0);


var color = c_white;

var alpha = 1;


var start_x = -16;
var start_y = -16;

var width_x = 16 ;
var width_y = 16; 

var z_height = -32;
z = layer_get_depth(layer);
texture = sprite_get_texture(sprite_index, 0);
var uvs = sprite_get_uvs(sprite_index, 0);
var tex_left = uvs[0];
var tex_top = uvs[1];
var tex_right = uvs[2];
var tex_bottom = uvs[3];


switch(bitmask) {

	case 1:
		vertex_add_point(vbuffer, start_x, width_y, z_height,  0, 0, 1, tex_left, tex_top, color, alpha);
		vertex_add_point(vbuffer, width_x, width_y, z_height,  0, 0, 1, tex_right, tex_top, color, alpha);
		vertex_add_point(vbuffer, start_x, width_y, z, 		   0, 0, 1, tex_left, tex_bottom, color, alpha);
		vertex_add_point(vbuffer, start_x, width_y, z, 		   0, 0, 1, tex_left, tex_bottom, color, alpha);
		vertex_add_point(vbuffer, width_x, width_y, z_height,  0, 0, 1, tex_right, tex_top, color, alpha);
		vertex_add_point(vbuffer, width_x, width_y, z, 		   0, 0, 1, tex_right, tex_bottom, color, alpha);
	break;
	case 0:
	case 4:
		vertex_add_point(vbuffer, start_x, width_y, z_height,  0, 0, 1, tex_left, tex_top, color, alpha);
		vertex_add_point(vbuffer, width_x, width_y, z_height,  0, 0, 1, tex_right, tex_top, color, alpha);
		vertex_add_point(vbuffer, start_x, width_y, z, 		   0, 0, 1, tex_left, tex_bottom, color, alpha);
		vertex_add_point(vbuffer, start_x, width_y, z, 		   0, 0, 1, tex_left, tex_bottom, color, alpha);
		vertex_add_point(vbuffer, width_x, width_y, z_height,  0, 0, 1, tex_right, tex_top, color, alpha);
		vertex_add_point(vbuffer, width_x, width_y, z, 		   0, 0, 1, tex_right, tex_bottom, color, alpha);
		vertex_add_point(vbuffer, width_x, width_y, z_height,  0, 0, 1, tex_left, tex_top, color, alpha);
		vertex_add_point(vbuffer, width_x, start_y, z_height,  0, 0, 1, tex_right, tex_top, color, alpha);
		vertex_add_point(vbuffer, width_x, width_y, z, 		   0, 0, 1, tex_left, tex_bottom, color, alpha);
		vertex_add_point(vbuffer, width_x, width_y, z, 		   0, 0, 1, tex_left, tex_bottom, color, alpha);
		vertex_add_point(vbuffer, width_x, start_y, z_height,  0, 0, 1, tex_right, tex_top, color, alpha);
		vertex_add_point(vbuffer, width_x, start_y, z, 		   0, 0, 1, tex_right, tex_bottom, color, alpha);
	break;
	case 2:
	case 8:
	case 10:
		vertex_add_point(vbuffer, width_x, width_y, z_height,  0, 0, 1, tex_left, tex_top, color, alpha);
		vertex_add_point(vbuffer, width_x, start_y, z_height,  0, 0, 1, tex_right, tex_top, color, alpha);
		vertex_add_point(vbuffer, width_x, width_y, z, 		   0, 0, 1, tex_left, tex_bottom, color, alpha);
		vertex_add_point(vbuffer, width_x, width_y, z, 		   0, 0, 1, tex_left, tex_bottom, color, alpha);
		vertex_add_point(vbuffer, width_x, start_y, z_height,  0, 0, 1, tex_right, tex_top, color, alpha);
		vertex_add_point(vbuffer, width_x, start_y, z, 		   0, 0, 1, tex_right, tex_bottom, color, alpha);
	default:
	break;
}



vertex_end(vbuffer);
#endregion