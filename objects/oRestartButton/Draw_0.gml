draw_self()

DrawCenterOn()
var c = c_black
if (hovered)
	c = global.target_col
var text = upgradeButton || continueButton ? "Continue" : global.textId.restartButton
if (nextRoomButton)
	text = "Start"
draw_text_transformed_color(round(x + w / 2), round(y + h / 2),
							text, 0.65, 0.65, 0, c, c, c, c, 1)
DrawCenterOff()