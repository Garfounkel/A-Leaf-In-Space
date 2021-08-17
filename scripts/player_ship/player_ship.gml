function player_ship(_hullHp, _maxHullHp, _maxShields, _crew, _numCrew, _weapons, _numWeapons, _systems_without_engine, _numSystems, _engineSystem) constructor 
{
	hullHp = _hullHp
	maxHullHp = _maxHullHp
	maxShields = _maxShields
	crew = _crew
	numCrew = _numCrew
	weapons = _weapons
	numWeapons = _numWeapons
	systems_without_engine = _systems_without_engine 
	numSystems = _numSystems
	engineSystem = _engineSystem
}

enum weaponType
{
	blastLaser,
	hullLaser,
	crewLaser,
	systemLaser,
	count,  // keep this last to keep count
}

function Weapon(_sprite_index, _weaponName, _damage_per_shoot, _shieldDamage, _systemDamage, _crewDamage, _reload_time_sec, _shoot_per_fire, _reqPower, _price) constructor
{
	if (is_undefined(_sprite_index))
	{
		// default values
		_sprite_index = sLaser1
		_weaponName = "Laser"
		_damage_per_shoot = 1
		_shieldDamage = 1
		_systemDamage = 1
		_crewDamage = 20
		_shoot_per_fire = irandom_range(1, 2)
		_price = irandom_range(30, 90)

		var type = irandom_range(0, weaponType.count - 1)
		if (type == weaponType.blastLaser)
		{
			_shoot_per_fire = irandom_range(1, 3)
			_weaponName = "Blast laser " + string(_shoot_per_fire)
			_shieldDamage = irandom_range(1, 2)
		}
		else if (type == weaponType.hullLaser)
		{
			_weaponName = "Hull laser " + string(_shoot_per_fire)
			_damage_per_shoot = irandom_range(1, 3)
		}
		else if (type == weaponType.crewLaser)
		{
			_weaponName = "Crew laser " + string(_shoot_per_fire)
			_crewDamage = irandom_range(25, 60)
		}
		else if (type == weaponType.systemLaser)
		{
			_weaponName = "Sys laser " + string(_shoot_per_fire)
			_systemDamage = irandom_range(1, 3)
		}
		
		if (_shoot_per_fire == 1)
		{
			_reqPower = 1
			_reload_time_sec = 7
			_price = 40
		}
		else if (_shoot_per_fire == 2)
		{
			_reqPower = 2
			_reload_time_sec = 9
			_price = 80
		}
		else// if (_shoot_per_fire == 3)
		{
			_reqPower = 3
			_reload_time_sec = 11
			_price = 120
		}
	}
	sprite_index = _sprite_index
	weapon_name = _weaponName
	damage_per_shoot = _damage_per_shoot
	shieldDamage = _shieldDamage 
	systemDamage = _systemDamage
	crewDamage = _crewDamage
	reload_time_sec = _reload_time_sec
	shoot_per_fire = _shoot_per_fire
	reqPower = _reqPower
	price = _price
	level = _shoot_per_fire
	disabled = false
}