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
		default = 8,
		label = "Spawn Delay",
		help = "The time it takes for enemy units to start spawning on the map",
		key = 'opt_HordeSpawnDelay',
		pref = 'opt_HordeSpawnDelay',
		values = {
			{ text = "None", help = "Units spawn right away", key = 1 },
			{ text = "10 seconds", help = "Units spawn after 10 seconds", key = 10 },
			{ text = "20 seconds", help = "Units spawn after 20 seconds", key = 20 },
			{ text = "30 seconds", help = "Units spawn after 30 seconds", key = 30 },
			{ text = "40 seconds", help = "Units spawn after 40 seconds", key = 40 },
			{ text = "60 seconds", help = "Units spawn after 60 seconds", key = 60 },
			{ text = "70 seconds", help = "Units spawn after 70 seconds", key = 70 },
			{ text = "80 seconds", help = "Units spawn after 80 seconds", key = 80 },
			{ text = "90 seconds", help = "Units spawn after 90 seconds", key = 90 },
			{ text = "100 seconds", help = "Units spawn after 100 seconds", key = 100 },
			{ text = "110 seconds", help = "Units spawn after 110 seconds", key = 110 },
			{ text = "2 minutes", help = "Units spawn after 2 minutes", key = 120 },
			{ text = "2.5 minutes", help = "Units spawn after 2.5 minutes", key = 150 },
			{ text = "3 minutes", help = "Units spawn after 3 minutes", key = 180 },
			{ text = "4 minutes", help = "Units spawn after 4 minutes", key = 240 },
			{ text = "5 minutes", help = "Units spawn after 5 minutes", key = 300 },
			{ text = "6 minutes", help = "Units spawn after 6 minutes", key = 360 },
			{ text = "7 minutes", help = "Units spawn after 7 minutes", key = 420 },
			{ text = "8 minutes", help = "Units spawn after 8 minutes", key = 480 },
			{ text = "9 minutes", help = "Units spawn after 9 minutes", key = 540 },
			{ text = "10 minutes", help = "Units spawn after 10 minutes", key = 600 },
		},
	},
	{
		default = 7,
		label = "Health Multiplier",
		help = "Stenght of the (enemy) survival units",
		key = 'opt_HordeHealthMultiplier',
		pref = 'opt_HordeHealthMultiplier',
		values = {
			{ text = "10 percent", help = "10 percent", key = 0.1, },
			{ text = "30 percent", help = "30 percent", key = 0.3, },
			{ text = "50 percent", help = "50 percent", key = 0.5, },
			{ text = "70 percent", help = "70 percent", key = 0.7, },
			{ text = "80 percent", help = "80 percent", key = 0.8, },
			{ text = "90 percent", help = "90 percent", key = 0.9, },
			{ text = "100 percent", help = "100 percent", key = 1, },
			{ text = "110 percent", help = "110 percent", key = 1.1, },
			{ text = "120 percent", help = "120 percent", key = 1.2, },
			{ text = "130 percent", help = "130 percent", key = 1.3, },
			{ text = "140 percent", help = "140 percent", key = 1.4, },
			{ text = "150 percent", help = "150 percent", key = 1.5, },
			{ text = "160 percent", help = "160 percent", key = 1.6, },
			{ text = "170 percent", help = "170 percent", key = 1.7, },
			{ text = "180 percent", help = "180 percent", key = 1.8, },
			{ text = "190 percent", help = "190 percent", key = 1.9, },
			{ text = "200 percent", help = "200 percent", key = 2, },
			{ text = "210 percent", help = "210 percent", key = 2.1, },
			{ text = "225 percent", help = "225 percent", key = 2.25, },
			{ text = "250 percent", help = "250 percent", key = 2.5, },
			{ text = "300 percent", help = "300 percent", key = 3, },
			{ text = "305 percent", help = "305 percent", key = 3.05, },
			{ text = "310 percent", help = "310 percent", key = 3.1, },
			{ text = "320 percent", help = "320 percent", key = 3.2, },
			{ text = "330 percent", help = "330 percent", key = 3.3, },
			{ text = "340 percent", help = "340 percent", key = 3.4, },
			{ text = "350 percent", help = "350 percent", key = 3.5, },
			{ text = "360 percent", help = "360 percent", key = 3.6, },
			{ text = "370 percent", help = "370 percent", key = 3.7, },
			{ text = "380 percent", help = "380 percent", key = 3.8, },
			{ text = "390 percent", help = "390 percent", key = 3.9, },
			{ text = "400 percent", help = "400 percent", key = 4, },
			{ text = "410 percent", help = "410 percent", key = 4.1, },
			{ text = "420 percent", help = "420 percent", key = 4.2, },
			{ text = "450 percent", help = "450 percent", key = 4.5, },
			{ text = "500 percent", help = "500 percent", key = 5, },
			{ text = "750 percent", help = "750 percent", key = 7.5, },
			{ text = "10x", help = "10x", key = 10, },
			{ text = "25x", help = "25x", key = 25, },
			{ text = "100x", help = "100x", key = 100, },
            { text = "500x", help = "500x", key = 500, },
            { text = "1000x", help = "1000x", key = 1000, },
            { text = "10000x", help = "Labs are the new GCs", key = 10000, },
		},
	},
    {
        default = 7,
        label = "Damage Multiplier",
        help = "Damage dealt by the (enemy) survival units",
        key = 'opt_HordeDamageMultiplier',
        pref = 'opt_HordeDamageMultiplier',
        values = {
            { text = "10 percent", help = "10 percent", key = 0.1, },
            { text = "30 percent", help = "30 percent", key = 0.3, },
            { text = "50 percent", help = "50 percent", key = 0.5, },
            { text = "70 percent", help = "70 percent", key = 0.7, },
            { text = "80 percent", help = "80 percent", key = 0.8, },
            { text = "90 percent", help = "90 percent", key = 0.9, },
            { text = "100 percent", help = "100 percent", key = 1, },
            { text = "110 percent", help = "110 percent", key = 1.1, },
            { text = "120 percent", help = "120 percent", key = 1.2, },
            { text = "130 percent", help = "130 percent", key = 1.3, },
            { text = "140 percent", help = "140 percent", key = 1.4, },
            { text = "150 percent", help = "150 percent", key = 1.5, },
            { text = "160 percent", help = "160 percent", key = 1.6, },
            { text = "170 percent", help = "170 percent", key = 1.7, },
            { text = "180 percent", help = "180 percent", key = 1.8, },
            { text = "190 percent", help = "190 percent", key = 1.9, },
            { text = "200 percent", help = "200 percent", key = 2, },
            { text = "210 percent", help = "210 percent", key = 2.1, },
            { text = "225 percent", help = "225 percent", key = 2.25, },
            { text = "250 percent", help = "250 percent", key = 2.5, },
            { text = "300 percent", help = "300 percent", key = 3, },
            { text = "305 percent", help = "305 percent", key = 3.05, },
            { text = "310 percent", help = "310 percent", key = 3.1, },
            { text = "320 percent", help = "320 percent", key = 3.2, },
            { text = "330 percent", help = "330 percent", key = 3.3, },
            { text = "340 percent", help = "340 percent", key = 3.4, },
            { text = "350 percent", help = "350 percent", key = 3.5, },
            { text = "360 percent", help = "360 percent", key = 3.6, },
            { text = "370 percent", help = "370 percent", key = 3.7, },
            { text = "380 percent", help = "380 percent", key = 3.8, },
            { text = "390 percent", help = "390 percent", key = 3.9, },
            { text = "400 percent", help = "400 percent", key = 4, },
            { text = "410 percent", help = "410 percent", key = 4.1, },
            { text = "420 percent", help = "420 percent", key = 4.2, },
            { text = "450 percent", help = "450 percent", key = 4.5, },
            { text = "500 percent", help = "500 percent", key = 5, },
            { text = "750 percent", help = "750 percent", key = 7.5, },
            { text = "10x", help = "10x", key = 10, },
            { text = "25x", help = "25x", key = 25, },
            { text = "100x", help = "100x", key = 100, },
            { text = "500x", help = "500x", key = 500, },
            { text = "1000x", help = "1000x", key = 1000, },
            { text = "10000x", help = "Because scouts should obviously one-shot ACUs!", key = 10000, },
        },
    },
	{
		default = 1,
		label = "Auto Reclaim",
		help = "If enabled, when you kill a survival unit it will not leave a wreck, and you will get a fraction of its mass and energy cost",
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
	},
	{
		default = 1,
		label = "Extra air waves",
		help = "Enable big waves of enemy air units (Entropy Edition addition)",
		key = 'opt_HordeAirWaves',
		pref = 'opt_HordeAirWaves',
		values = {
			{ text = "Enabled", help = "Enabled", key = 1, },
			{ text = "Disabled", help = "Disabled", key = 0, },
		},
	},
}
