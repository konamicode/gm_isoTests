/// @description Insert description here
// You can write your code in this editor

var gridSize = room_width div 32;
var gridX = x mod gridSize;
var gridY = y div gridSize;
depth = -((gridY * gridSize) + gridX);

my_toon.x = x;
my_toon.y = y;
my_toon.z = z;
my_toon.depth = depth;