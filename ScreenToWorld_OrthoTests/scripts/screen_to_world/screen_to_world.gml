// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function screen_to_world(_x, _y, _view_mat, _proj_mat){
/// @description convert_2d_to_3d(x, y, view_mat, proj_mat)
/// @param x
/// @param y
/// @param view_mat
/// @param proj_mat
/*
Transforms a 2D coordinate (in window space) to a 3D vector.
Returns an array of the following format:
[dx, dy, dz, ox, oy, oz]
where [dx, dy, dz] is the direction vector and [ox, oy, oz] is the origin of the ray.
Works for both orthographic and perspective projections.
Script created by TheSnidr
(slightly modified by @dragonitespam)
*/
	//var _x = argument0;
	//var _y = argument1;

	//display_set_gui_size( window_get_width(), window_get_height() );


	var V = _view_mat;
	var P = _proj_mat;

	var mx = 2 * (_x / window_get_width() - .5) / P[0];
	var my = 2 * (_y / window_get_height() - .5) / P[5];
	var camX = - (V[12] * V[0] + V[13] * V[1] + V[14] * V[2]);
	var camY = - (V[12] * V[4] + V[13] * V[5] + V[14] * V[6]);
	var camZ = - (V[12] * V[8] + V[13] * V[9] + V[14] * V[10]);

	if (P[15] == 0)
	{    //This is a perspective projection
	    return [V[2]  + mx * V[0] + my * V[1],
	            V[6]  + mx * V[4] + my * V[5],
	            V[10] + mx * V[8] + my * V[9],
	            camX,
	            camY,
	            camZ];
	}
	else
	{    //This is an ortho projection
	    return [V[2],
	            V[6],
	            V[10],
	            camX + mx * V[0] + my * V[1],
	            camY + mx * V[4] + my * V[5],
	            camZ + mx * V[8] + my * V[9]];
	}
}

function world_to_screen(xx, yy, zz, view_mat, proj_mat) {
	/// @param xx
	/// @param yy
	/// @param zz
	/// @param view_mat
	/// @param proj_mat
	/*
	    Transforms a 3D world-space coordinate to a 2D window-space coordinate. Returns an array of the following format:
	    [xx, yy]
	    Returns [-1, -1] if the 3D point is not in view
   
	    Script created by TheSnidr
	    www.thesnidr.com
	*/
	//var xx = argument0;
	//var yy = argument1;
	//var zz = argument2;
	//var view_mat = argument3;
	//var proj_mat = argument4;

	if (proj_mat[15] == 0) {   //This is a perspective projection
	    var w = view_mat[2] * xx + view_mat[6] * yy + view_mat[10] * zz + view_mat[14];
	    // If you try to convert the camera's "from" position to screen space, you will
	    // end up dividing by zero (please don't do that)
	    //if (w <= 0) return [-1, -1];
	    if (w == 0) return [-1, -1];
	    var cx = proj_mat[8] + proj_mat[0] * (view_mat[0] * xx + view_mat[4] * yy + view_mat[8] * zz + view_mat[12]) / w;
	    var cy = proj_mat[9] + proj_mat[5] * (view_mat[1] * xx + view_mat[5] * yy + view_mat[9] * zz + view_mat[13]) / w;
	} else {    //This is an ortho projection
	    var cx = proj_mat[12] + proj_mat[0] * (view_mat[0] * xx + view_mat[4] * yy + view_mat[8]  * zz + view_mat[12]);
	    var cy = proj_mat[13] + proj_mat[5] * (view_mat[1] * xx + view_mat[5] * yy + view_mat[9]  * zz + view_mat[13]);
	}

	return [(0.5 + 0.5 * cx) * window_get_width(), (0.5 + 0.5 * cy) * window_get_height()];
}