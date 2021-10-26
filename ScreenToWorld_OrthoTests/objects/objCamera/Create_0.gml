/// @description Insert description here
// You can write your code in this editor
#macro screenWidth 640
#macro screenHeight 360

#macro mouse_gui_x device_mouse_x_to_gui(0)
#macro mouse_gui_y device_mouse_y_to_gui(0)

enum camType {
	ortho, 
	persp
}

enum follow {
	none,
	player
}

//pitch =-(30)
//pitch = -20;
heading = 45;

//camOriginX	= room_width;
//camTargetX	= room_width/2;
//camOriginY	= room_height;
//camTargetY	= room_height/2;
//camOriginZ = -512;
//camTargetZ	= 0;


window_scale = 2;
zoom = 0.5
function SetupGameWindow(_window_scale) {
	view_width = 1920/6;
	view_height = 1080/6;

	window_set_size(view_width * _window_scale, view_height * _window_scale);
	alarm[0] = 1;

	surface_resize(application_surface, view_width * _window_scale, view_height * _window_scale);	
	//var _w = window_get_width();
	//var _h = window_get_height();
	//display_set_gui_maximize(_window_scale, _window_scale, 0, 0);
	//
	//show_debug_message(string(_window_scale) + " | " + string(display_get_gui_width()) + " + " + string(_w) + ": " + string(display_get_gui_height()) + " + " + string(_h));
	//display_set_gui_size(screenWidth, screenHeight);
}

function UpdateCameraPos() {
	if followTarget == follow.player {
		camTargetX	= objPlayer.x;
		camTargetY	= objPlayer.y;
		//camTargetX = room_width/2;
		//camTargetY = room_height/2;
		camOriginX	= dcos(pitch) * dcos(heading) + camTargetX;	
		camOriginY	= dcos(pitch) * dsin(heading) + camTargetY;		
		
	} else if followTarget == follow.none
	{
		camTargetX	= room_width/2;
		camTargetY	= room_height/2;
		camOriginX	= dcos(pitch) * dcos(heading) + room_width/2;	
		camOriginY	= dcos(pitch) * dsin(heading) + room_height/2;
	}
	
	//camOriginX	= dcos(pitch) * dcos(heading) + room_width/2;
	//camTargetX	= room_width/2;
	//camOriginY	= dcos(pitch) * dsin(heading) + room_height/2;
	
	camOriginZ = dsin(pitch);
	camTargetZ	= 0;
	
	viewmat = matrix_build_lookat(camOriginX, camOriginY, camOriginZ, camTargetX, camTargetY, 0, 0, 0, 1);
	projmat = matrix_build_projection_ortho(screenWidth * 0.5, screenHeight * 0.5, -1600, 1600);
	camera = camera_get_active();
	camera_set_view_mat(camera, viewmat);
	camera_set_proj_mat(camera, projmat);
	camera_apply(camera);
}

function ResetCamera() {
	//viewmat = matrix_build_lookat(0, 0, -100, 0, 0, 100, 0, 1, 0);
	viewmat = matrix_build_lookat(160.5, 90.5, -16000, 160.5, 90.5, 16000, 0, 1, 0);
	projmat = matrix_build_projection_ortho(screenWidth * .5, screenHeight * .5, -16000, 16000);
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