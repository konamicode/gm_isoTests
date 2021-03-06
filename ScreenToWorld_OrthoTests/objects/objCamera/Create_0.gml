/// @description Insert description here
// You can write your code in this editor
#macro screenWidth 320
#macro screenHeight 180

#macro mouse_gui_x device_mouse_x_to_gui(0)
#macro mouse_gui_y device_mouse_y_to_gui(0)

global.zoom = [0.5, 0.667, 0.75, 1, 1.5, 2];
global.zoomLvl = 0

enum camType {
	ortho, 
	persp
}

enum follow {
	none,
	player
}

heading = 45;

window_scale = 1;

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
		camTargetX	= room_width/4;
		camTargetY	= room_height/4;
		camOriginX	= dcos(pitch) * dcos(heading) + room_width/4;	
		camOriginY	= dcos(pitch) * dsin(heading) + room_height/4;
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