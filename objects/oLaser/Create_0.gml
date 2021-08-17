price = 35
weapon_name = "Mini laser"
level = 0

function Init()
{
	image_speed = 0
	powered = false

	target = noone
	targeting = false

	reload_time_frame = round(reload_time_sec * 60)

	_shootTimer = 0
	_shoot_shot = 0
	_spawnCorner = new point(infinity, infinity)
	shooting = false
}
Init()

function Fire()
{
	_shoot_shot = 0
	shooting = true
	if (playerTeam)
		_spawnCorner = oEnemyFrame.GetRandomCorner()
	else
		_spawnCorner = GetPlayerCorner()
	FireOnce()
}

function FireOnce()
{
	if (!shooting)
		return;
	image_speed = 1
	_shoot_shot++
	var bulletLayer = "Player_Weapons"

	if (!playerTeam)
	{
		bulletLayer = "Enemy_Weapons"
		RandomLaserSound(false)
	}
	else
	{
		RandomLaserSound(true)
	}

	with (instance_create_layer(x, y, bulletLayer, oLaserBullet))
	{
		image_angle = other.image_angle
		//if (!other.playerTeam)
		//	sprite_index = sLaserBulletEnemy
		playerTeam = other.playerTeam
		damage = other.damage_per_shoot
		shieldDamage = other.shieldDamage
		systemDamage = other.systemDamage
		crewDamage = other.crewDamage
		target = other.target;
		targetPoint = other.target.linked_system.GetCenterPoint()
		spawnCorner = other._spawnCorner
		motion_add(other.image_angle, fireSpeed)
	}
}

function GetChargePerc()
{
	if (_shootTimer < reload_time_frame)
		return _shootTimer / reload_time_frame
	else
		return 1
}

function GetPlayerCorner()
{
	var x1 = 0
	var x2 = room_width * 0.6
	var y1 = 0
	var y2 = room_height
	
	return choose(new point(round(irandom_range(x1, x2)), choose(0,1)), 
				  new point(0, round(irandom_range(y1, y2))))
}