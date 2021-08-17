#macro cellsize 32
#macro halfcellsize (cellsize/2)
#macro UI_titlesize 0.65

global.target_col = make_color_rgb(247, 142, 86)

#macro PlayerUI_x1 15
#macro PlayerUI_y1 30
#macro PlayerUI_x2 (room_width * .6)
#macro PlayerUI_y2 (room_height - 30)
#macro EnemyUI_x1 round(oEnemyFrame.x + 15)
#macro EnemyUI_y1 round(oEnemyFrame.y + 30)
#macro EnemyUI_x2 EnemyUI_x1 + round(oEnemyFrame.sprite_width + 30)  // this index is probably wrong (x2 is unused yet)
#macro EnemyUI_y2 EnemyUI_y1 + round(oEnemyFrame.sprite_height - 48)

#macro maxEnginePower 25
#macro maxWeaponPower 8
#macro maxPilotPower 10
#macro maxShieldPower 8