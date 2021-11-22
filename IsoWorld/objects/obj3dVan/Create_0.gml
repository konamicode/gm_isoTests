/// @description Insert description here
// You can write your code in this editor
sprite_index = sprite;
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

#region vertex format setup
// Vertex format: data must go into vertex buffers in the order defined by this
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_color();
global.flatshade = vertex_format_end();
#endregion

//old_buffer = vertex_create_buffer();
//vertex_begin(old_buffer, global.vertex_format);

#region create the polygon mesh
old_buffer = vertex_create_buffer();
vertex_begin(old_buffer, global.vertex_format);
texture = sprite_get_texture(sprite_index, 0);
var texel_h = texture_get_texel_height(texture);
var texel_w = texture_get_texel_width(texture);

var color = c_white;
var alpha = 1;

var angle = 30;//darctan(1/2);

var left_x = sprite_xoffset;
var left_y = (dtan(angle) * left_x);

var right_x = sprite_width - sprite_xoffset;
var right_y = (dtan(angle) * right_x);


var screen_origin = world_to_screen(0, 0, 0, objCamera.viewmat, objCamera.projmat);
var _origin = screen_to_world(0, 0, objCamera.viewmat, objCamera.projmat);
var _width = screen_to_world(screen_origin[0] - left_x, screen_origin[1] - left_y, objCamera.viewmat, objCamera.projmat);
var _depth = screen_to_world(screen_origin[0] + right_x, screen_origin[1] + right_y, objCamera.viewmat, objCamera.projmat);
var _height = screen_to_world(screen_origin[0], screen_origin[1] - height, objCamera.viewmat, objCamera.projmat);

width_x = _width[0] * _width[5] / -_width[2] + _width[3];
width_y = _width[1] * _width[5] / -_width[2] + _width[4];

depth_x = _depth[0] * _depth[5] / -_depth[2] + _depth[3];
depth_y = _depth[1] * _depth[5] / -_depth[2] + _depth[4];

height_x = _height[0] * _height[5] / -_height[2] + _height[3];
height_y = _height[1] * _height[5] / -_height[2] + _height[4];
			  
var origin_x = 0; // * texel_w;
var origin_y = 0; //* texel_w;

z = layer_get_depth(layer);
var z_height = z + height;

image_xscale = -(width_x / (bbox_right - bbox_left));
image_yscale = (depth_x / (bbox_bottom - bbox_top));


var uvs = sprite_get_uvs(sprite_index, 0);
var tex_left =		uvs[0] ;
var tex_top =		uvs[1] ;
var tex_right =		uvs[2] ;
var tex_bottom =	uvs[3] ;

var tex_x = uvs[0] / (texel_w);
var tex_y = uvs[1] / (texel_w);		  
var tex_w = uvs[2] / (texel_w);
var tex_v = uvs[3] / (texel_w);

var width = tex_w - tex_x;
var length = tex_v - tex_y;

//left/depth face
vertex_add_point_tex(old_buffer, width_x, origin_y, z_height, 0, 0, 1, tex_left, tex_top, color, alpha);
vertex_add_point_tex(old_buffer, origin_x, origin_y, z_height, 0, 0, 1, tex_right, tex_top, color, alpha);
vertex_add_point_tex(old_buffer, width_x, origin_y, 0, 		  0, 0, 1, tex_left, tex_bottom, color, alpha);
vertex_add_point_tex(old_buffer, width_x, origin_y, 0, 		  0, 0, 1, tex_left, tex_bottom, color, alpha);
vertex_add_point_tex(old_buffer, origin_x, origin_y, z_height,  0, 0, 1, tex_right, tex_top, color, alpha);
vertex_add_point_tex(old_buffer, origin_x, origin_y, 0, 		  0, 0, 1, tex_right, tex_bottom, color, alpha);
//right / length face
vertex_add_point_tex(old_buffer, origin_x, origin_y, z_height,  0, 0, 1, tex_left, tex_top, color, alpha);
vertex_add_point_tex(old_buffer, origin_x, -depth_x, z_height,  0, 0, 1, tex_right, tex_top, color, alpha);
vertex_add_point_tex(old_buffer, origin_x, origin_y, 0, 		  0, 0, 1, tex_left, tex_bottom, color, alpha);
vertex_add_point_tex(old_buffer, origin_x, origin_y, 0, 		  0, 0, 1, tex_left, tex_bottom, color, alpha);
vertex_add_point_tex(old_buffer, origin_x, -depth_x, z_height,  0, 0, 1, tex_right, tex_top, color, alpha);
vertex_add_point_tex(old_buffer, origin_x, -depth_x, 0, 		  0, 0, 1, tex_right, tex_bottom, color, alpha);
////top height/face
vertex_add_point_tex(old_buffer, width_x, origin_y, z_height, 0, 0, 1, tex_left, tex_top, color, alpha);
vertex_add_point_tex(old_buffer, width_x, -depth_x, z_height,  0, 0, 1, tex_right, tex_top, color, alpha);
vertex_add_point_tex(old_buffer, origin_x, origin_y, z_height,  0, 0, 1, tex_left, tex_bottom, color, alpha);
vertex_add_point_tex(old_buffer, origin_x, origin_y, z_height,  0, 0, 1, tex_left, tex_bottom, color, alpha);
vertex_add_point_tex(old_buffer, width_x, -depth_x, z_height,  0, 0, 1, tex_right, tex_top, color, alpha);
vertex_add_point_tex(old_buffer, origin_x, -depth_x, z_height,  0, 0, 1, tex_right, tex_bottom, color, alpha);

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
	//show_debug_message("vertices: " + string(xx) + ", " + string(yy) + ", " +  string(zz));
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

var u_offset = tex_left;
var u_length = (tex_right - tex_left);
var v_offset = tex_top;
var v_length = (tex_bottom - tex_top);

show_debug_message("min u: " + string(min_u) + ", min v: " + string(min_v) + ", max u: " + string(max_u) + ", max v: " + string(max_v));

show_debug_message("texel width : " + string(texel_w) + ", texel height: " + string(texel_h));


for (var i = 0; i < array_length(verts); i++) {
	vert = verts[i];
	var _x = vert[0];
	var _y = vert[1];
	var _z = vert[2];

	var drawCoord = world_to_screen(_x, _y, _z, objCamera.viewmat, objCamera.projmat);
	var _u = (drawCoord[0] / (1)); // - screenWidth/2;
	var _v = (drawCoord[1] / (1)); // - screenHeight/2;
	_u -= origin[0] /  (1);
	_v -= origin[1] /  (1);
	_u = (u_offset + ((1 - ((max_u - _u) / u_dist)) * u_length) );
	_v = (v_offset + ((1 - ((max_v - _v) / v_dist))  * v_length));
	//show_debug_message("u: " + string(_u) + ", v: " + string(_v));
	
	vertex_add_point_tex(vbuffer, _x, _y, _z,  0, 0, 1, _u, _v, color, 1.0);
}

ds_list_destroy(u_coords);
ds_list_destroy(v_coords);

vertex_end(vbuffer);
