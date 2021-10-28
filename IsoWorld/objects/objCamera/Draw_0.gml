/// @description Insert description here
// You can write your code in this editor

UpdateCameraPos();

vertex_submit(vbuffer, pr_linelist, 0);

if (ground_layer) {
	var layer_z_height = layer_get_depth(ground_layer);
	var tile_map = layer_tilemap_get_id(ground_layer);
	var _t = tilemap_get_tileset(tile_map);
	var tile_set = asset_get_index(tileset_get_name(_t));
	var tile_layer_w = tilemap_get_width(tile_map);
	var tile_layer_h = tilemap_get_height(tile_map);
	var tile_w = tilemap_get_tile_width(tile_map);
	var tile_h = tilemap_get_tile_height(tile_map);
	var frame = tilemap_get_frame(tile_map);

	for ( var  k = 0; k < tile_layer_h; k++)
	{
		for ( var l = 0; l < tile_layer_w; l++)
		{
			var tile = tilemap_get(tile_map, l, k);		

			if (tile != 0)
			{
				var ind = tile_get_index(tile);
			
				matrix_set(matrix_world, matrix_build((l  * tile_w), (k * tile_h), layer_z_height, 0, 0, 0, 1, 1, 1));
				if (drawFloor)
					draw_tile(tile_set, tile, frame, 0, 0);
				matrix_set(matrix_world, matrix_build_identity());			

			}
		}
	}
}



with (obj3d) {
	event_perform(ev_draw, 0)	
}

