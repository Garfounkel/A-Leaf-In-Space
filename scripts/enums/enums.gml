// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
enum systems
{
	empty,
	weapon,
	shield,
	engine,  // engine is just the power
	pilot,
	defsys,
	medbay,
	oxygen,
	boarding,
}

enum roomsize
{
	full,
	half,
}

enum tab_id
{
	Upgrade = 0,
	Crew = 1,
	Equipment = 2
}

enum rewardType
{
	money,
	repair,
	weapon
}

function RewardObj(_type, _value) constructor
{
	type = _type
	value = _value
}

enum weaponState
{
	oldWeapon,
	empty,
	newWeapon
}

function WeaponObj(_state, _value) constructor
{
	state = _state
	value = _value
}