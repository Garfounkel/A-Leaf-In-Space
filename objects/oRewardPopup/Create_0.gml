draw_set_font(fnt_m5x7);

saved_money = global.money

canPlayHoveringSound = true
last_hovered_index = -1
current_hovered_index = -2

engineCost = 25

rewardsNum = 3
rewards = [new RewardObj(rewardType.money, 50), new RewardObj(rewardType.repair, -1), new RewardObj(rewardType.weapon, new Weapon())]
rewards_bb[0] = [0, 0, 0, 0]; rewards_bb[1] = [0, 0, 0, 0]; rewards_bb[2] = [0, 0, 0, 0];
hovering_rewards = [false, false, false]
took_reward = false
took_reward_index = -1

weaponNum = 4
hovering_weapon = [false, false, false, false]
bb_weapons = [[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]]

ship = noone
new_ship = {
	systemsPower : ds_map_create(),
	weapons : ds_map_create(),
	hullHp : 10  // Put 10 as a decent default in case of a bug but it should always be overriden anyway
}

hovering_systems_map = ds_map_create()
bb_systems_map = ds_map_create()

function InitNewShip()
{
	new_ship.hullHp = ship.hullHp
	ds_map_add(new_ship.systemsPower, ship.engineSystem, ship.engineSystem.maxPower)
	ds_map_add(hovering_systems_map, ship.engineSystem, false)
	for (var i = 0; i < ship.numSystems; i++)
	{
		ds_map_add(new_ship.systemsPower, ship.systems_without_engine[i], ship.systems_without_engine[i].maxPower)
		ds_map_add(hovering_systems_map, ship.systems_without_engine[i], false)
		ds_map_add(bb_systems_map, ship.systems_without_engine[i], [0, 0, 0, 0])
	}
	
	for (var i = 0; i < ship.numWeapons; i++)
	{
		var state = ship.weapons[i].disabled ? weaponState.empty : weaponState.oldWeapon
		ds_map_add(new_ship.weapons, ship.weapons[i], new WeaponObj(state, ship.weapons[i]))
	}
}

swap = true
debug = false

active_tab = 0
hovering_tab_index = -1

tabs_num = 3
tabs[tab_id.Upgrade] = "Upgrades"; tabs[tab_id.Crew] = "Crew"; tabs[tab_id.Equipment] = "Weapons";
tabs_bb[0] = [0, 0, 0, 0]; tabs_bb[1] = [0, 0, 0, 0]; tabs_bb[2] = [0, 0, 0, 0];

engine_bb = [0, 0, 0, 0];

confirm_bb = [0, 0, 0, 0];
hovering_confirm = false

undo_bb = [0, 0, 0, 0];
hovering_undo = false

sys_x_offset = 32
sys_y_offset = 6
sys_size_x = 16
sys_size_y = 4
sys_margin = 4


function draw_popup_background(x1, y1, x2, y2, tint, forceThin)
{
	if (is_undefined(tint))
		tint = c_white
	if (is_undefined(forceThin))
		forceThin = false
	if (swap && !forceThin)
		draw_sprite_stretched_ext(sPopupFrameTransparent, 0, x1, y1, abs(x2-x1), abs(y2-y1), tint, 1)
	else
		draw_rounded_box_outline(x1, y1, x2, y2, 10, c_black, 0.8, tint)
}

function draw_title_box(x1, y1, x2, y2, text, tint, forceThin)
{
	if (is_undefined(tint))
		tint = c_white
	if (is_undefined(forceThin))
		forceThin = false
	draw_popup_background(x1, y1, x2, y2, tint, forceThin)
	draw_text_color(x1+20, y1+10, text, tint, tint, tint, tint, 1)
}

function my_draw_button(x1, y1, x2, y2, text, bg_col, outline_col, text_col)
{
	draw_rounded_box_outline(x1, y1, x2, y2, 5, bg_col, 1, outline_col)
	var center = get_center(x1, y1, x2, y2)
	Draw_text_color_centered(center.xx, center.yy, text, text_col, 1)
}

function draw_tab_button(x1, y1, x2, y2, text, active, index)
{
	var col = c_white
	print(text, hovering_tab_index, index)
	if (hovering_tab_index == index && !active)
		col = global.target_col
	my_draw_button(x1, y1, x2, y2, text, c_dkgrey, col, col)
	if (!active)
		draw_roundex_box_alpha(x1-1, y1-1, x2+1, y2+1, 5, c_black, 0.5, false)
}

function draw_tabs_selector(x1, y1)
{
	// tab selector
	var x2;
	var y2;
	for (var i = 0; i < tabs_num; i++)
	{
		if (tabs[i] == tabs[tab_id.Crew])
			continue;
		x2 = round(x1 + string_width(tabs[i]) + 20)
		y2 = y1 + 30
		draw_tab_button(x1, y1, x2, y2, tabs[i], i == active_tab, i)
		tabs_bb[i] = [x1, y1, x2, y2]
		x1 = x2 + 10
	}
}

function draw_reward(x1, y1, x2, reward, reward_index)
{
	var tint = c_white
	if (hovering_rewards[reward_index] || took_reward_index == reward_index)
		tint = global.target_col

	y2 = 0
	if (reward.type == rewardType.money)
	{
		y2 = y1+50
		draw_rounded_box_outline(x1, y1, x2, y2, 5, c_dkgrey, 1, tint)
		var center = get_center(x1, y1, x2, y2)
		Draw_text_color_centered(center.xx, center.yy, "$" + string(reward.value), tint, 1)
	}
	else if (reward.type == rewardType.repair)
	{
		y2 = y1+50
		draw_rounded_box_outline(x1, y1, x2, y2, 5, c_dkgrey, 1, tint)
		var center = get_center(x1, y1, x2, y2)
		Draw_text_color_centered(center.xx, center.yy, "Repair hull " + string(ship.hullHp) + "/" + string(ship.maxHullHp), tint, 1)
	}
	else if (reward.type == rewardType.weapon)
	{
		var xy12 = draw_weapon(x1, y1, reward.value, hovering_rewards[reward_index], true, abs(x2-x1))
		y2 = xy12[3]
	}
	
	if (took_reward)
	{
		draw_roundex_box_alpha(x1-1, y1-1, x2+1, y2+1, 5, c_black, 0.5, false)
	}
	
	rewards_bb[reward_index] = [x1, y1, x2, y2]
	return [x2, y2]
}

function draw_rewards(x1, y1, x2, y2, rewards)
{
	draw_title_box(x1, y1, x2, y2, "Rewards (choose one)")
	
	y1 += 30
	var y_offset = 10
	for (var i = 0; i < rewardsNum; i++)
	{
		var new_xy2 = draw_reward(x1+15, y1 + y_offset, x2-15, rewards[i], i)
		y1 = new_xy2[1]
	}
}

function draw_system_bar(xx1, yy1, xx2, yy2, sys, currentBar)
{
	if (currentBar < sys.maxPower)
		Draw_rectangle_color(xx1, yy1, xx2, yy2, global.color.hp, false)
	else if (new_ship.systemsPower[? sys] > currentBar)
		Draw_rectangle_color(xx1, yy1, xx2, yy2, global.target_col, false)
	Draw_rectangle_color(xx1, yy1, xx2, yy2, global.color.hpBg, true)
}

function draw_system(x1, y1, sys)
{
	var tint = c_white
	if (hovering_systems_map[? sys])
		tint = global.target_col
	var x2 = x1 + 70
	var y2 = y1 + 150
	var dollars = "$" + string(sys.Cost(new_ship.systemsPower[? sys]))
	draw_title_box(x1, y1, x2, y2, "", tint, true)
	bb_systems_map[? sys] = [x1, y1, x2, y2]
	var center = get_center(x1, y1, x2, y2)

	Draw_text_color_centered(center.xx, y1 + 15, dollars, tint, 1)

	var xx = round(center.xx - (sys_size_x/2))
	var yy = y2 - 35
	var currentBar = 0
	for (var i = 0; i < sys.limitPower; i++)
	{
		var xx1 = xx
		var yy1 = yy - (sys_y_offset * i)
		var xx2 = xx1 + sys_size_x
		var yy2 = yy1 + sys_size_y
		draw_system_bar(xx1, yy1, xx2, yy2, sys, currentBar)
		currentBar++
	}
	Draw_text_color_centered(center.xx, y2 - 15, sys.abrev, tint, 1)
}

function draw_upgrades(x1, y1, x2, y2, ship)
{
	//draw_text(x1+20, y1+10, "Funds: $" + string(global.money))

	#region draw engine power
	x1 += 30
	y1 += 50
	var tint = c_white
	if (hovering_systems_map[? ship.engineSystem])
		tint = global.target_col
	draw_title_box(x1, y1, x1 + 200, y1 + 100, "Engine   $" + string(engineCost), tint, true)
	engine_bb = [x1, y1, x1 + 200, y1 + 100]
	y1 += 50

	var xx = x1 + 30
	var yy = y1 + 20

	var currentBar = 0
	for (var i = 0; i < (maxEnginePower / 5); i++)
	{
		for (var j = 0; j < 5; j++)
		{
			var xx1 = xx + (sys_x_offset * i)
			var yy1 = yy - (sys_y_offset * j)
			var xx2 = xx1 + sys_size_x
			var yy2 = yy1 + sys_size_y
			draw_system_bar(xx1, yy1, xx2, yy2, ship.engineSystem, currentBar)
			currentBar++
		}
	}
	#endregion

	// draw systems
	var offset = 75
	for (var i = 0; i < ship.numSystems; i++)
	{
		draw_system(x1 + (i * offset), y1+60, ship.systems_without_engine[i])
	}
}

function draw_crew(x1, y1, x2, y2, ship)
{
	var x_offset = 20
	x1 += 30
	y1 += 30
	for (var i = 0; i < ship.numCrew; i++)
	{
		draw_sprite(ship.crew[i].sprite_index, 0, x1 + (i*x_offset), y1)
	}
}

function draw_weapon_line(x1, y1, i, text, col)
{
	Draw_text_color_size(round(x1), round(y1 + (15*i)), text, col, 1, 0.5)
}

function draw_weapon(x1, y1, weapon, hovering, blueprint, blueprint_offset)
{
	var offset = 150

	if (is_undefined(blueprint))
	{
		blueprint_offset = offset
		blueprint = false
	}

	var x2 = blueprint ? x1 + blueprint_offset : x1 + offset
	var y2 = y1 + offset
	var col = c_white
	var textcol = c_white
	if (hovering)
		if (!blueprint)
			col = global.color.systemDestroyed
		else
		{
			col = global.target_col
			textcol = global.target_col
		}
	
	draw_rounded_box_outline(x1, y1, x2, y2, 5, c_black, 0.5, col)

	if (weapon != noone)
	{
		var emptyCheck = true
		var disabledCheck = true
		if (!blueprint)
		{
			emptyCheck = (new_ship.weapons[? weapon].state != weaponState.empty)
			if (new_ship.weapons[? weapon].state == weaponState.oldWeapon)
				disabledCheck = !weapon.disabled
			if (new_ship.weapons[? weapon].state == weaponState.newWeapon)
				weapon = new_ship.weapons[? weapon].value
		}

		if (emptyCheck && disabledCheck)
		{
			var xx1 = x1 + 15
			var yy1 = y1 + 15
			//var title_y2 = y1 + weapon.sprite_height + 10
			var title_y2 = y1 + 32 + 10
			draw_rounded_box_outline(x1, y1, x2, title_y2, 5, c_white, 0.3, col)
			var center_title = get_center(x1, y1, x2, title_y2)
			
			if (blueprint)  // centered
			{
				draw_sprite_ext(weapon.sprite_index, 0, x2 - 15, center_title.yy, 1, 1, 0, c_white, 1)
				Draw_text_color_size_centered(xx1+(string_width(weapon.weapon_name)/2), center_title.yy, weapon.weapon_name, textcol, 1, 0.65)
			}
			else  // cornered
			{
				draw_sprite_ext(weapon.sprite_index, 0, x2 - 5, y1 + 20, 1, 1, 0, c_white, 1)
				Draw_text_color_size_centered(xx1+(string_width(weapon.weapon_name)/4), title_y2 - 10, weapon.weapon_name, textcol, 1, 0.65)
			}

			if (!hovering || blueprint)
			{
				var i = 2
				draw_weapon_line(xx1, yy1, i++, "Hull damage: " + string(weapon.damage_per_shoot), textcol)
				draw_weapon_line(xx1, yy1, i++, "Shield damage: " + string(weapon.shieldDamage), textcol)
				draw_weapon_line(xx1, yy1, i++, "Room damage: " + string(weapon.systemDamage), textcol)
				draw_weapon_line(xx1, yy1, i++, "Crew damage: " + string(weapon.crewDamage), textcol)
				draw_weapon_line(xx1, yy1, i++, "Reload time (sec): " + string(weapon.reload_time_sec), textcol)
				draw_weapon_line(xx1, yy1, i++, "Shoot per salve: " + string(weapon.shoot_per_fire), textcol)
				draw_weapon_line(xx1, yy1, i++, "Required power: " + string(weapon.reqPower), textcol)
			}
			else
			{
				var center = get_center(x1, title_y2, x2, y2)
				var word = blueprint ? "Buy $" : "Sell $"
				Draw_text_color_centered(center.xx, center.yy, word + string(weapon.price), col, 1)
			}
		}
	}
	return [x1, y1, x2, y2]
}

function draw_equipment(x1, y1, x2, y2, ship)
{
	var x_offset = 30
	var y_offset = 10
	var center = get_center(x1, y1, x2, y2)
	x1 = center.xx - ((150*2 + x_offset) / 2)
	y1 += 10
	xx1 = x1
	yy1 = y1
	var currentWeap = 0
	var offset = 150
	for (var i = 0; i < 2; i++)
	{
		for (var j = 0; j < 2; j++)
		{
			xx1 = x1 + ((offset + x_offset) * j)
			yy1 = y1 + ((offset + y_offset) * i)
			var weapon = noone
			if (currentWeap < ship.numWeapons)
				weapon = ship.weapons[currentWeap]
			var bb = draw_weapon(xx1, yy1, weapon, hovering_weapon[currentWeap])
			if (weapon != noone)
				if (new_ship.weapons[? weapon].state == weaponState.newWeapon)
					draw_roundex_box_alpha(bb[0]-1, bb[1]-1, bb[2]+1, bb[3]+1, 5, c_black, 0.5, false)
			bb_weapons[currentWeap] = bb
			currentWeap++
		}
	}
}

function draw_ship_inventory(x1, y1, x2, y2, ship)
{
	if (ship == noone)
		return;

	//draw_text(x1+20, y1+10, "Funds: $" + string(global.money))
	var title = "Funds: $" + string(global.money)
	draw_title_box(x1, y1, x2, y2, title)
	
	draw_tabs_selector(x1 + string_width(title) + 50, y1 + 10)
	
	var tab_x1 = x1 + 20
	var tab_y1 = y1 + 40
	var tab_x2 = x2 - 20
	var tab_y2 = y2 - 20
	
	draw_rounded_box_outline(tab_x1, tab_y1, tab_x2, tab_y2, 5, c_dkgrey, 1, c_white)

	if (active_tab == tab_id.Upgrade)
		draw_upgrades(tab_x1, tab_y1, tab_x2, tab_y2, ship)
	else if (active_tab == tab_id.Crew)
		draw_crew(tab_x1, tab_y1, tab_x2, tab_y2, ship)
	else if (active_tab == tab_id.Equipment)
		draw_equipment(tab_x1, tab_y1, tab_x2, tab_y2, ship)

	var center = get_center(x1, y1, x2, y2)
	both_buttons_x1 = center.xx-170
	first_button_x2 = both_buttons_x1 + 80
	both_buttons_x2 = center.xx+170
	confirm_bb = [first_button_x2 + 5, y2 - 40, both_buttons_x2, y2 + 10]
	var col = c_white
	if (hovering_confirm)
		col = global.target_col
	my_draw_button(confirm_bb[0], confirm_bb[1], confirm_bb[2], confirm_bb[3], "Confirm and continue", 
				   c_black, col, col)

	undo_bb = [both_buttons_x1, y2 - 40, first_button_x2, y2 + 10]
	var col = c_white
	if (hovering_undo)
		col = global.target_col
	my_draw_button(undo_bb[0], undo_bb[1], undo_bb[2], undo_bb[3], "Undo", 
				   c_black, col, col)
}

function interact_upgrade_system(sys, bb, cost, cost_before)
{
	if (point_in_rectangle(mouse_x, mouse_y, bb[0], bb[1], bb[2], bb[3]))
	{
		hovering_systems_map[? sys] = true
		if (mouse_check_button_released(mb_right))
		{
			if (new_ship.systemsPower[? sys] < sys.limitPower && global.money >= cost)
			{
				new_ship.systemsPower[? sys]++
				global.money -= cost
				PlaySound(sndSystemEnergy)
			}
		}
		else if (mouse_check_button_released(mb_left))
		{
			if (new_ship.systemsPower[? sys] > sys.maxPower)
			{
				new_ship.systemsPower[? sys]--
				global.money += cost_before
				PlaySound(sndSystemEnergy)
			}
		}
	}
	else
		hovering_systems_map[? sys] = false
}

function Took_A_Reward(index)
{
	PlayMouseClickSound()
	took_reward = true
	took_reward_index = index
	hovering_rewards[index] = false
}

function interact_reward(reward, bb, index)
{
	if (point_in_rectangle(mouse_x, mouse_y, bb[0], bb[1], bb[2], bb[3]))
	{
		hovering_rewards[index] = true
		if (mouse_check_button_released(mb_left))
		{
			if (reward.type == rewardType.money)
			{
				global.money += reward.value
				Took_A_Reward(index)
			}
			else if (reward.type == rewardType.repair)
			{
				new_ship.hullHp = ship.maxHullHp
				Took_A_Reward(index)
				with (oShipController)
					if (playerTeam)
						hullHp = other.new_ship.hullHp
			}
			else if (reward.type == rewardType.weapon)
			{
				var i;
				for (i = 0; i < 4; i++)
				{
					if (new_ship.weapons[? ship.weapons[i]].state == weaponState.empty)
					{
						new_ship.weapons[? ship.weapons[i]].state = weaponState.newWeapon
						new_ship.weapons[? ship.weapons[i]].value = reward.value
						//new_ship.weapons[? ship.weapons[i]].value = reward.value
						Took_A_Reward(index)
						break;
					}
				}
				if (i >= 4)
					print("No weapon slot, sell one first")
			}
		}
	}
	else
		hovering_rewards[index] = false
}

function interact_weapon(weapon, bb, index)
{
	if (new_ship.weapons[? weapon].state == weaponState.oldWeapon)
	{
		if (point_in_rectangle(mouse_x, mouse_y, bb[0], bb[1], bb[2], bb[3]))
		{
			hovering_weapon[index] = true
			if (mouse_check_button_released(mb_left))
			{
				global.money += weapon.price
				new_ship.weapons[? weapon].state = weaponState.empty
				PlayMouseClickSound()
			}
		}
		else
			hovering_weapon[index] = false
	}
	else
		hovering_weapon[index] = false
}

function Confirm()
{
	PlayMouseClickSound()
	var playerShipController;
	with (oShipController)
		if (playerTeam)
			playerShipController = id

	playerShipController.maxPower = new_ship.systemsPower[? ship.engineSystem]
	for (var i = 0; i < ship.numSystems; i++)
	{
		var sys = ship.systems_without_engine[i]
		if (sys.system == systems.shield)
			playerShipController.shieldPower = new_ship.systemsPower[? sys]
		else if (sys.system == systems.pilot)
			playerShipController.pilotPower = new_ship.systemsPower[? sys]
		else if (sys.system == systems.weapon)
			playerShipController.weaponsPower = new_ship.systemsPower[? sys]
	}

	for (var i = 0; i < ship.numWeapons; i++)
	{
		var weap = ship.weapons[i]
		if 	(new_ship.weapons[? weap].state == weaponState.newWeapon)
		{
			var newWeap = new_ship.weapons[? weap].value
			with (weap)
			{
				sprite_index = newWeap.sprite_index
				weapon_name = newWeap.weapon_name
				damage_per_shoot = newWeap.damage_per_shoot
				shieldDamage = newWeap.shieldDamage 
				systemDamage = newWeap.systemDamage
				crewDamage = newWeap.crewDamage
				reload_time_sec = newWeap.reload_time_sec
				shoot_per_fire = newWeap.shoot_per_fire
				reqPower = newWeap.reqPower
				price = newWeap.price
				disabled = false
				level = newWeap.shoot_per_fire
				Init()
			}
		}
		else if	(new_ship.weapons[? weap].state == weaponState.empty)
		{
			weap.disabled = true	
		}
	}

	with (oShipController)
	{
		if (playerTeam)
			SetupForCombat(other.new_ship.hullHp)
		else
			SetupForCombat(-1)
	}

	global.rewardScreenOn = false
	instance_destroy(id)
}

function Undo()
{
	PlayMouseClickSound()
	global.money = saved_money
	with (oShipController)
		if (playerTeam)
			hullHp = other.ship.hullHp
	var rewardPopup = instance_create_layer(round(room_width / 2), round(room_height / 2), "PopUpUI", oRewardPopup)
	rewardPopup.ship = ship
	rewardPopup.InitNewShip()
	rewardPopup.rewards = rewards
	instance_destroy(id)
}

function IsHoveringSomething()
{
	current_hovered_index = 0
	if (hovering_confirm)
		return true; 
	
	current_hovered_index++
	if (hovering_undo)
		return true;
	
	for (var i = 0; i < rewardsNum; i++)
	{
		current_hovered_index++
		if (hovering_rewards[i])
			return true;
	}

	for (var i = 0; i < weaponNum; i++)
	{
		current_hovered_index++
		if (hovering_weapon[i])
			return true;
	}

	current_hovered_index++
	if (hovering_systems_map[? ship.engineSystem])
		return true;

	for (var i = 0; i < ship.numSystems; i++)
	{
		current_hovered_index++
		if (hovering_systems_map[? ship.systems_without_engine[i]])
			return true;
	}
	
	current_hovered_index += (hovering_tab_index + 1)  // starting from -1, no tab = 0, first tab = +1, second tab = +2, ect...
	if (hovering_tab_index != -1)
		return true;
	
	last_hovered_index = -1
	return false;
}