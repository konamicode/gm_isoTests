/// @description Insert description here
// You can write your code in this editor


matrix_set(matrix_world, matrix_build(x, y, z, 0, 0, 0, 1, 1, 1));
vertex_submit(vbuffer, pr_trianglelist, texture);
matrix_set(matrix_world, matrix_build_identity());

