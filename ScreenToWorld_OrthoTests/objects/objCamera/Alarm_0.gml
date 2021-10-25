/// @description Insert description here
// You can write your code in this editor

window_center();

var _w = window_get_width();
var _h = window_get_height();
display_set_gui_maximize(window_scale, window_scale, 0, 0);
//display_set_gui_size(_w, _h);	
show_debug_message(string(window_scale) + " | " + string(display_get_gui_width()) + " + " + string(_w) + ": " + string(display_get_gui_height()) + " + " + string(_h));
