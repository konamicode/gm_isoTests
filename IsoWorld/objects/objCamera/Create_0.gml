/// @description Insert description here
// You can write your code in this editor
#macro screenWidth 320
#macro screenHeight 180

#macro mouse_gui_x device_mouse_x_to_gui(0)
#macro mouse_gui_y device_mouse_y_to_gui(0)

global.zoom = [0.5, 0.667, 0.75, 1, 1.25, 1.5, 2];
global.zoomLvl = 3

enum camType {
	ortho, 
	persp
}

enum follow {
	none,
	player
}

heading = 45;

window_scale = 2;
viewmat = 0;
projmat = 0;

function SetupGameWindow(_window_scale) {
	view_width = screenWidth;
	view_height = screenHeight;

	window_set_size(view_width * _window_scale, view_height * _window_scale);
	alarm[0] = 1;
	//resize gui in the alarm after window has changed
	surface_resize(application_surface, view_width * _window_scale, view_height * _window_scale);	
}

function UpdateCameraPos() {
	if followTarget == follow.player {
		camTargetX	= objPlayer.x;
		camTargetY	= objPlayer.y;
		camOriginX	= dcos(pitch) * dcos(heading) + camTargetX;	
		camOriginY	= dcos(pitch) * dsin(heading) + camTargetY;		
		
	} else if followTarget == follow.none
	{
		camTargetX	= 0;
		camTargetY	= 0;
		camOriginX	= dcos(pitch) * dcos(heading) + 0;	
		camOriginY	= dcos(pitch) * dsin(heading) + 0;
	}
		
	camOriginZ = dsin(pitch);
	camTargetZ	= 0;
	
	viewmat = matrix_build_lookat(camOriginX, camOriginY, camOriginZ, camTargetX, camTargetY, 0, 0, 0, 1);
	projmat = matrix_build_projection_ortho(screenWidth * global.zoom[global.zoomLvl], screenHeight * global.zoom[global.zoomLvl], -16000, 16000);	
	camera = camera_get_active();
	camera_set_view_mat(camera, viewmat);
	camera_set_proj_mat(camera, projmat);
	camera_apply(camera);
}

function ResetCamera() {

	viewmat = matrix_build_lookat(screenWidth/2, screenHeight/2, -16000, screenWidth/2, screenHeight/2, 16000, 0, 1, 0);
	projmat = matrix_build_projection_ortho(screenWidth, screenHeight, -16000, 16000);
	camera = camera_get_active();
	camera_set_view_mat(camera, viewmat);
	camera_set_proj_mat(camera, projmat);
	camera_apply(camera);
}

target = noone;

SetupGameWindow(window_scale);

UpdateCameraPos();

ground_layer = layer_get_id("tiles_ground");
drawFloor = layer_get_visible(ground_layer);
layer_set_visible(ground_layer, false);

vertex_set_format();

#region create the grid
vbuffer = vertex_create_buffer();
vertex_begin(vbuffer, global.vertex_format);

// Create a checkerboard pattern on the floor
var s = 32;
var color = c_white;
var color_x = c_red;

var alpha = 0.8;



for (var i = 0; i <= room_height; i += s) {

	vertex_add_point_tex(vbuffer, i, 0, 0, 0, 0, 1, 0, 0, color_x, alpha);
	vertex_add_point_tex(vbuffer, i, room_width, 0, 0, 0, 1, 0, 0, color_x, alpha);	
}
for (var j = 0; j <= room_width ; j += s) {

	vertex_add_point_tex(vbuffer, 0, j, 0, 0, 0, 1, 0, 0, color, alpha);
	vertex_add_point_tex(vbuffer, room_height, j, 0, 0, 0, 1, 0, 0, color, alpha);	             

}

vertex_end(vbuffer);
#endregion