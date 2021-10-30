/// @description Insert description here
// You can write your code in this editor


gpu_set_ztestenable(true);
gpu_set_alphatestenable(true)
gpu_set_zwriteenable(true);

#region vertex format setup
// Vertex format: data must go into vertex buffers in the order defined by this
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_texcoord();
vertex_format_add_color();
global.vertex_format = vertex_format_end();
#endregion

old_buffer = vertex_create_buffer();
vertex_begin(old_buffer, global.vertex_format);

#region create the plane
old_buffer = vertex_create_buffer();
vertex_begin(old_buffer, global.vertex_format);
texture = sprite_get_texture(sprite_index, 0);


var color = c_white;

var alpha = 1;


var start_x = (bbox_left - x);
var start_y = (bbox_top - y) ;

var width_x = (bbox_right - x );
var width_y = (bbox_bottom - y); 

z = 0;
var z_height = -32;

var uvs = sprite_get_uvs(sprite_index, 0);
var tex_left = uvs[0];
var tex_top = uvs[1];
var tex_right = uvs[2];
var tex_bottom = uvs[3];

vertex_add_point(old_buffer, start_x, width_y, 0, 0, 0, 1, tex_left, tex_top, color, alpha);
vertex_add_point(old_buffer, start_x, start_y, z_height,  0, 0, 1, tex_right, tex_top, color, alpha);
vertex_add_point(old_buffer, width_x, width_y, 0,  0, 0, 1, tex_left, tex_bottom, color, alpha);
vertex_add_point(old_buffer, width_x, width_y, 0,  0, 0, 1, tex_left, tex_bottom, color, alpha);
vertex_add_point(old_buffer, start_x, start_y, z_height,  0, 0, 1, tex_right, tex_top, color, alpha);
vertex_add_point(old_buffer, width_x, start_y, z_height,  0, 0, 1, tex_right, tex_bottom, color, alpha);


vertex_end(old_buffer);
#endregion