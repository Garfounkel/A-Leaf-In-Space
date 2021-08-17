if (global.cheatcode_enabled && keyboard_check_pressed(ord("S")))
	swap = !swap
	
if (global.cheatcode_enabled && keyboard_check_pressed(ord("D")))
	debug = !debug

// Tabs buttons
var not_hovering_tab = true
for (i = 0; i < tabs_num; i++)
{
	var bb = tabs_bb[i]
	if (point_in_rectangle(mouse_x, mouse_y, bb[0], bb[1], bb[2], bb[3]))
	{
		if (mouse_check_button_released(mb_left))
		{
			active_tab = i
			PlayMouseClickSound()
		}
		
		if (active_tab != i)
		{
			hovering_tab_index = i
			not_hovering_tab = false	
		}
	}
}
if (not_hovering_tab)
	hovering_tab_index = -1

if (active_tab == tab_id.Upgrade)
{
	var bb = engine_bb
	interact_upgrade_system(ship.engineSystem, bb, engineCost, engineCost)
	for (var i = 0; i < ship.numSystems; i++)
	{
		var sys = ship.systems_without_engine[i]
		var bb = bb_systems_map[? sys]
		interact_upgrade_system(sys, bb, sys.Cost(new_ship.systemsPower[? sys]), sys.Cost(new_ship.systemsPower[? sys]-1))
	}
}
else if (active_tab == tab_id.Equipment)
{
	for (var i = 0; i < ship.numWeapons; i++)
	{
		var weap = ship.weapons[i]
		var bb = bb_weapons[i]
		interact_weapon(weap, bb, i)
	}
}

if (!took_reward)
{
	for (var i = 0; i < rewardsNum; i++)
	{
		var reward = rewards[i]
		var bb = rewards_bb[i]
		interact_reward(reward, bb, i)
	}
}

// Confirm button
var bb = confirm_bb
if (point_in_rectangle(mouse_x, mouse_y, bb[0], bb[1], bb[2], bb[3]))
{
	hovering_confirm = true
	if (mouse_check_button_released(mb_left))
	{
		Confirm()
	}
}
else
	hovering_confirm = false

// Undo button
var bb = undo_bb
if (point_in_rectangle(mouse_x, mouse_y, bb[0], bb[1], bb[2], bb[3]))
{
	hovering_undo = true
	if (mouse_check_button_released(mb_left))
	{
		Undo()
	}
}
else
	hovering_undo = false


if (IsHoveringSomething())
{
	if (canPlayHoveringSound)
	{
		PlayMouseHoverSound()
		canPlayHoveringSound = false
		last_hovered_index = current_hovered_index
	}
}
else  // hovering nothing
	canPlayHoveringSound = true

if (last_hovered_index != current_hovered_index)
	canPlayHoveringSound = true
