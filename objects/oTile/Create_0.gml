linked_system = noone

occupant = instance_place(x, y, oCrew)
occupied = occupant != noone
if (occupied)
	occupant.occupyingTile = id

centerX = x - sprite_get_xoffset(sprite_index) + sprite_width / 2;
centerY = y - sprite_get_yoffset( sprite_index) + sprite_height / 2;


function MoveCrew(tile, crew)
{
	if (!ComputePath(crew.path, crew.pathPoints, crew.x, crew.y, tile.centerX, tile.centerY))
		return;
	crew.path_pos = 0
	crew.isMoving = true;
	crew.MoveToNextPoint();
	if (crew.occupyingTile.linked_system.driven && crew.occupyingTile.linked_system.driver == crew)
	{
		crew.occupyingTile.linked_system.driven = false
		crew.occupyingTile.linked_system.driver = noone
	}
	tile.occupied = true
	crew.occupyingTile.occupied = false
	crew.occupyingTile = tile
	if (crew.playerTeam)
		instance_create_depth(mouse_x, mouse_y, 0, oMouseClick)
}

function GetPlayerTeam()
{
	return linked_system.playerTeam
}

function SetNotOccupied()
{
	occupant = noone
	occupied = false
}
