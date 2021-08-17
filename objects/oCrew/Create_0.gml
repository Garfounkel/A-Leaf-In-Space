speedWalk = 1.2;

maxHp = 100
currentHp = maxHp

// 2 sec to repair a bar for one crew member by default
// repairPower = repaired points per 60 frames
repairPower = 15
isRepairing = false

path_pos = 0;
path = path_add();
pathPoints = ds_list_create();

target_x = x;
target_y = y;

selected = false;
isMoving = false;
occupyingTile = noone
saved_MoveToNextPoint = false

dead = false
dead_anim = 0
dead_anim_frames = 60

function MoveToNextPoint()
{
	if (dead)
		return;

	if (global.gameplayPaused)
	{
		saved_MoveToNextPoint = true
		return
	}
	sprite_index = sHuman_walking;
	target_x = pathPoints[| path_pos].xx;
	target_y = pathPoints[| path_pos].yy;
	move_towards_point(target_x, target_y, speedWalk);
	image_angle = direction + 90;
}


function Select()
{
	if (dead || !playerTeam)
		return;

	if (!selected)
		global.numberSelected++;
	selected = true;
	image_blend = c_lime;
}

function Deselect()
{
	if (!playerTeam)
		return;

	if (selected)
		global.numberSelected--;
	selected = false;
	image_blend = c_white;
}

function ChangeHp(amount)
{
	if (dead)
		return;
	currentHp = clamp(currentHp + amount, 0, maxHp)
	if (currentHp <= 0)
		Die()
}

function TakeDamage(amount)
{
	ChangeHp(-amount)
}

function Die()
{
	dead = true
	speed = 0
	Deselect()
	Cleanup()
}

function Cleanup()
{
	if (occupyingTile != noone)
	{
		if (occupyingTile.linked_system.driven && occupyingTile.linked_system.driver == id)
		{
			occupyingTile.linked_system.driven = false
			occupyingTile.linked_system.driver = noone
		}
		occupyingTile.SetNotOccupied()
	}
}
