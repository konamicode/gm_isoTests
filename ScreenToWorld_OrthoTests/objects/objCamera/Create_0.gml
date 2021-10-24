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



//pitch =-(30)
//pitch = -20;
heading = 45;



//camOriginX	= room_width;
//camTargetX	= room_width/2;
//camOriginY	= room_height;
//camTargetY	= room_height/2;
//camOriginZ = -512;
//camTargetZ	= 0;


window_scale = 4;

function SetupGameWindow() {
	view_width = 1920/6;
	view_height = 1080/6;

	window_set_size(view_width * window_scale, view_height * window_scale);
	alarm[0] = 1;

	surface_resize(application_surface, view_width * window_scale, view_height * window_scale);	
	
	display_set_gui_size(screenWidth, screenHeight);
}

function UpdateCameraPos() {
	if instance_exists(objPlayer) {
		camTargetX	= objPlayer.x;
		camTargetY	= objPlayer.y;
		camOriginX	= dcos(pitch) * dcos(heading) + objPlayer.x;	
		camOriginY	= dcos(pitch) * dsin(heading) + objPlayer.y;		
		
	} else
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
	projmat = matrix_build_projection_ortho(screenWidth* 0.75, screenHeight* 0.75, -1600, 1600);
	camera = camera_get_active();
	camera_set_view_mat(camera, viewmat);
	camera_set_proj_mat(camera, projmat);
	camera_apply(camera);
}

function ResetCamera() {
	viewmat = matrix_build_lookat(0, 0, -100, 0, 0, 100, 0, 1, 0);
	projmat = matrix_build_projection_ortho(screenWidth, screenHeight, -1600, 1600);
	camera = camera_get_active();
	camera_set_view_mat(camera, viewmat);
	camera_set_proj_mat(camera, projmat);
	camera_apply(camera);
}

target = noone;

SetupGameWindow();

UpdateCameraPos();

ground_layer = layer_get_id("tiles_ground");
drawFloor = layer_get_visible(ground_layer);
layer_set_visible(ground_layer, false);