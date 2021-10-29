// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function vertex_set_format() {
	#region vertex format setup
	// Vertex format: data must go into vertex buffers in the order defined by this
	vertex_format_begin();
	vertex_format_add_position_3d();
	vertex_format_add_normal();
	vertex_format_add_texcoord();
	vertex_format_add_color();
	global.vertex_format = vertex_format_end();
	#endregion	
}

function vertex_add_point(_vbuffer, xx, yy, zz, nx, ny, nz, tu, tv, vcolor, valpha) {

	vertex_position_3d(_vbuffer, xx, yy, zz);
	vertex_normal(_vbuffer, nx, ny, nz);
	vertex_texcoord(_vbuffer, tu, tv);
	vertex_color(_vbuffer, vcolor, valpha);


}

function create_buffer_list()
{
	global.vert_buffer_list = ds_list_create();

}

function destroy_buffer_list()
{
	ds_list_destroy(global.vert_buffer_list);
}

function vertex_buffer_add(_buffer)
{
	if ds_list_find_value(global.vert_buffer_list, _buffer)
	{
		ds_list_add(_buffer);
	}
}