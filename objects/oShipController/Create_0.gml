debug = false
global.rewardScreenOn = false

shieldPower = shieldNumber * 2

#region UI
UI_x1 = PlayerUI_x1
UI_y1 = PlayerUI_y1
UI_x2 = PlayerUI_x2
UI_y2 = PlayerUI_y2
UI_xbottom = UI_x1
if (!playerTeam)
{
	UI_x1 = EnemyUI_x1
	UI_y1 = EnemyUI_y1
	UI_x2 = EnemyUI_x2
	UI_y2 = EnemyUI_y2
	UI_xbottom = UI_x1 + 10
}
#endregion

function GetSystemBoundingBox(system_pos, system_maxPower, system_type)
{
	if (system_type == systems.shield)
		system_maxPower += ((system_maxPower-1) div 2)

	x1 = round(UI_x1) + 48 - sys_margin + (sys_x_offset*system_pos)
	y1 = round(UI_y2) + 4 + sys_margin
	x2 = x1 + 24
	y2 = y1 - (26 + sys_margin + sys_size_y + (sys_y_offset*system_maxPower))
	return [x1, y1, x2, y2]
}


// Drawing systems
sys_x_offset = 32
sys_y_offset = 6
sys_size_x = 16
sys_size_y = 4
sys_margin = 4

function InitShip(forcedHullHp)
{
	if (forcedHullHp > -1)
		hullHp = forcedHullHp
	else
		hullHp = maxHullHp
	#region Systems
	num_systems = 0
	num_systems_without_engines = 0
	hasShields = false
	hasWeapons = false
	with (oShield)
	{
		if (playerTeam == other.playerTeam)
		{
			other.shieldController = id
		}
	}
	with (oSystemRoom)
	{
		if (playerTeam == other.playerTeam && system != systems.empty)
		{
			maxPower = 0
			if (system == systems.engine)  // all ships must have an engine
			{
				other.engineSystem = id
				maxPower = other.maxPower
				currentPower = maxPower
				other.systems[other.num_systems++] = id
			}
			else 
			{
				if (system == systems.weapon)
				{
					other.weaponSystem = id
					other.hasWeapons = true
					maxPower = other.weaponsPower
				}
				else
				{
					other.systems[other.num_systems++] = id
					other.systemsWithoutEngine[other.num_systems_without_engines++] = id
					if (system == systems.shield)
					{
						other.shieldSystem = id
						other.hasShields = true
						maxPower = other.shieldPower
					}
					else if (system == systems.pilot)  // all ships must have a pilot system
					{
						other.pilotSystem = id
						maxPower = other.pilotPower
					}
				}
				currentPower = 0
			}
			currentHp = maxPower
		}
	}
	if (hasWeapons)  // Put weapon system last always
	{
		id.systems[num_systems++] = weaponSystem
		systemsWithoutEngine[num_systems_without_engines++] = weaponSystem
		if (playerTeam)
		{
			var bb = GetSystemBoundingBox(num_systems, 1, systems.empty)
			with (oWeaponsFrame)
			{
				x = bb[0] - 4
				y = other.UI_y2 - (sprite_height / 2) - 18
			}
		}
	}

	// AI Full energy on every system
	if (!playerTeam)
	{
		engineSystem.currentPower = 0
		for (i = 0; i < num_systems_without_engines; i++)
		{
			systemsWithoutEngine[i].currentPower = systemsWithoutEngine[i].maxPower
		}
		if (hasShields)
		{
			shieldController.SetMaxShields(shieldSystem.maxPower div 2)
			shieldController.RefreshAllShields()
		}
		if (hasWeapons)
			with (oWeaponManager)
				if (playerTeam == other.playerTeam)
					AllocatePower(other.weaponSystem.currentPower)
	}
	#endregion
}

function ShipDestroyed()
{
	var frameDepth = 0
	PlaySound(sndVictoryExplosion)
	if (playerTeam)
	{
		with (instance_create_layer(round(room_width / 2), round(room_height / 2), "PopUpUI", oPopupFrame))
		{
			main_text = "Player ship destroyed! Try again?" + "\nHighscore: " + string(global.highscore)
			global.difficulty = 1
			frameDepth = depth
			oGameManager.Pause()
		}
		with (instance_create_layer(round(room_width / 2) - 48, round(room_height * 0.75), "PopUpUI", oRestartButton))
		{
			depth = frameDepth - 1
			upgradeButton = false
		}
	}
	else
	{
		var parentFrame = 0;
		with (instance_create_layer(round(room_width / 2), round(room_height / 2), "PopUpUI", oPopupFrame))
		{
			global.highscore = max(global.highscore, global.difficulty)
			global.difficulty++
			main_text = "UFO destroyed! You won!\n\nUnfortunately they didn't have your router.\n\nDifficulty increased by 1."
			frameDepth = depth
			oGameManager.Pause()
			parentFrame = id
		}
		with (instance_create_layer(round(room_width / 2) - 48, round(room_height * 0.75), "PopUpUI", oRestartButton))
		{
			depth = frameDepth - 1
			upgradeButton = true	
			parent_frame = parentFrame
		}
	}
}

function GetDodgeChance()
{
	return pilotSystem.currentPower * (pilotSystem.driven ? 4 : 2) / 100
}

function Rewards()
{
	if (global.rewardScreenOn)
		return;
	if (!global.gameplayPaused)
		oGameManager.Pause()
	global.rewardScreenOn = true
	
	// Cleanup battlefield
	with (oLaserBullet)
	{
		instance_destroy(id)	
	}
	with (oLaser)
	{
		Init()
	}

	var numShipCrew = 0
	var shipCrew;
	with (oCrew)
	{
		if (playerTeam == other.playerTeam)
			shipCrew[numShipCrew++] = id
	}
	
	var numShipWeapons = 0
	var shipWeapons;
	with (oLaser)
	{
		if (playerTeam == other.playerTeam)
			shipWeapons[numShipWeapons++] = id
	}

	var rewardPopup = instance_create_layer(round(room_width / 2), round(room_height / 2), "PopUpUI", oRewardPopup)
	rewardPopup.ship = new player_ship(hullHp, maxHullHp, shieldNumber, 
									   shipCrew, numShipCrew, shipWeapons, numShipWeapons, 
									   systemsWithoutEngine, num_systems_without_engines, engineSystem)
	rewardPopup.rewards = [new RewardObj(rewardType.money, 50), new RewardObj(rewardType.repair, -1), new RewardObj(rewardType.weapon, new Weapon())]
	rewardPopup.InitNewShip()
}

function GenerateShip()
{
	maxHullHp = min(ceil(6 + global.difficulty), 30)
	pilotPower = min(floor(2 + (global.difficulty * 0.3)), 8)
	shieldNumber = min(floor(1 + (global.difficulty * 0.2)), 4)
	shieldPower = shieldNumber * 2
	for (var i = 1; i < 31; i++)
	{
		//_maxHullHp = min(ceil(6 + i), 30)
		//_pilotPower = min(floor(2 + (i * 0.3)), 8)
		//_shieldNumber = min(floor(1 + (i * 0.2)), 4)
		//print(i, ": shields=", _shieldNumber)
		//var dodge_driven = _pilotPower * 4 / 100
		//var dodge_not_driven = _pilotPower * 2 / 100
		//print(i, ": pilot=", _pilotPower, " (", dodge_not_driven, "/", dodge_driven, ")")
	}

	#region weapons
	var num_generate_weapons = 1
	if (global.difficulty <= 2)
		num_generate_weapons = 1
	else if (global.difficulty <= 6)
		num_generate_weapons = 2
	else if (global.difficulty <= 15)
		num_generate_weapons = 3
	else if (global.difficulty > 15)
		num_generate_weapons = 4

	var generatedWeapons = 0
	var weaponsReqPower = 0
	with (oLaser)
	{
		if (playerTeam == other.playerTeam)
		{
			if (generatedWeapons >= num_generate_weapons)
			{
				disabled = true
			}
			else
			{
				weaponsReqPower += reqPower
				disabled = false
				generatedWeapons++
			}
		}
	}
	//weaponsPower = min(floor(3 + (global.difficulty * 0.2)), 10)
	weaponsPower = weaponsReqPower
	with (oWeaponManager)
	{
		if (playerTeam != other.playerTeam)
			InitWeaponManager()
	}
	#endregion
	
	InitShip(-1)
	
	#region crew
	with (oCrew)
	{
		if (playerTeam == other.playerTeam)
			instance_destroy(id)
	}
	// Generate 0-2 crew member per system depending on difficulty, with a minimum total
	var crewMembers = max(1, min(ceil(global.difficulty * 0.5), num_systems * 2))
	var currentCrewMembers = 0

	for (j = 0; j < 2; j++)
	{
		for (i = 0; i < num_systems; i++)
		{
			var sys = id.systems[i]
			if (currentCrewMembers < crewMembers)
			{
				var freeTile = sys.GetFirstFreeTile()
				if (freeTile != noone)
				{
					with (instance_create_layer(freeTile.x + freeTile.sprite_width / 2, freeTile.y + freeTile.sprite_height / 2, playerTeam ? "Player_Crew" : "Enemy_Crew", oCrew))
					{
						playerTeam = other.playerTeam
						occupyingTile = freeTile
					}
					freeTile.occupied = true
					currentCrewMembers++
				}
			}
		}
	}
	#endregion
}

function SetupForCombat(forcedHullHp)
{
	if (playerTeam)
	{
		InitShip(forcedHullHp)
	}
	else
		GenerateShip()
}

SetupForCombat(-1)