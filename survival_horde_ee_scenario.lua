version = 3
ScenarioInfo = {
  map_version=21,
  name = 'Survival Horde EE',
  description = [[Spino-ff of the popular Survival Horde map.

You are sent on a stealth mission deep in enemy territory. The situation turns dire when the enemy finds out about your plans.
Vastly outnumbered, you start preparing for the last stand.

Works with 1-4 player (unoccupied lanes are disabled, resources are spawned according to players).

Difficulty: Pretty hard (though you can adjust it with lobby options)

Survival Horde was created by Mikzau. EE version changes by Entropy Wins.
]],
  type = 'skirmish',
  starts = true,
  preview = '',
  size = {512, 512},
  map = '/maps/survival_horde_ee.v0021/survival_horde_ee.scmap',
  save = '/maps/survival_horde_ee.v0021/survival_horde_ee_save.lua',
  script = '/maps/survival_horde_ee.v0021/survival_horde_ee_script.lua',
  norushradius = 80,
  Configurations = {
    ['standard'] = {
      teams = {
        {
          name = 'FFA',
          armies = {'ARMY_1', 'ARMY_2', 'ARMY_3', 'ARMY_4'},
        },
      },
      customprops = {
        ['ExtraArmies'] = STRING( 'Player ARMY_SURVIVAL_ENEMY' ),
      },
    },
  },
  norushoffsetX_ARMY_1 = 0,
  norushoffsetY_ARMY_1 = 0,
  norushoffsetX_ARMY_2 = 0,
  norushoffsetY_ARMY_2 = 0,
  norushoffsetX_ARMY_3 = 0,
  norushoffsetY_ARMY_3 = 0,
  norushoffsetX_ARMY_4 = 0,
  norushoffsetY_ARMY_4 = 0,
  norushoffsetX_ARMY_5 = 0,
  norushoffsetY_ARMY_5 = 0,
}
