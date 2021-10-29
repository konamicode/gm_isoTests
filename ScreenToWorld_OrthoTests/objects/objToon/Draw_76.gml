  /// @description Insert description here

//move to screen space

var _oldx = x;
var _oldy = y;
var drawCoord = world_to_screen(x, y, z, objCamera.viewmat, objCamera.projmat);
var _newx = drawCoord[0] / (1 * objCamera.window_scale);
var _newy = drawCoord[1] / (1 * objCamera.window_scale);

//x = _newx;
//y = _newy;
