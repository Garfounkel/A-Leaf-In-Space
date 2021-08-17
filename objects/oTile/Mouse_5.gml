with (oCrew)
{
	var crew = id;
	if (selected)
	{
		if (other.linked_system == noone)
			other.MoveCrew(other, crew);
		else
		{
			with (other.linked_system)
			{
				if (CrewIsInside(crew))
					return;
				for (var i = 0; i < num_tiles; ++i;)
				{
					var tile = tiles[| i];
					if (tile.occupied)
						continue;
					tile.MoveCrew(tile, crew);
				}
			}
		}
	}
}