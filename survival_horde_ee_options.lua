options =
{
	{
		default = 1,
		label = "Survival Victory Conditions",
		help = "",
		key = 'opt_defeat_conditions',
		pref = 'opt_defeat_conditions',
		values = {
			{ text = "A single commander must survive", help = "", key = 1, },
			{ text = "All commanders must survive", help = "", key = 2, },
		},
	},
	{
		default = 1,
		label = "Enable air waves",
		help = "Enable big waves of enemy air units (Entropy Edition adition)",
		key = 'opt_HordeAirWaves',
		pref = 'opt_HordeAirWaves',
		values = {
			{ text = "Enabled", help = "Enabled", key = 1, },
			{ text = "Disabled", help = "Disabled", key = 0, },
		},
	},
	{
		default = 1,
		label = "Auto Reclaim",
		help = "If enabled, when you kill a unit it will not leave a wreck, and you will get a fraction of its mass and energy cost",
		key = 'opt_HordeAutoReclaim',
		pref = 'opt_HordeAutoReclaim',
		values = {
			{ text = "Disabled (Wreckages On)", help = "Disabled", key = 0, },
			{ text = "10 percent", help = "10 percent", key = 10, },
			{ text = "15 percent", help = "15 percent", key = 15, },
			{ text = "20 percent", help = "20 percent", key = 20, },
			{ text = "30 percent", help = "30 percent", key = 30, },
			{ text = "40 percent", help = "40 percent", key = 40, },
			{ text = "50 percent", help = "50 percent", key = 50, },
			{ text = "75 percent", help = "75 percent", key = 75, },
			{ text = "100 percent", help = "100 percent", key = 100, },
			{ text = "200 percent", help = "200 percent", key = 200, },
			{ text = "over 9000 percent", help = "You know you want it", key = 9001, },
		},
	}
}
