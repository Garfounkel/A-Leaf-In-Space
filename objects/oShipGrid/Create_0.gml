debug = false
debug_path = false

var cell_size = 32/8;
global.ship_grid = mp_grid_create(0, 0, room_width / cell_size, room_height / cell_size, cell_size, cell_size);
mp_grid_add_instances(global.ship_grid, oOuterWall, false);
mp_grid_add_instances(global.ship_grid, oInnerWall, false);
mp_grid_add_instances(global.ship_grid, oDoorWall_down, false);
mp_grid_add_instances(global.ship_grid, oDoorWall_up, false);

global.lastpath = path_add();