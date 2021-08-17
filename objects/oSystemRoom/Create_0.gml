var margin = 5
var colsize = cellsize - margin
var halfcolsize = (cellsize / 2) - margin
sprite_index = sEmptySystem
limitPower = 0

#region Init systems
function InitSystem()
{
	driven = false
	driver = noone
	repaired_perc = 0

	if (system == systems.engine) {
		// engine's maxPower, currentPower and currentHp are overriden by ShipController
	    //maxPower = 0
		//currentPower = 0
		sprite = sEngineIcon
		sysName = "engine"
		abrev = "En"
		limitPower = maxEnginePower
	}
	else if (system == systems.shield) {
		//maxPower = playerTeam ? 4 : 2
		//currentPower = 0
		sprite = sShieldIcon
		sysName = "shield"
		abrev = "Sh"
		limitPower = maxShieldPower
	}
	else if (system == systems.weapon) {
		//maxPower = 4
		//currentPower = 0
		//sprite = sShieldIcon
		sysName = "weapon"
		abrev = "We"
		limitPower = maxWeaponPower
	}
	else if (system == systems.pilot) {
		//maxPower = 2
		//currentPower = 0
		//sprite = sShieldIcon
		sysName = "pilot"
		abrev = "Pi"
		limitPower = maxPilotPower
	}
	else {
		maxPower = 0
		currentPower = 0
		currentHp = maxPower
		sprite = sEmptySystem
		sysName = "empty"
		abrev = ""
	}
}
InitSystem()
#endregion

#region roomsizes
if (size == roomsize.full)
{
	x1 = x - colsize
	y1 = y - colsize
	x2 = x + colsize
	y2 = y + colsize
}
else if (size == roomsize.half)
{
	if (vertical)
	{
		x1 = x - halfcolsize
		y1 = y - colsize
		x2 = x + halfcolsize
		y2 = y + colsize
	}
	else
	{
		x1 = x - colsize
		y1 = y - halfcolsize
		x2 = x + colsize
		y2 = y + halfcolsize
	}
}
#endregion

tiles = ds_list_create();
num_tiles = collision_rectangle_list(x1, y1, x2, y2, oTile, false, true, tiles, false)

var xx = 0;
var yy = 0;
for (var i = 0; i < num_tiles; ++i;)
{
	var t = tiles[| i]
	t.linked_system = id

	xx += tiles[| i].x;
	yy += tiles[| i].y;
}
centerPoint = new point((xx / num_tiles) + halfcellsize, 
						(yy / num_tiles) + halfcellsize);


function CrewIsInside(crew)
{
	for (var i = 0; i < num_tiles; ++i;)
	{
		var tile = tiles[| i];
		if (crew.occupyingTile == tile)
			return true;
	}
	return false;
}

function GetNumberOfOccupants()
{
	var occupentsNum = 0
	for (var i = 0; i < num_tiles; ++i;)
	{
		var tile = tiles[| i];
		if (tile.occupied)
			occupentsNum++
	}
	return occupentsNum
}

function GetFirstFreeTile()
{
	for (var i = 0; i < num_tiles; ++i;)
	{
		var tile = tiles[| i];
		if (!tile.occupied)
			return tile
	}
	return noone
}

function GetCenterPoint()
{
	return centerPoint
}

function RefreshPowers()
{
	if (system == systems.engine) {
	}
	else if (system == systems.shield) {
		with (oShield)
		{
			if (playerTeam == other.playerTeam)
			{
				SetMaxShields(other.currentPower div 2)
			}
		}
	}
	else if (system == systems.weapon) {
		with (oWeaponManager)
		{
			if (playerTeam == other.playerTeam)
			{
				AllocatePower(other.currentPower)
			}
		}
	}
	else {
	}	
}

function ChangeCurrentPower(amount)
{
	currentPower = currentPower + amount
	RefreshPowers()
}

function TakeDamage(systemDamage, crewDamage)
{
	// System damage
	if (system != systems.empty)
	{
		currentHp = max(0, currentHp - systemDamage)
		var oldCurrentPower = currentPower
		currentPower = min(currentPower, currentHp)
		if (oldCurrentPower > currentPower)
		{
			with (oShipController)
			{
				if (playerTeam == other.playerTeam)
					engineSystem.currentPower += (oldCurrentPower - other.currentPower)
			}
		}
		RefreshPowers()
		
		if (currentHp < maxPower && driven)
		{
			driven = false
			driver = noone
		}
	}
	
	// Crew damage
	crews = ds_list_create();
	num_crews = collision_rectangle_list(x1, y1, x2, y2, oCrew, false, true, crews, false)
	for (var i = 0; i < num_crews; ++i;)
	{
		var crew = crews[| i]
		crew.TakeDamage(crewDamage)
	}
}

function Repair(amount)
{
	repaired_perc = min(100, repaired_perc + amount)
	if (repaired_perc >= 100)
	{
		repaired_perc = 0
		currentHp++
		if (!playerTeam)
		{  // Repower enemy system
			ChangeCurrentPower(1)
		}
	}
}

function Cost(currentEnergy)
{
	return 20 + (currentEnergy * 2)
}
