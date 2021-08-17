stars_amount = 100
stars = ds_grid_create(2,stars_amount)
distance = 20
anim_inc = 0
anim_amount = 270

function Star (spr, sz, r, c, a, spe) constructor
{
	sprite = spr;
	size = sz;
	rot = r;
	col = c;
	alpha = a;
	speed = spe;
}

pink = make_color_rgb(252,141,252)
deepblue = make_color_rgb(94,107,192)
lightblue = make_color_rgb(167,170,250)
purple = make_color_rgb(106,82,163)
whiteblue = make_color_rgb(167,170,250)
white = c_white
whitegreen = make_color_rgb(206,253,240)
whiteblue  = make_color_rgb(175,191,245)


for (i=0; i<stars_amount ; i++) {
    xx = irandom(640)
    yy = irandom(480)
    ds_grid_set(stars,0,i, xx)  //X pos
    ds_grid_set(stars,1,i, yy)  //Y pos
	spr = choose(sStar_0, sStar_1, sStar_1, sStar_2, sStar_3, sStar_4)
	col = choose(pink, lightblue, deepblue, purple, 
				 white, white, white, // x3
				 whiteblue, whiteblue, // x2
				 whitegreen, whitegreen)  // x2
	if (i == stars_amount - 1)
	{
		//sprites[i] = new Star(sPlanet, 4, 0, c_white, 255, 0.02)
		sprites[i] = new Star(sPlanetHd, 0.4, 0, c_white, 255, 0.02)
	}
	else
		sprites[i] = new Star(spr, random(1), 0, col, random_range(150, 255), random_range(0.5, 1))
}


for (i=0; i<stars_amount ; i++) {
	if (i == stars_amount - 1)  // Planet code
	{
		ds_grid_set(stars, 0, i, room_width / 2)  //X pos
        ds_grid_set(stars, 1, i, room_height / 2)  //Y pos
		continue
	}
    for (j=0; j<i ; j++) {
        if (i = j) continue;
        x1 = ds_grid_get(stars,0,i)
        y1 = ds_grid_get(stars,1,i)
        x2 = ds_grid_get(stars,0,j)
        y2 = ds_grid_get(stars,1,j)
        if (sqrt(sqr(x2-x1) + sqr(y2-y1)) <distance) {
            xx = irandom(640)
            yy = irandom(480)
            ds_grid_set(stars,0,i, xx)  //X pos
            ds_grid_set(stars,1,i, yy)  //Y pos
            i -= 1
            j = i
        }
    }
}
