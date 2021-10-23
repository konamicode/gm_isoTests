/// @description Insert description here
// You can write your code in this editor


event_inherited();

cur_x = 0;
cur_y = 0;


new_x = x;
new_y = y;

global.grid_cell_w = (room_width + 32) / 32;
global.grid_cell_h = (room_height) div 32;

global.grid = mp_grid_create(0, 0, global.grid_cell_w, global.grid_cell_h, 32, 32);


my_path = path_add();
