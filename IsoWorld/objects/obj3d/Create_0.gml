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


var start_x = bbox_left - x;
var start_y = bbox_top - y;

var width_x = bbox_right - x ;
var width_y = bbox_bottom - y; 

var z_height = -32;
z = layer_get_depth(layer);
var uvs = sprite_get_uvs(sprite_index, 0);
var tex_left = uvs[0];
var tex_top = uvs[1];
var tex_right = uvs[2];
var tex_bottom = uvs[3];



vertex_add_point(old_buffer, start_x, width_y, z_height,  0, 0, 1, tex_left, tex_top, color, alpha);
vertex_add_point(old_buffer, width_x, width_y, z_height,  0, 0, 1, tex_right, tex_top, color, alpha);
vertex_add_point(old_buffer, start_x, width_y, z, 		   0, 0, 1, tex_left, tex_bottom, color, alpha);
vertex_add_point(old_buffer, start_x, width_y, z, 		   0, 0, 1, tex_left, tex_bottom, color, alpha);
vertex_add_point(old_buffer, width_x, width_y, z_height,  0, 0, 1, tex_right, tex_top, color, alpha);
vertex_add_point(old_buffer, width_x, width_y, z, 		   0, 0, 1, tex_right, tex_bottom, color, alpha);
vertex_add_point(old_buffer, width_x, width_y, z_height,  0, 0, 1, tex_left, tex_top, color, alpha);
vertex_add_point(old_buffer, width_x, start_y, z_height,  0, 0, 1, tex_right, tex_top, color, alpha);
vertex_add_point(old_buffer, width_x, width_y, z, 		   0, 0, 1, tex_left, tex_bottom, color, alpha);
vertex_add_point(old_buffer, width_x, width_y, z, 		   0, 0, 1, tex_left, tex_bottom, color, alpha);
vertex_add_point(old_buffer, width_x, start_y, z_height,  0, 0, 1, tex_right, tex_top, color, alpha);
vertex_add_point(old_buffer, width_x, start_y, z, 		   0, 0, 1, tex_right, tex_bottom, color, alpha);

vertex_add_point(old_buffer, start_x, width_y, z_height,  0, 0, 1, tex_left, tex_top, color, alpha);
vertex_add_point(old_buffer, start_x, start_y, z_height,  0, 0, 1, tex_right, tex_top, color, alpha);
vertex_add_point(old_buffer, width_x, width_y, z_height,  0, 0, 1, tex_left, tex_bottom, color, alpha);
vertex_add_point(old_buffer, width_x, width_y, z_height,  0, 0, 1, tex_left, tex_bottom, color, alpha);
vertex_add_point(old_buffer, start_x, start_y, z_height,  0, 0, 1, tex_right, tex_top, color, alpha);
vertex_add_point(old_buffer, width_x, start_y, z_height,  0, 0, 1, tex_right, tex_bottom, color, alpha);



vertex_end(old_buffer);
#endregion

vertex_data = buffer_create_from_vertex_buffer(old_buffer,buffer_fixed, 1);
//vertex_delete_buffer(old_buffer);
verts  = array_create();
for ( var i = 0; i < buffer_get_size(vertex_data); i+= 36)
{
	var xx = buffer_peek(vertex_data, i + 0, buffer_f32);
	var yy = buffer_peek(vertex_data, i + 4, buffer_f32);
	var zz = buffer_peek(vertex_data, i + 8, buffer_f32);
	verts[array_length(verts)] = [xx, yy, zz];
	show_debug_message("vertices: " + string(xx) + ", " + string(yy) + ", " +  string(zz));
}
buffer_delete(vertex_data);

vbuffer = vertex_create_buffer();
uvs = array_create();

var origin = world_to_screen(x, y, z, objCamera.viewmat, objCamera.projmat);

var u_coords = ds_list_create();
var v_coords = ds_list_create();

vertex_begin(vbuffer, global.vertex_format);
texture = sprite_get_texture(sprite_index, 0);
for (var i = 0; i < array_length(verts); i++) {
	vert = verts[i];
	var _x = vert[0];
	var _y = vert[1];
	var _z = vert[2];

	var drawCoord = world_to_screen(_x, _y, _z, objCamera.viewmat, objCamera.projmat);
	var _u = (drawCoord[0] / (1 * objCamera.window_scale)); // - screenWidth/2;
	var _v = (drawCoord[1] / (1 * objCamera.window_scale)); // - screenHeight/2;
	_u -= origin[0] /  (1 * objCamera.window_scale);
	_v -= origin[1] /  (1 * objCamera.window_scale);
	ds_list_add(u_coords, _u);
	ds_list_add(v_coords, _v);
	//vertex_add_point(vbuffer, _x, _y, _z,  0, 0, 1, u, v, color, alpha);
}


ds_list_sort(u_coords, true);
min_u = u_coords[| 0];
max_u = u_coords[| ds_list_size(u_coords) - 1];
var u_dist = max_u - min_u;

ds_list_sort(v_coords, true);
min_v = v_coords[| 0];
max_v = v_coords[| ds_list_size(v_coords) - 1];
var v_dist = max_v - min_v;

show_debug_message("min u: " + string(min_u) + ", min v: " + string(min_v) + ", max u: " + string(max_u) + ", max v: " + string(max_v));

for (var i = 0; i < array_length(verts); i++) {
	vert = verts[i];
	var _x = vert[0];
	var _y = vert[1];
	var _z = vert[2];

	var drawCoord = world_to_screen(_x, _y, _z, objCamera.viewmat, objCamera.projmat);
	var _u = (drawCoord[0] / (1 * objCamera.window_scale)); // - screenWidth/2;
	var _v = (drawCoord[1] / (1 * objCamera.window_scale)); // - screenHeight/2;
	_u -= origin[0] /  (1 * objCamera.window_scale);
	_v -= origin[1] /  (1 * objCamera.window_scale);
	_u = 1 - ((max_u - _u) / u_dist);
	_v = 1 - ((max_v - _v) / v_dist);

	vertex_add_point(vbuffer, _x, _y, _z,  0, 0, 1, _u, _v, color, alpha);
}

ds_list_destroy(u_coords);
ds_list_destroy(v_coords);

vertex_end(vbuffer);
