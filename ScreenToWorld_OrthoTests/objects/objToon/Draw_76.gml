/// @description Insert description here
// You can write your code in this editor
var _oldx = x;
var _oldy = y;
var drawCoord = world_to_screen(x, y, z, objCamera.viewmat, objCamera.projmat);
var _newx = drawCoord[0] / objCamera.window_scale;
var _newy = drawCoord[1] / objCamera.window_scale;

x = _newx;
y = _newy;

depth = -y;