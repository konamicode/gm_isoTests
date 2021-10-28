/// @description Insert description here
// You can write your code in this editor

// Inherit the actorParent event
event_inherited();

my_toon = instance_create_layer(x, y, "Instances", objToon);
my_toon.z = z;
my_toon.sprite_index = toon;
my_toon.image_xscale = 1/global.zoom[global.zoomLvl];
my_toon.image_yscale = 1/global.zoom[global.zoomLvl];
my_toon.rootType = type;
my_toon.actorParent = id;