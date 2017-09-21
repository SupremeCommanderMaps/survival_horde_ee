local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local Utilities = import('/lua/utilities.lua')
local AIUtils = import('/lua/AI/aiutilities.lua')
local ScenarioPlatoonAI = import('/lua/ScenarioPlatoonAI.lua')
local Objectives = import('/lua/ScenarioFramework.lua').Objectives
local SimObjects = import('/lua/SimObjectives.lua')

local OccupiedArmies = {}



--NAME: Survival Horde

--There was supposed to be 5th player on the middle (this script supports 5th player, only 5th spawn is missing) but I didn't bother to create waves for the fifth player.
--There was also supposed to be transport drops (which are working perfectly) but it would've been too difficult for players to deal with because land waves are so strong. Maybe for fifth player if I ever create the fifth player.
--Thanks for the other survival map creators for giving me some ideas! (survival escape, fifth dimension, mycelium)




--LISTING WAYPOINTS FOR UNIT NAVIGATION

local LandWaypoints1 = {"R1Path01", "R1Path02", "R1Path03", "R1Path04", "R1Path05", "PlayerSpawn_1"}
local LandCenter = {"PlayerSpawn_1", "PlayerSpawn_2", "PlayerSpawn_3",  "PlayerSpawn_4", "PatrolBase_5", "PatrolBase_6", "PatrolBase_7", "PatrolBase_8", "TransportDrop05"}
local LandWaypoints2 = {"R2Path01", "R2Path02", "R2Path03", "R2Path04", "R2Path05", "PlayerSpawn_2"}
local LandWaypoints3 = {"R3Path01", "R3Path02", "R3Path03", "R3Path04", "R3Path05", "PlayerSpawn_3"}
local LandWaypoints4 = {"R4Path01", "R4Path02", "R4Path03", "R4Path04", "R4Path05", "PlayerSpawn_4"}
local CenterSpawns = {"PlayerSpawn_1", "PlayerSpawn_2", "PlayerSpawn_3",  "PlayerSpawn_4", "PatrolBase_5"}


local LandWaypoints1Form = {"R1Path01Form", "R1Path02Form", "PlayerSpawn_1"}
local LandWaypoints2Form = {"R2Path05", "PlayerSpawn_2"}
local LandWaypoints3Form = {"R3Path02", "R3Path05", "PlayerSpawn_3"}
local LandWaypoints4Form = {"R4Path02", "PlayerSpawn_4"}


local DestroyerLocations = {"DestroyerSpot1", "DestroyerSpot2", "DestroyerSpot3"}
local NavyLocation = {"BattleshipSpot1"}
local AllEnemySpawns = {"Survival_LandSpawn1", "Survival_LandSpawn2", "Survival_LandSpawn3", "Survival_LandSpawn4", "Survival_Spawn1", "Survival_Spawn4"}
local AllTransportSpawns = {"Survival_LandSpawn1", "Survival_LandSpawn3", "Survival_LandSpawn4", "Survival_Spawn1", "Survival_Spawn4"}
local LandWaypoints5Destroyer = {"R1Path03", "R1Path04", "R1Path05", "PlayerSpawn_1"}
local LandWaypoints6Destroyer = {"R3Path05", "PlayerSpawn_3"}
local LandWaypoints7DestroyerA = {"R4Path01", "R4Path02", "R4Path03", "R4Path04", "DestroyerSpot1"}
local LandWaypoints7DestroyerB = {"R4Path01", "R4Path02", "R4Path03", "R4Path04", "DestroyerSpot1", "DestroyerSpot2"}
local LandWaypoints7DestroyerC = {"R4Path01", "R4Path02", "R4Path03", "R4Path04", "DestroyerSpot1", "DestroyerSpot2", "DestroyerSpot3"}
local LandWaypoints7DestroyerAEnd = {"DestroyerSpot2", "DestroyerSpot3"}
local LandWaypoints7DestroyerBEnd = {"DestroyerSpot3", "DestroyerSpot2", "DestroyerSpot1"}
local LandWaypoints7DestroyerCEnd = {"DestroyerSpot2", "DestroyerSpot1", "DestroyerSpot2"}



local TransportRoute1 = {"TransportPath01", "TransportPath06"} --TransportDrop04
local TransportRoute2 = {"TransportPath01", "TransportPath06", "TransportPath10", "TransportPath11", "TransportPath18"} --TransportDrop04
local TransportRoute3 = {"TransportPath01", "TransportPath06", "TransportPath10", "TransportPath11", "TransportPath18", "TransportPath19"} --TransportDrop05
local TransportRoute4 = {"TransportPath02"} --TransportDrop01
local TransportRoute5 = {"TransportPath03"} --TransportDrop02
local TransportRoute6 = {"TransportPath04"} --TransportDrop06
local TransportRoute7 = {"TransportPath05", "TransportPath07"} --TransportDrop03
local TransportRoute8 = {"TransportPath05", "TransportPath07", "TransportPath17", "TransportPath16"} --TransportDrop03
local TransportRoute9 = {"TransportPath05", "TransportPath07", "TransportPath17", "TransportPath16", "TransportPath23"} --TransportDrop05



--TORPEDO BOMBER ROUTES
local TorpedoRoute01 = {"TorpedoPatrol01", "TorpedoPatrol02", "TorpedoPatrol03", "TorpedoPatrol04", "TorpedoPatrol05", "TorpedoPatrol06", "TorpedoPatrol07", "TorpedoPatrol08", "TorpedoPatrol09", "TorpedoPatrol10", "TorpedoPatrol11"}
local TorpedoRoute02 = {"TorpedoPatrol08", "TorpedoPatrol07", "TorpedoPatrol06", "TorpedoPatrol05", "TorpedoPatrol04", "TorpedoPatrol03", "TorpedoPatrol02", "TorpedoPatrol01", "TorpedoPatrol11", "TorpedoPatrol10", "TorpedoPatrol09"}
local TorpedoRoute03 = {"TorpedoPatrol12", "TorpedoPatrol13", "TorpedoPatrol14", "TorpedoPatrol15", "TorpedoPatrol16", "TorpedoPatrol17", "TorpedoPatrol18", "TorpedoPatrol19", "TorpedoPatrol20", "TorpedoPatrol21", "TorpedoPatrol22", "TorpedoPatrol23", "TorpedoPatrol24"}
local TorpedoRoute04 = {"TorpedoPatrol19", "TorpedoPatrol18", "TorpedoPatrol17", "TorpedoPatrol16", "TorpedoPatrol15", "TorpedoPatrol14", "TorpedoPatrol13", "TorpedoPatrol12", "TorpedoPatrol24", "TorpedoPatrol23", "TorpedoPatrol22", "TorpedoPatrol21", "TorpedoPatrol20"}
local TorpedoRoute05 = {"TorpedoPatrol25", "TorpedoPatrol26", "TorpedoPatrol27", "TorpedoPatrol28", "TorpedoPatrol29", "TorpedoPatrol30", "TorpedoPatrol31", "TorpedoPatrol32", "TorpedoPatrol33", "TorpedoPatrol34", "TorpedoPatrol35", "TorpedoPatrol36"}
local TorpedoRoute06 = {"TorpedoPatrol32", "TorpedoPatrol31", "TorpedoPatrol30", "TorpedoPatrol29", "TorpedoPatrol28", "TorpedoPatrol27", "TorpedoPatrol26", "TorpedoPatrol25", "TorpedoPatrol36", "TorpedoPatrol35", "TorpedoPatrol34", "TorpedoPatrol33"}
local TorpedoRoute07 = {"TorpedoPatrol37", "TorpedoPatrol38", "TorpedoPatrol39", "TorpedoPatrol40", "TorpedoPatrol41", "TorpedoPatrol42", "TorpedoPatrol43", "TorpedoPatrol44", "TorpedoPatrol45", "TorpedoPatrol46", "TorpedoPatrol47"}
local TorpedoRoute08 = {"TorpedoPatrol44", "TorpedoPatrol43", "TorpedoPatrol42", "TorpedoPatrol41", "TorpedoPatrol40", "TorpedoPatrol39", "TorpedoPatrol38", "TorpedoPatrol37", "TorpedoPatrol47", "TorpedoPatrol46", "TorpedoPatrol45"}
local TorpedoRoute09 = {"TorpedoPatrol48", "TorpedoPatrol49", "TorpedoPatrol50", "TorpedoPatrol51", "TorpedoPatrol52", "TorpedoPatrol53", "TorpedoPatrol54", "TorpedoPatrol55", "TorpedoPatrol56"}
local TorpedoRoute10 = {"TorpedoPatrol54", "TorpedoPatrol53", "TorpedoPatrol52", "TorpedoPatrol51", "TorpedoPatrol50", "TorpedoPatrol49", "TorpedoPatrol48", "TorpedoPatrol56", "TorpedoPatrol55"}
local AllTorpedoRoutes = {TorpedoRoute01, TorpedoRoute02, TorpedoRoute03, TorpedoRoute04, TorpedoRoute05, TorpedoRoute06, TorpedoRoute07, TorpedoRoute08, TorpedoRoute09, TorpedoRoute10}

--BOMBER BASE ROUTES
local BomberBaseRoute01 = {"BomberBasePath01", "BomberBasePath02", "BomberBasePath03", "BomberBasePath04", "BomberBasePath05", "BomberBasePath06", "BomberBasePath07"}
local BomberBaseRoute02 = {"BomberBasePath06", "BomberBasePath05", "BomberBasePath04", "BomberBasePath03", "BomberBasePath02", "BomberBasePath01", "BomberBasePath08"}
local BomberBaseRoute03 = {"BomberBasePath09", "BomberBasePath10", "BomberBasePath11", "BomberBasePath12", "BomberBasePath13", "BomberBasePath14", "BomberBasePath15"}
local BomberBaseRoute04 = {"BomberBasePath14", "BomberBasePath13", "BomberBasePath12", "BomberBasePath11", "BomberBasePath10", "BomberBasePath09", "BomberBasePath16"}
local BomberBaseRoute05 = {"BomberBasePath17", "BomberBasePath02", "BomberBasePath10", "BomberBasePath18", "BomberBasePath19"}
local BomberBaseRoute06 = {"BomberBasePath18", "BomberBasePath10", "BomberBasePath02", "BomberBasePath17", "BomberBasePath21"}
local BomberBaseRoute07 = {"BomberBasePath22", "BomberBasePath23", "BomberBasePath03", "BomberBasePath24", "BomberBasePath11", "BomberBasePath25", "BomberBasePath26", "BomberBasePath27"}
local BomberBaseRoute08 = {"BomberBasePath26", "BomberBasePath25", "BomberBasePath11", "BomberBasePath24", "BomberBasePath03", "BomberBasePath23", "BomberBasePath22", "BomberBasePath29"}
local BomberBaseRoute09 = {"BomberBasePath30", "BomberBasePath31", "BomberBasePath32", "BomberBasePath33", "BomberBasePath34", "BomberBasePath35", "BomberBasePath36", "BomberBasePath37", "BomberBasePath38"}
local BomberBaseRoute10 = {"BomberBasePath37", "BomberBasePath36", "BomberBasePath35", "BomberBasePath34", "BomberBasePath33", "BomberBasePath32", "BomberBasePath31", "BomberBasePath30", "BomberBasePath40"}
local BomberBaseRoute11 = {"BomberBasePath41", "BomberBasePath42", "BomberBasePath43", "BomberBasePath44", "BomberBasePath34", "BomberBasePath45", "BomberBasePath46", "BomberBasePath47", "BomberBasePath48"}
local BomberBaseRoute12 = {"BomberBasePath47", "BomberBasePath46", "BomberBasePath45", "BomberBasePath34", "BomberBasePath44", "BomberBasePath43", "BomberBasePath42", "BomberBasePath41", "BomberBasePath50"}
local BomberBaseRoute13 = {"BomberBasePath51", "BomberBasePath03", "BomberBasePath52", "BomberBasePath53", "BomberBasePath54", "BomberBasePath55", "BomberBasePath56", "BomberBasePath57"}
local BomberBaseRoute14 = {"BomberBasePath56", "BomberBasePath55", "BomberBasePath54", "BomberBasePath53", "BomberBasePath52", "BomberBasePath03", "BomberBasePath51", "BomberBasePath59"}
local BomberBaseRoute15 = {"BomberBasePath60", "BomberBasePath11", "BomberBasePath61", "BomberBasePath53", "BomberBasePath62", "BomberBasePath63", "BomberBasePath64", "BomberBasePath65"}
local BomberBaseRoute16 = {"BomberBasePath64", "BomberBasePath63", "BomberBasePath62", "BomberBasePath53", "BomberBasePath61", "BomberBasePath11", "BomberBasePath60", "BomberBasePath67"}
local BomberBaseRoute17 = {"BomberBasePath68", "BomberBasePath02", "BomberBasePath69", "BomberBasePath32", "BomberBasePath70", "BomberBasePath71", "BomberBasePath72", "BomberBasePath73"}
local BomberBaseRoute18 = {"BomberBasePath72", "BomberBasePath71", "BomberBasePath70", "BomberBasePath69", "BomberBasePath02", "BomberBasePath68", "BomberBasePath74"}
local BomberBaseRoute19 = {"BomberBasePath75", "BomberBasePath10", "BomberBasePath76", "BomberBasePath43", "BomberBasePath77", "BomberBasePath78", "BomberBasePath79", "BomberBasePath80"}
local BomberBaseRoute20 = {"BomberBasePath79", "BomberBasePath78", "BomberBasePath77", "BomberBasePath43", "BomberBasePath76", "BomberBasePath10", "BomberBasePath75", "BomberBasePath81"}
local BomberBaseRoute21 = {"BomberBasePath82", "BomberBasePath02", "BomberBasePath24", "BomberBasePath44", "BomberBasePath83", "BomberBasePath84", "BomberBasePath85", "BomberBasePath86"}
local BomberBaseRoute22 = {"BomberBasePath85", "BomberBasePath84", "BomberBasePath83", "BomberBasePath44", "BomberBasePath24", "BomberBasePath02", "BomberBasePath82", "BomberBasePath87"}
local BomberBaseRoute23 = {"BomberBasePath88", "BomberBasePath10", "BomberBasePath24", "BomberBasePath33", "BomberBasePath89", "BomberBasePath90", "BomberBasePath91", "BomberBasePath92"}
local BomberBaseRoute24 = {"BomberBasePath91", "BomberBasePath90", "BomberBasePath89", "BomberBasePath33", "BomberBasePath24", "BomberBasePath10", "BomberBasePath88", "BomberBasePath93"}
local BomberBaseRoute25 = {"BomberBasePath94", "BomberBasePath03", "BomberBasePath52", "BomberBasePath53", "BomberBasePath95", "BomberBasePath96", "BomberBasePath97", "BomberBasePath98", "BomberBasePath99"}
local BomberBaseRoute26 = {"BomberBasePath98", "BomberBasePath97", "BomberBasePath96", "BomberBasePath95", "BomberBasePath53", "BomberBasePath52", "BomberBasePath03", "BomberBasePath94", "BomberBasePath101"}
local BomberBaseRoute27 = {"BomberBasePath102", "BomberBasePath11", "BomberBasePath61", "BomberBasePath53", "BomberBasePath103", "BomberBasePath104", "BomberBasePath105", "BomberBasePath106", "BomberBasePath107"}
local BomberBaseRoute28 = {"BomberBasePath106", "BomberBasePath105", "BomberBasePath104", "BomberBasePath103", "BomberBasePath53", "BomberBasePath61", "BomberBasePath11", "BomberBasePath102", "BomberBasePath109"}
local AllBomberBaseRoutes = {BomberBaseRoute01, BomberBaseRoute02, BomberBaseRoute03, BomberBaseRoute04, BomberBaseRoute05, BomberBaseRoute06, BomberBaseRoute07, BomberBaseRoute08, BomberBaseRoute09, BomberBaseRoute10, BomberBaseRoute11, BomberBaseRoute12, BomberBaseRoute13, BomberBaseRoute14, BomberBaseRoute15, BomberBaseRoute16, BomberBaseRoute17, BomberBaseRoute18, BomberBaseRoute19, BomberBaseRoute20, BomberBaseRoute21, BomberBaseRoute22, BomberBaseRoute23, BomberBaseRoute24, BomberBaseRoute25, BomberBaseRoute26, BomberBaseRoute27, BomberBaseRoute28}

--BOMBER ROUTES
local BomberRoute01 = {"BomberPath01", "BomberPath02", "BomberPath03", "BomberPath04", "BomberPath05", "BomberPath06", "BomberPath07", "BomberPath08", "BomberPath09", "BomberPath10", "BomberPath11"}
local BomberRoute02 = {"BomberPath08", "BomberPath07", "BomberPath06", "BomberPath05", "BomberPath04", "BomberPath03", "BomberPath02", "BomberPath01", "BomberPath11", "BomberPath10", "BomberPath09"}
local BomberRoute03 = {"BomberPath12", "BomberPath13", "BomberPath14", "BomberPath15", "BomberPath16", "BomberPath17", "BomberPath18", "BomberPath19", "BomberPath20", "BomberPath21", "BomberPath22"}
local BomberRoute04 = {"BomberPath19", "BomberPath18", "BomberPath17", "BomberPath16", "BomberPath15", "BomberPath14", "BomberPath13", "BomberPath12", "BomberPath22", "BomberPath21", "BomberPath20"}
local BomberRoute05 = {"BomberPath23", "BomberPath24", "BomberPath25", "BomberPath26", "BomberPath27", "BomberPath28", "BomberPath29", "BomberPath30"}
local BomberRoute06 = {"BomberPath28", "BomberPath27", "BomberPath26", "BomberPath25", "BomberPath24", "BomberPath23", "BomberPath30", "BomberPath29"}
local BomberRoute07 = {"BomberPath31", "BomberPath32", "BomberPath33", "BomberPath34", "BomberPath35", "BomberPath36", "BomberPath37", "BomberPath38"}
local BomberRoute08 = {"BomberPath36", "BomberPath35", "BomberPath34", "BomberPath33", "BomberPath32", "BomberPath31", "BomberPath38", "BomberPath37"}
local BomberRoute09 = {"BomberPath39", "BomberPath40", "BomberPath41", "BomberPath42", "BomberPath43", "BomberPath44", "BomberPath45", "BomberPath46", "BomberPath47"}
local BomberRoute10 = {"BomberPath45", "BomberPath44", "BomberPath43", "BomberPath42", "BomberPath41", "BomberPath40", "BomberPath39", "BomberPath47", "BomberPath46"}
local BomberRoute11 = {"BomberPath48", "BomberPath49", "BomberPath50", "BomberPath51", "BomberPath52", "BomberPath53", "BomberPath54", "BomberPath55", "BomberPath56"}
local BomberRoute12 = {"BomberPath54", "BomberPath53", "BomberPath52", "BomberPath51", "BomberPath50", "BomberPath49", "BomberPath48", "BomberPath56", "BomberPath55"}
local BomberRoute13 = {"BomberPath59", "BomberPath60", "BomberPath61", "BomberPath62", "BomberPath63", "BomberPath57", "BomberPath58"}
local BomberRoute14 = {"BomberPath62", "BomberPath61", "BomberPath60", "BomberPath59", "BomberPath58", "BomberPath57", "BomberPath63"}
local AllBomberRoutes = {BomberRoute01, BomberRoute02, BomberRoute03, BomberRoute04, BomberRoute05, BomberRoute06, BomberRoute07, BomberRoute08. BomberRoute09, BomberRoute10, BomberRoute11, BomberRoute12, BomberRoute13, BomberRoute14}

--NAMES
local SpecialNames = {"Ripper", "Judas", "Hellbringer", "Trix", "Bulldog", "Doomer", "Punisher", "Ludvig", "Odyssey", "Little Furball", "Stompy", "Flamer", "Inferno", "The Barbarian", "Barbarossa"}
local SpecialNamesID = 1
local sACUnames = {"Jackson", "Anders", "Leo", "Max", "Adrik", "Alexei", "Iona", "Ali", "Felix", "Jade", "Anna", "Ellie", "Jacob", "Jill", "Rick", "Adrian", "Geoff", "Peter", "Adam", "Jack", "Thomas", "Neon"}
local sACUnameID = 1



--OTHER
local DoOnce = 0
local DontStartNukeObjective = 0
local GameHasEnded = 0
local cdrUnitList = {}
local cdrUnitCount = 0
local DeathDialogueNumber = 1
local DeathDialogue = {1, 2, 3, 4, 5}


local WaveOrders = {}
local WaveTable = {}
local WaveDelay = {0, 60, 120, 180}
local EnableLane1 = 0
local EnableLane2 = 0
local EnableLane3 = 0
local EnableLane4 = 0
local EnableLane5 = 0
local IgnoredLanesList = {}
local BaseRaidingTargets = {}
local ValidTransportDrops = {}

local ValidGunshipTargetsA = {}
local ValidGunshipTargetsB = {}
local ValidGunshipTargetsC = {}
local ValidGunshipTargetsD = {}
local ValidGunshipTargetsE = {}
local ValidGunshipTargetsF = {}
local ValidGunshipTargetsG = {}


--ShuffleAllLists = function()

--ShuffleList(ValidGunshipTargetsA)
--ShuffleList(ValidGunshipTargetsB)
--DoOnce = 1

--end




-- WAVES ARE SAVED IN THIS TABLE!!!
CreateWaves = function()


--ShuffleList(WaveDelay)
--ShuffleList(sACUnames)
--ShuffleList(SpecialNames)
--ShuffleList(ValidGunshipTargetsA)
--ShuffleList(ValidGunshipTargetsB)

WaveTable = {

{1, 'url0107', 15 * EnableLane1},
{2, 'url0107', 15 * EnableLane2},
{3, 'url0107', 15 * EnableLane3},
{4, 'url0107', 15 * EnableLane4},

{5, 'url0107', 15 * EnableLane1},
{6, 'url0107', 15 * EnableLane2},
{7, 'url0107', 15 * EnableLane3},
{8, 'url0107', 15 * EnableLane4},

{9, 'url0107', 20 * EnableLane1},
{10, 'url0107', 20 * EnableLane2},
{11, 'url0107', 20 * EnableLane3},
{12, 'url0107', 20 * EnableLane4},

{13, 'url0107', 25 * EnableLane1},
{14, 'url0107', 25 * EnableLane2},
{15, 'url0107', 25 * EnableLane3},
{16, 'url0107', 25 * EnableLane4},

{17, 'url0107', 30 * EnableLane1},
{18, 'url0107', 30 * EnableLane2},
{19, 'url0107', 30 * EnableLane3},
{20, 'url0107', 30 * EnableLane4},


{21, 'url0103', 2 * EnableLane1},
{22, 'url0103', 2 * EnableLane2},
{23, 'url0103', 2 * EnableLane3},
{24, 'url0103', 2 * EnableLane4},

{25, 'url0107', 25 * EnableLane1},
{26, 'url0107', 25 * EnableLane2},
{27, 'url0107', 25 * EnableLane3},
{28, 'url0107', 25 * EnableLane4},

{29, 'url0103', 2 * EnableLane1},
{30, 'url0103', 2 * EnableLane2},
{31, 'url0103', 2 * EnableLane3},
{32, 'url0103', 2 * EnableLane4},

{33, 'url0107', 25 * EnableLane1},
{34, 'url0107', 25 * EnableLane2},
{35, 'url0107', 25 * EnableLane3},
{36, 'url0107', 25 * EnableLane4},

{37, 'url0103', 4 * EnableLane1},
{38, 'url0103', 4 * EnableLane2},
{39, 'url0103', 4 * EnableLane3},
{40, 'url0103', 4 * EnableLane4},

{41, 'url0107', 25 * EnableLane1},
{42, 'url0107', 25 * EnableLane2},
{43, 'url0107', 25 * EnableLane3},
{44, 'url0107', 25 * EnableLane4},

{45, 'url0103', 4 * EnableLane1},
{46, 'url0103', 4 * EnableLane2},
{47, 'url0103', 4 * EnableLane3},
{48, 'url0103', 4 * EnableLane4},

{49, 'url0107', 25 * EnableLane1},
{50, 'url0107', 25 * EnableLane2},
{51, 'url0107', 25 * EnableLane3},
{52, 'url0107', 25 * EnableLane4},

{53, 'url0103', 6 * EnableLane1},
{54, 'url0103', 6 * EnableLane2},
{55, 'url0103', 6 * EnableLane3},
{56, 'url0103', 6 * EnableLane4},

{57, 'url0107', 30 * EnableLane1},
{58, 'url0107', 30 * EnableLane2},
{59, 'url0107', 30 * EnableLane3},
{60, 'url0107', 30 * EnableLane4},


{61, 'url0107', 25 * EnableLane1, 'url0203', 5 * EnableLane1},
{62, 'url0107', 25 * EnableLane2, 'url0203', 5 * EnableLane2},
{63, 'url0107', 25 * EnableLane3, 'url0203', 5 * EnableLane3},
{64, 'url0107', 25 * EnableLane4, 'url0203', 5 * EnableLane4},

{65, 'url0107', 25 * EnableLane1, 'url0203', 5 * EnableLane1},
{66, 'url0107', 25 * EnableLane2, 'url0203', 5 * EnableLane2},
{67, 'url0107', 25 * EnableLane3, 'url0203', 5 * EnableLane3},
{68, 'url0107', 25 * EnableLane4, 'url0203', 5 * EnableLane4},

{69, 'url0107', 25 * EnableLane1, 'url0203', 5 * EnableLane1},
{70, 'url0107', 25 * EnableLane2, 'url0203', 5 * EnableLane2},
{71, 'url0107', 25 * EnableLane3, 'url0203', 5 * EnableLane3},
{72, 'url0107', 25 * EnableLane4, 'url0203', 5 * EnableLane4},

{73, 'url0107', 30 * EnableLane1, 'url0203', 6 * EnableLane1},
{74, 'url0107', 30 * EnableLane2, 'url0203', 6 * EnableLane2},
{75, 'url0107', 30 * EnableLane3, 'url0203', 6 * EnableLane3},
{76, 'url0107', 30 * EnableLane4, 'url0203', 6 * EnableLane4},

{77, 'url0107', 30 * EnableLane1, 'url0203', 6 * EnableLane1},
{78, 'url0107', 30 * EnableLane2, 'url0203', 6 * EnableLane2},
{79, 'url0107', 30 * EnableLane3, 'url0203', 6 * EnableLane3},
{80, 'url0107', 30 * EnableLane4, 'url0203', 6 * EnableLane4},




{81, 'url0107', 20 * EnableLane1, 'url0203', 6 * EnableLane1},
{82, 'url0107', 20 * EnableLane2, 'url0203', 6 * EnableLane2},
{83, 'url0107', 20 * EnableLane3, 'url0203', 6 * EnableLane3},
{84, 'url0107', 20 * EnableLane4, 'url0203', 6 * EnableLane4},

{85, 'drl0204', 4 * EnableLane1},
{86, 'drl0204', 4 * EnableLane2},
{87, 'drl0204', 4 * EnableLane3},
{88, 'drl0204', 4 * EnableLane4},


{89, 'url0107', 20 * EnableLane1, 'url0203', 6 * EnableLane1},
{90, 'url0107', 20 * EnableLane2, 'url0203', 6 * EnableLane2},
{91, 'url0107', 20 * EnableLane3, 'url0203', 6 * EnableLane3},
{92, 'url0107', 20 * EnableLane4, 'url0203', 6 * EnableLane4},

{93, 'drl0204', 4 * EnableLane1},
{94, 'drl0204', 4 * EnableLane2},
{95, 'drl0204', 4 * EnableLane3},
{96, 'drl0204', 4 * EnableLane4},


{97, 'url0107', 20 * EnableLane1, 'url0203', 6 * EnableLane1},
{98, 'url0107', 20 * EnableLane2, 'url0203', 6 * EnableLane2},
{99, 'url0107', 20 * EnableLane3, 'url0203', 6 * EnableLane3},
{100, 'url0107', 20 * EnableLane4, 'url0203', 6 * EnableLane4},

{101, 'drl0204', 4 * EnableLane1},
{102, 'drl0204', 4 * EnableLane2},
{103, 'drl0204', 4 * EnableLane3},
{104, 'drl0204', 4 * EnableLane4},


{105, 'url0107', 20 * EnableLane1, 'url0203', 6 * EnableLane1},
{106, 'url0107', 20 * EnableLane2, 'url0203', 6 * EnableLane2},
{107, 'url0107', 20 * EnableLane3, 'url0203', 6 * EnableLane3},
{108, 'url0107', 20 * EnableLane4, 'url0203', 6 * EnableLane4},

{109, 'drl0204', 4 * EnableLane1},
{110, 'drl0204', 4 * EnableLane2},
{111, 'drl0204', 4 * EnableLane3},
{112, 'drl0204', 4 * EnableLane4},


{113, 'url0107', 20 * EnableLane1, 'url0203', 6 * EnableLane1},
{114, 'url0107', 20 * EnableLane2, 'url0203', 6 * EnableLane2},
{115, 'url0107', 20 * EnableLane3, 'url0203', 6 * EnableLane3},
{116, 'url0107', 20 * EnableLane4, 'url0203', 6 * EnableLane4},

{117, 'drl0204', 4 * EnableLane1},
{118, 'drl0204', 4 * EnableLane2},
{119, 'drl0204', 4 * EnableLane3},
{120, 'drl0204', 4 * EnableLane4},



{121, 'url0111', 1 * EnableLane1},
{122, 'url0111', 1 * EnableLane2},
{123, 'url0111', 1 * EnableLane3},
{124, 'url0111', 1 * EnableLane4},

{125, 'url0205', 1 * EnableLane1, 'url0104', 3 * EnableLane1, 'url0101', 1 * EnableLane1},
{126, 'url0205', 1 * EnableLane2, 'url0104', 3 * EnableLane2, 'url0101', 1 * EnableLane2},
{127, 'url0205', 1 * EnableLane3, 'url0104', 3 * EnableLane3, 'url0101', 1 * EnableLane3},
{128, 'url0205', 1 * EnableLane4, 'url0104', 3 * EnableLane4, 'url0101', 1 * EnableLane4},


{129, 'url0111', 0 * EnableLane1},
{130, 'url0111', 0 * EnableLane2},
{131, 'url0111', 0 * EnableLane3},
{132, 'url0111', 0 * EnableLane4},

{133, 'url0205', 0 * EnableLane1, 'url0104', 0 * EnableLane1, 'url0101', 0 * EnableLane1},
{134, 'url0205', 0 * EnableLane2, 'url0104', 0 * EnableLane2, 'url0101', 0 * EnableLane2},
{135, 'url0205', 0 * EnableLane3, 'url0104', 0 * EnableLane3, 'url0101', 0 * EnableLane3},
{136, 'url0205', 0 * EnableLane4, 'url0104', 0 * EnableLane4, 'url0101', 0 * EnableLane4},


{137, 'url0111', 1 * EnableLane1},
{138, 'url0111', 1 * EnableLane2},
{139, 'url0111', 1 * EnableLane3},
{140, 'url0111', 1 * EnableLane4},

{141, 'url0205', 0 * EnableLane1, 'url0104', 1 * EnableLane1, 'url0101', 0 * EnableLane1},
{142, 'url0205', 0 * EnableLane2, 'url0104', 1 * EnableLane2, 'url0101', 0 * EnableLane2},
{143, 'url0205', 0 * EnableLane3, 'url0104', 1 * EnableLane3, 'url0101', 0 * EnableLane3},
{144, 'url0205', 0 * EnableLane4, 'url0104', 1 * EnableLane4, 'url0101', 0 * EnableLane4},


{145, 'url0111', 0 * EnableLane1},
{146, 'url0111', 0 * EnableLane2},
{147, 'url0111', 0 * EnableLane3},
{148, 'url0111', 0 * EnableLane4},

{149, 'url0205', 0 * EnableLane1, 'url0104', 0 * EnableLane1, 'url0101', 0 * EnableLane1},
{150, 'url0205', 0 * EnableLane2, 'url0104', 0 * EnableLane2, 'url0101', 0 * EnableLane2},
{151, 'url0205', 0 * EnableLane3, 'url0104', 0 * EnableLane3, 'url0101', 0 * EnableLane3},
{152, 'url0205', 0 * EnableLane4, 'url0104', 0 * EnableLane4, 'url0101', 0 * EnableLane4},


{153, 'url0111', 1 * EnableLane1},
{154, 'url0111', 1 * EnableLane2},
{155, 'url0111', 1 * EnableLane3},
{156, 'url0111', 1 * EnableLane4},

{157, 'url0205', 1 * EnableLane1, 'url0104', 1 * EnableLane1, 'url0101', 1 * EnableLane1},
{158, 'url0205', 1 * EnableLane2, 'url0104', 1 * EnableLane2, 'url0101', 1 * EnableLane2},
{159, 'url0205', 1 * EnableLane3, 'url0104', 1 * EnableLane3, 'url0101', 1 * EnableLane3},
{160, 'url0205', 1 * EnableLane4, 'url0104', 1 * EnableLane4, 'url0101', 1 * EnableLane4},


"NULL",
"NULL",
"NULL",
"NULL",
"NULL",
"NULL",
"NULL",
"NULL",
"NULL",
"NULL",
"NULL",
"NULL",
"NULL",
"NULL",



{175, 'url0202', 20 * EnableLane1, 'url0205', 4 * EnableLane1, 'url0104', 4 * EnableLane1, 'url0101', 2 * EnableLane1},
{176, 'url0202', 20 * EnableLane2, 'url0205', 4 * EnableLane2, 'url0104', 4 * EnableLane2, 'url0101', 2 * EnableLane2},
{177, 'url0202', 20 * EnableLane3, 'url0205', 4 * EnableLane3, 'url0104', 4 * EnableLane3, 'url0101', 2 * EnableLane3},
{178, 'url0202', 20 * EnableLane4, 'url0205', 4 * EnableLane4, 'url0104', 4 * EnableLane4, 'url0101', 2 * EnableLane4},

{179, 'url0111', 0 * EnableLane1},
{180, 'url0111', 0 * EnableLane2},
{181, 'url0111', 0 * EnableLane3},
{182, 'url0111', 0 * EnableLane4},

{183, 'url0202', 20 * EnableLane1, 'url0205', 4 * EnableLane1, 'url0104', 4 * EnableLane1, 'url0101', 2 * EnableLane1},
{184, 'url0202', 20 * EnableLane2, 'url0205', 4 * EnableLane2, 'url0104', 4 * EnableLane2, 'url0101', 2 * EnableLane2},
{185, 'url0202', 20 * EnableLane3, 'url0205', 4 * EnableLane3, 'url0104', 4 * EnableLane3, 'url0101', 2 * EnableLane3},
{186, 'url0202', 20 * EnableLane4, 'url0205', 4 * EnableLane4, 'url0104', 4 * EnableLane4, 'url0101', 2 * EnableLane4},

{187, 'url0111', 1 * EnableLane1},
{188, 'url0111', 1 * EnableLane2},
{189, 'url0111', 1 * EnableLane3},
{190, 'url0111', 1 * EnableLane4},

{191, 'url0202', 20 * EnableLane1, 'url0205', 4 * EnableLane1, 'url0104', 4 * EnableLane1, 'url0101', 2 * EnableLane1},
{192, 'url0202', 20 * EnableLane2, 'url0205', 4 * EnableLane2, 'url0104', 4 * EnableLane2, 'url0101', 2 * EnableLane2},
{193, 'url0202', 20 * EnableLane3, 'url0205', 4 * EnableLane3, 'url0104', 4 * EnableLane3, 'url0101', 2 * EnableLane3},
{194, 'url0202', 20 * EnableLane4, 'url0205', 4 * EnableLane4, 'url0104', 4 * EnableLane4, 'url0101', 2 * EnableLane4},

{195, 'url0111', 1 * EnableLane1},
{196, 'url0111', 1 * EnableLane2},
{197, 'url0111', 1 * EnableLane3},
{198, 'url0111', 1 * EnableLane4},

{199, 'url0202', 20 * EnableLane1, 'url0205', 4 * EnableLane1, 'url0104', 4 * EnableLane1, 'url0101', 2 * EnableLane1},
{200, 'url0202', 20 * EnableLane2, 'url0205', 4 * EnableLane2, 'url0104', 4 * EnableLane2, 'url0101', 2 * EnableLane2},
{201, 'url0202', 20 * EnableLane3, 'url0205', 4 * EnableLane3, 'url0104', 4 * EnableLane3, 'url0101', 2 * EnableLane3},
{202, 'url0202', 20 * EnableLane4, 'url0205', 4 * EnableLane4, 'url0104', 4 * EnableLane4, 'url0101', 2 * EnableLane4},

{203, 'url0111', 1 * EnableLane1},
{204, 'url0111', 1 * EnableLane2},
{205, 'url0111', 1 * EnableLane3},
{206, 'url0111', 1 * EnableLane4},

{207, 'url0202', 20 * EnableLane1, 'url0205', 4 * EnableLane1, 'url0104', 4 * EnableLane1, 'url0101', 2 * EnableLane1},
{208, 'url0202', 20 * EnableLane2, 'url0205', 4 * EnableLane2, 'url0104', 4 * EnableLane2, 'url0101', 2 * EnableLane2},
{209, 'url0202', 20 * EnableLane3, 'url0205', 4 * EnableLane3, 'url0104', 4 * EnableLane3, 'url0101', 2 * EnableLane3},
{210, 'url0202', 20 * EnableLane4, 'url0205', 4 * EnableLane4, 'url0104', 4 * EnableLane4, 'url0101', 2 * EnableLane4},

{211, 'url0111', 1 * EnableLane1},
{212, 'url0111', 1 * EnableLane2},
{213, 'url0111', 1 * EnableLane3},
{214, 'url0111', 1 * EnableLane4},



{215, 'urs0304', 3, 'xrs0204', 4, 'urs0202', 0, 'urs0103', 6, 'urs0203', 2},



{216, 'xrl0305', 7 * EnableLane1, 'url0303', 9 * EnableLane1, 'drlk001', 2 * EnableLane1, 'url0205', 4 * EnableLane1, 'url0101', 2 * EnableLane1},
{217, 'xrl0305', 7 * EnableLane2, 'url0303', 9 * EnableLane2, 'drlk001', 2 * EnableLane2, 'url0205', 4 * EnableLane2, 'url0101', 2 * EnableLane2},
{218, 'xrl0305', 7 * EnableLane3, 'url0303', 9 * EnableLane3, 'drlk001', 2 * EnableLane3, 'url0205', 4 * EnableLane3, 'url0101', 2 * EnableLane3},
{219, 'xrl0305', 7 * EnableLane4, 'url0303', 9 * EnableLane4, 'drlk001', 2 * EnableLane4, 'url0205', 4 * EnableLane4, 'url0101', 2 * EnableLane4},

{220, 'url0304', 0 * EnableLane1},
{221, 'url0304', 0 * EnableLane2},
{222, 'url0304', 0 * EnableLane3},
{223, 'url0304', 0 * EnableLane4},


{224, 'xrl0305', 7 * EnableLane1, 'url0303', 9 * EnableLane1, 'drlk001', 2 * EnableLane1, 'url0205', 4 * EnableLane1, 'url0101', 2 * EnableLane1},
{225, 'xrl0305', 7 * EnableLane2, 'url0303', 9 * EnableLane2, 'drlk001', 2 * EnableLane2, 'url0205', 4 * EnableLane2, 'url0101', 2 * EnableLane2},
{226, 'xrl0305', 7 * EnableLane3, 'url0303', 9 * EnableLane3, 'drlk001', 2 * EnableLane3, 'url0205', 4 * EnableLane3, 'url0101', 2 * EnableLane3},
{227, 'xrl0305', 7 * EnableLane4, 'url0303', 9 * EnableLane4, 'drlk001', 2 * EnableLane4, 'url0205', 4 * EnableLane4, 'url0101', 2 * EnableLane4},

{228, 'url0304', 0 * EnableLane1},
{229, 'url0304', 0 * EnableLane2},
{230, 'url0304', 0 * EnableLane3},
{231, 'url0304', 0 * EnableLane4},


{232, 'xrl0305', 7 * EnableLane1, 'url0303', 9 * EnableLane1, 'drlk001', 2 * EnableLane1, 'url0205', 4 * EnableLane1, 'url0101', 2 * EnableLane1},
{233, 'xrl0305', 7 * EnableLane2, 'url0303', 9 * EnableLane2, 'drlk001', 2 * EnableLane2, 'url0205', 4 * EnableLane2, 'url0101', 2 * EnableLane2},
{234, 'xrl0305', 7 * EnableLane3, 'url0303', 9 * EnableLane3, 'drlk001', 2 * EnableLane3, 'url0205', 4 * EnableLane3, 'url0101', 2 * EnableLane3},
{235, 'xrl0305', 7 * EnableLane4, 'url0303', 9 * EnableLane4, 'drlk001', 2 * EnableLane4, 'url0205', 4 * EnableLane4, 'url0101', 2 * EnableLane4},

{236, 'url0304', 1 * EnableLane1},
{237, 'url0304', 1 * EnableLane2},
{238, 'url0304', 1 * EnableLane3},
{239, 'url0304', 1 * EnableLane4},


{240, 'xrl0305', 7 * EnableLane1, 'url0303', 9 * EnableLane1, 'drlk001', 2 * EnableLane1, 'url0205', 4 * EnableLane1, 'url0101', 2 * EnableLane1},
{241, 'xrl0305', 7 * EnableLane2, 'url0303', 9 * EnableLane2, 'drlk001', 2 * EnableLane2, 'url0205', 4 * EnableLane2, 'url0101', 2 * EnableLane2},
{242, 'xrl0305', 7 * EnableLane3, 'url0303', 9 * EnableLane3, 'drlk001', 2 * EnableLane3, 'url0205', 4 * EnableLane3, 'url0101', 2 * EnableLane3},
{243, 'xrl0305', 7 * EnableLane4, 'url0303', 9 * EnableLane4, 'drlk001', 2 * EnableLane4, 'url0205', 4 * EnableLane4, 'url0101', 2 * EnableLane4},

{244, 'url0304', 0 * EnableLane1},
{245, 'url0304', 0 * EnableLane2},
{246, 'url0304', 0 * EnableLane3},
{247, 'url0304', 0 * EnableLane4},


{248, 'xrl0305', 7 * EnableLane1, 'url0303', 9 * EnableLane1, 'drlk001', 2 * EnableLane1, 'url0205', 4 * EnableLane1, 'url0101', 2 * EnableLane1},
{249, 'xrl0305', 7 * EnableLane2, 'url0303', 9 * EnableLane2, 'drlk001', 2 * EnableLane2, 'url0205', 4 * EnableLane2, 'url0101', 2 * EnableLane2},
{250, 'xrl0305', 7 * EnableLane3, 'url0303', 9 * EnableLane3, 'drlk001', 2 * EnableLane3, 'url0205', 4 * EnableLane3, 'url0101', 2 * EnableLane3},
{251, 'xrl0305', 7 * EnableLane4, 'url0303', 9 * EnableLane4, 'drlk001', 2 * EnableLane4, 'url0205', 4 * EnableLane4, 'url0101', 2 * EnableLane4},

{252, 'url0304', 1 * EnableLane1},
{253, 'url0304', 1 * EnableLane2},
{254, 'url0304', 1 * EnableLane3},
{255, 'url0304', 1 * EnableLane4},


{256, 'xrl0305', 10 * EnableLane1, 'drlk001', 2 * EnableLane1, 'url0306', 2 * EnableLane1, 'url0101', 1 * EnableLane1},
{257, 'xrl0305', 10 * EnableLane2, 'drlk001', 2 * EnableLane2, 'url0306', 2 * EnableLane2, 'url0101', 1 * EnableLane2},
{258, 'xrl0305', 10 * EnableLane3, 'drlk001', 2 * EnableLane3, 'url0306', 2 * EnableLane3, 'url0101', 1 * EnableLane3},
{259, 'xrl0305', 10 * EnableLane4, 'drlk001', 2 * EnableLane4, 'url0306', 2 * EnableLane4, 'url0101', 1 * EnableLane4},

{260, 'xrl0305', 10 * EnableLane1, 'drlk001', 2 * EnableLane1, 'url0306', 2 * EnableLane1, 'url0101', 2 * EnableLane1},
{261, 'xrl0305', 10 * EnableLane2, 'drlk001', 2 * EnableLane2, 'url0306', 2 * EnableLane2, 'url0101', 2 * EnableLane2},
{262, 'xrl0305', 10 * EnableLane3, 'drlk001', 2 * EnableLane3, 'url0306', 2 * EnableLane3, 'url0101', 2 * EnableLane3},
{263, 'xrl0305', 10 * EnableLane4, 'drlk001', 2 * EnableLane4, 'url0306', 2 * EnableLane4, 'url0101', 2 * EnableLane4},

{264, 'xrl0305', 10 * EnableLane1, 'drlk001', 2 * EnableLane1, 'url0306', 2 * EnableLane1, 'url0101', 2 * EnableLane1},
{265, 'xrl0305', 10 * EnableLane2, 'drlk001', 2 * EnableLane2, 'url0306', 2 * EnableLane2, 'url0101', 2 * EnableLane2},
{266, 'xrl0305', 10 * EnableLane3, 'drlk001', 2 * EnableLane3, 'url0306', 2 * EnableLane3, 'url0101', 2 * EnableLane3},
{267, 'xrl0305', 10 * EnableLane4, 'drlk001', 2 * EnableLane4, 'url0306', 2 * EnableLane4, 'url0101', 2 * EnableLane4},

{268, 'xrl0305', 10 * EnableLane1, 'drlk001', 2 * EnableLane1, 'url0306', 2 * EnableLane1, 'url0101', 2 * EnableLane1},
{269, 'xrl0305', 10 * EnableLane2, 'drlk001', 2 * EnableLane2, 'url0306', 2 * EnableLane2, 'url0101', 2 * EnableLane2},
{270, 'xrl0305', 10 * EnableLane3, 'drlk001', 2 * EnableLane3, 'url0306', 2 * EnableLane3, 'url0101', 2 * EnableLane3},
{271, 'xrl0305', 10 * EnableLane4, 'drlk001', 2 * EnableLane4, 'url0306', 2 * EnableLane4, 'url0101', 2 * EnableLane4},

{272, 'xrl0305', 10 * EnableLane1, 'drlk001', 2 * EnableLane1, 'url0306', 2 * EnableLane1, 'url0101', 2 * EnableLane1},
{273, 'xrl0305', 10 * EnableLane2, 'drlk001', 2 * EnableLane2, 'url0306', 2 * EnableLane2, 'url0101', 2 * EnableLane2},
{274, 'xrl0305', 10 * EnableLane3, 'drlk001', 2 * EnableLane3, 'url0306', 2 * EnableLane3, 'url0101', 2 * EnableLane3},
{275, 'xrl0305', 10 * EnableLane4, 'drlk001', 2 * EnableLane4, 'url0306', 2 * EnableLane4, 'url0101', 2 * EnableLane4},


{276, 'url0402', 1 * EnableLane1},
"NULL",
{278, 'url0402', 1 * EnableLane2},
"NULL",
{280, 'url0402', 1 * EnableLane3},
"NULL",
{282, 'url0402', 1 * EnableLane4},
"NULL",


{284, 'urs0201', 1 + (1 * EnableLane5), 'xrs0204', 3, 'xrs0205', 1, 'urs0202', 1 + (1 * EnableLane5), 'urs0103', 3 - (2 * EnableLane5), 'urs0203', 3},

{285, 'urs0302', 1},
{286, 'xrs0205', 1, 'ura0303', 15},



{287, 'xrl0305', 10 * EnableLane1, 'drlk001', 4 * EnableLane1, 'url0306', 2 * EnableLane1, 'url0101', 2 * EnableLane1, 'url0303', 1 * EnableLane1, 'url0301', 1 * EnableLane1},
{288, 'xrl0305', 10 * EnableLane2, 'drlk001', 4 * EnableLane2, 'url0306', 2 * EnableLane2, 'url0101', 2 * EnableLane2, 'url0303', 1 * EnableLane2, 'url0301', 1 * EnableLane2},
{289, 'xrl0305', 10 * EnableLane3, 'drlk001', 4 * EnableLane3, 'url0306', 2 * EnableLane3, 'url0101', 2 * EnableLane3, 'url0303', 1 * EnableLane3, 'url0301', 1 * EnableLane3},
{290, 'xrl0305', 10 * EnableLane4, 'drlk001', 4 * EnableLane4, 'url0306', 2 * EnableLane4, 'url0101', 2 * EnableLane4, 'url0303', 1 * EnableLane4, 'url0301', 1 * EnableLane4},

{291, 'url0304', 3 * EnableLane1},
{292, 'url0304', 3 * EnableLane2},
{293, 'url0304', 3 * EnableLane3},
{294, 'url0304', 3 * EnableLane4},

{295, 'drlk001', 1 * EnableLane1},
{296, 'drlk001', 1 * EnableLane2},
{297, 'drlk001', 1 * EnableLane3},
{298, 'drlk001', 1 * EnableLane4},

{299, 'xrl0305', 10 * EnableLane1, 'drlk001', 4 * EnableLane1, 'url0306', 2 * EnableLane1, 'url0101', 2 * EnableLane1, 'url0303', 2 * EnableLane1},
{300, 'xrl0305', 10 * EnableLane2, 'drlk001', 4 * EnableLane2, 'url0306', 2 * EnableLane2, 'url0101', 2 * EnableLane2, 'url0303', 2 * EnableLane2},
{301, 'xrl0305', 10 * EnableLane3, 'drlk001', 4 * EnableLane3, 'url0306', 2 * EnableLane3, 'url0101', 2 * EnableLane3, 'url0303', 2 * EnableLane3},
{302, 'xrl0305', 10 * EnableLane4, 'drlk001', 4 * EnableLane4, 'url0306', 2 * EnableLane4, 'url0101', 2 * EnableLane4, 'url0303', 2 * EnableLane4},

{303, 'url0304', 3 * EnableLane1},
{304, 'url0304', 3 * EnableLane2},
{305, 'url0304', 3 * EnableLane3},
{306, 'url0304', 3 * EnableLane4},

{307, 'drlk001', 1 * EnableLane1},
{308, 'drlk001', 1 * EnableLane2},
{309, 'drlk001', 1 * EnableLane3},
{310, 'drlk001', 1 * EnableLane4},

{311, 'xrl0305', 10 * EnableLane1, 'drlk001', 4 * EnableLane1, 'url0306', 2 * EnableLane1, 'url0101', 2 * EnableLane1, 'url0303', 1 * EnableLane1, 'url0301', 1 * EnableLane1},
{312, 'xrl0305', 10 * EnableLane2, 'drlk001', 4 * EnableLane2, 'url0306', 2 * EnableLane2, 'url0101', 2 * EnableLane2, 'url0303', 1 * EnableLane2, 'url0301', 1 * EnableLane2},
{313, 'xrl0305', 10 * EnableLane3, 'drlk001', 4 * EnableLane3, 'url0306', 2 * EnableLane3, 'url0101', 2 * EnableLane3, 'url0303', 1 * EnableLane3, 'url0301', 1 * EnableLane3},
{314, 'xrl0305', 10 * EnableLane4, 'drlk001', 4 * EnableLane4, 'url0306', 2 * EnableLane4, 'url0101', 2 * EnableLane4, 'url0303', 1 * EnableLane4, 'url0301', 1 * EnableLane4},

{315, 'url0304', 3 * EnableLane1},
{316, 'url0304', 3 * EnableLane2},
{317, 'url0304', 3 * EnableLane3},
{318, 'url0304', 3 * EnableLane4},

{319, 'drlk001', 1 * EnableLane1},
{320, 'drlk001', 1 * EnableLane2},
{321, 'drlk001', 1 * EnableLane3},
{322, 'drlk001', 1 * EnableLane4},

{323, 'xrl0305', 10 * EnableLane1, 'drlk001', 4 * EnableLane1, 'url0306', 2 * EnableLane1, 'url0101', 2 * EnableLane1, 'url0303', 2 * EnableLane1},
{324, 'xrl0305', 10 * EnableLane2, 'drlk001', 4 * EnableLane2, 'url0306', 2 * EnableLane2, 'url0101', 2 * EnableLane2, 'url0303', 2 * EnableLane2},
{325, 'xrl0305', 10 * EnableLane3, 'drlk001', 4 * EnableLane3, 'url0306', 2 * EnableLane3, 'url0101', 2 * EnableLane3, 'url0303', 2 * EnableLane3},
{326, 'xrl0305', 10 * EnableLane4, 'drlk001', 4 * EnableLane4, 'url0306', 2 * EnableLane4, 'url0101', 2 * EnableLane4, 'url0303', 2 * EnableLane4},

{327, 'url0304', 3 * EnableLane1},
{328, 'url0304', 3 * EnableLane2},
{329, 'url0304', 3 * EnableLane3},
{330, 'url0304', 3 * EnableLane4},

{331, 'drlk001', 1 * EnableLane1},
{332, 'drlk001', 1 * EnableLane2},
{333, 'drlk001', 1 * EnableLane3},
{334, 'drlk001', 1 * EnableLane4},

{335, 'xrl0305', 10 * EnableLane1, 'drlk001', 4 * EnableLane1, 'url0306', 2 * EnableLane1, 'url0101', 2 * EnableLane1, 'url0303', 1 * EnableLane1, 'url0301', 1 * EnableLane1},
{336, 'xrl0305', 10 * EnableLane2, 'drlk001', 4 * EnableLane2, 'url0306', 2 * EnableLane2, 'url0101', 2 * EnableLane2, 'url0303', 1 * EnableLane2, 'url0301', 1 * EnableLane2},
{337, 'xrl0305', 10 * EnableLane3, 'drlk001', 4 * EnableLane3, 'url0306', 2 * EnableLane3, 'url0101', 2 * EnableLane3, 'url0303', 1 * EnableLane3, 'url0301', 1 * EnableLane3},
{338, 'xrl0305', 10 * EnableLane4, 'drlk001', 4 * EnableLane4, 'url0306', 2 * EnableLane4, 'url0101', 2 * EnableLane4, 'url0303', 1 * EnableLane4, 'url0301', 1 * EnableLane4},

{339, 'url0304', 3 * EnableLane1},
{340, 'url0304', 3 * EnableLane2},
{341, 'url0304', 3 * EnableLane3},
{342, 'url0304', 3 * EnableLane4},

{343, 'drlk001', 1 * EnableLane1},
{344, 'drlk001', 1 * EnableLane2},
{345, 'drlk001', 1 * EnableLane3},
{346, 'drlk001', 1 * EnableLane4},

{347, 'xrl0305', 10 * EnableLane1, 'drlk001', 4 * EnableLane1, 'url0306', 2 * EnableLane1, 'url0101', 2 * EnableLane1, 'url0303', 2 * EnableLane1},
{348, 'xrl0305', 10 * EnableLane2, 'drlk001', 4 * EnableLane2, 'url0306', 2 * EnableLane2, 'url0101', 2 * EnableLane2, 'url0303', 2 * EnableLane2},
{349, 'xrl0305', 10 * EnableLane3, 'drlk001', 4 * EnableLane3, 'url0306', 2 * EnableLane3, 'url0101', 2 * EnableLane3, 'url0303', 2 * EnableLane3},
{350, 'xrl0305', 10 * EnableLane4, 'drlk001', 4 * EnableLane4, 'url0306', 2 * EnableLane4, 'url0101', 2 * EnableLane4, 'url0303', 2 * EnableLane4},

{351, 'url0304', 3 * EnableLane1},
{352, 'url0304', 3 * EnableLane2},
{353, 'url0304', 3 * EnableLane3},
{354, 'url0304', 3 * EnableLane4},

{355, 'drlk001', 1 * EnableLane1},
{356, 'drlk001', 1 * EnableLane2},
{357, 'drlk001', 1 * EnableLane3},
{358, 'drlk001', 1 * EnableLane4},

{359, 'xrl0305', 10 * EnableLane1, 'drlk001', 4 * EnableLane1, 'url0306', 2 * EnableLane1, 'url0101', 2 * EnableLane1, 'url0303', 1 * EnableLane1, 'url0301', 1 * EnableLane1},
{360, 'xrl0305', 10 * EnableLane2, 'drlk001', 4 * EnableLane2, 'url0306', 2 * EnableLane2, 'url0101', 2 * EnableLane2, 'url0303', 1 * EnableLane2, 'url0301', 1 * EnableLane2},
{361, 'xrl0305', 10 * EnableLane3, 'drlk001', 4 * EnableLane3, 'url0306', 2 * EnableLane3, 'url0101', 2 * EnableLane3, 'url0303', 1 * EnableLane3, 'url0301', 1 * EnableLane3},
{362, 'xrl0305', 10 * EnableLane4, 'drlk001', 4 * EnableLane4, 'url0306', 2 * EnableLane4, 'url0101', 2 * EnableLane4, 'url0303', 1 * EnableLane4, 'url0301', 1 * EnableLane4},

{363, 'url0304', 3 * EnableLane1},
{364, 'url0304', 3 * EnableLane2},
{365, 'url0304', 3 * EnableLane3},
{366, 'url0304', 3 * EnableLane4},

{367, 'drlk001', 1 * EnableLane1},
{368, 'drlk001', 1 * EnableLane2},
{369, 'drlk001', 1 * EnableLane3},
{370, 'drlk001', 1 * EnableLane4},

{371, 'xrl0305', 10 * EnableLane1, 'drlk001', 4 * EnableLane1, 'url0306', 2 * EnableLane1, 'url0101', 2 * EnableLane1, 'url0303', 2 * EnableLane1},
{372, 'xrl0305', 10 * EnableLane2, 'drlk001', 4 * EnableLane2, 'url0306', 2 * EnableLane2, 'url0101', 2 * EnableLane2, 'url0303', 2 * EnableLane2},
{373, 'xrl0305', 10 * EnableLane3, 'drlk001', 4 * EnableLane3, 'url0306', 2 * EnableLane3, 'url0101', 2 * EnableLane3, 'url0303', 2 * EnableLane3},
{374, 'xrl0305', 10 * EnableLane4, 'drlk001', 4 * EnableLane4, 'url0306', 2 * EnableLane4, 'url0101', 2 * EnableLane4, 'url0303', 2 * EnableLane4},

{375, 'url0304', 3 * EnableLane1},
{376, 'url0304', 3 * EnableLane2},
{377, 'url0304', 3 * EnableLane3},
{378, 'url0304', 3 * EnableLane4},

{379, 'drlk001', 1 * EnableLane1},
{380, 'drlk001', 1 * EnableLane2},
{381, 'drlk001', 1 * EnableLane3},
{382, 'drlk001', 1 * EnableLane4},



{383, 'xrl0403', 1 * EnableLane1},
"NULL",
{385, 'xrl0403', 1 * EnableLane2},
"NULL",
{387, 'xrl0403', 1 * EnableLane3},
"NULL",
{389, 'xrl0403', 1 * EnableLane4},
"NULL",

{391, 'urs0302', 1},
{392, 'xrs0205', 1, 'ura0303', 15},

{393, 'url0103', 6, 'url0101', 1, 'url0107', 5},

{394, 'xra0105', 0 * EnableLane5},
{395, 'xra0105', 0 * EnableLane5},
{396, 'ura0203', 0 * EnableLane5},
{397, 'ura0203', 0 * EnableLane5},
{398, 'xra0305', 0 * EnableLane5},
{399, 'xra0305', 0 * EnableLane5},
{400, 'ura0401', 0 * EnableLane5},


{401, 'url0402', 1 * EnableLane1},
"NULL",
{403, 'url0402', 1 * EnableLane2},
"NULL",
{405, 'url0402', 1 * EnableLane3},
"NULL",
{407, 'url0402', 1 * EnableLane4},
"NULL",

{409, 'url0402', 1 * EnableLane1},
"NULL",
{411, 'url0402', 1 * EnableLane2},
"NULL",
{413, 'url0402', 1 * EnableLane3},
"NULL",
{415, 'url0402', 1 * EnableLane4},
"NULL",

{417, 'url0402', 1 * EnableLane1},
"NULL",
{419, 'url0402', 1 * EnableLane2},
"NULL",
{421, 'url0402', 1 * EnableLane3},
"NULL",
{423, 'url0402', 1 * EnableLane4},
"NULL",

{425, 'url0402', 1 * EnableLane1},
"NULL",
{427, 'url0402', 1 * EnableLane2},
"NULL",
{429, 'url0402', 1 * EnableLane3},
"NULL",
{431, 'url0402', 1 * EnableLane4},
"NULL",

{433, 'url0402', 1 * EnableLane1},
"NULL",
{435, 'url0402', 1 * EnableLane2},
"NULL",
{437, 'url0402', 1 * EnableLane3},
"NULL",
{439, 'url0402', 1 * EnableLane4},
"NULL",

{441, 'url0402', 1 * EnableLane1},
"NULL",
{443, 'url0402', 1 * EnableLane2},
"NULL",
{445, 'url0402', 1 * EnableLane3},
"NULL",
{447, 'url0402', 1 * EnableLane4},
"NULL",

{449, 'url0402', 1 * EnableLane1},
"NULL",
{451, 'url0402', 1 * EnableLane2},
"NULL",
{453, 'url0402', 1 * EnableLane3},
"NULL",
{455, 'url0402', 1 * EnableLane4},
"NULL",

{457, 'url0402', 1 * EnableLane1},
"NULL",
{459, 'url0402', 1 * EnableLane2},
"NULL",
{461, 'url0402', 1 * EnableLane3},
"NULL",
{463, 'url0402', 1 * EnableLane4},
"NULL",

{465, 'url0402', 1 * EnableLane1},
"NULL",
{467, 'url0402', 1 * EnableLane2},
"NULL",
{469, 'url0402', 1 * EnableLane3},
"NULL",
{471, 'url0402', 1 * EnableLane4},
"NULL",

{473, 'url0402', 1 * EnableLane1},
"NULL",
{475, 'url0402', 1 * EnableLane2},
"NULL",
{477, 'url0402', 1 * EnableLane3},
"NULL",
{479, 'url0402', 1 * EnableLane4},
"NULL",




{481, 'xrl0403', 1 * EnableLane1},
"NULL",
{483, 'xrl0403', 1 * EnableLane2},
"NULL",
{485, 'xrl0403', 1 * EnableLane3},
"NULL",
{387, 'xrl0403', 1 * EnableLane4},
"NULL",

{489, 'xrl0403', 1 * EnableLane1},
"NULL",
{491, 'xrl0403', 1 * EnableLane2},
"NULL",
{493, 'xrl0403', 1 * EnableLane3},
"NULL",
{495, 'xrl0403', 1 * EnableLane4},
"NULL",

{497, 'xrl0403', 1 * EnableLane1},
"NULL",
{499, 'xrl0403', 1 * EnableLane2},
"NULL",
{501, 'xrl0403', 1 * EnableLane3},
"NULL",
{503, 'xrl0403', 1 * EnableLane4},
"NULL",

{505, 'xrl0403', 1 * EnableLane1},
"NULL",
{507, 'xrl0403', 1 * EnableLane2},
"NULL",
{509, 'xrl0403', 1 * EnableLane3},
"NULL",
{511, 'xrl0403', 1 * EnableLane4},
"NULL",

{513, 'xrl0403', 1 * EnableLane1},
"NULL",
{515, 'xrl0403', 1 * EnableLane2},
"NULL",
{517, 'xrl0403', 1 * EnableLane3},
"NULL",
{519, 'xrl0403', 1 * EnableLane4},
"NULL",

{521, 'xrl0403', 1 * EnableLane1},
"NULL",
{523, 'xrl0403', 1 * EnableLane2},
"NULL",
{525, 'xrl0403', 1 * EnableLane3},
"NULL",
{527, 'xrl0403', 1 * EnableLane4},
"NULL",

{207, 'url0301', 1},
{208, 'url0301', 1},
{209, 'url0301', 1},
{210, 'url0301', 1},
{211, 'url0301', 1},
{212, 'url0301', 1},
{213, 'url0301', 1},
{214, 'url0301', 1},



}
end


--CYBRAN UNITS:

--Air:


--Cybran T1 Air Scout 'ura0101'
--Cybran T1 Interceptor 'ura0102'
--Cybran T1 Attack Bomber 'ura0103'
--Cybran T1 Air Transporter 'ura0107'
--Cybran T1 Air Gunship 'xra0105'

--Cybran T2 Air transport 'ura0104'
--Cybran T2 Fighter/Bomber 'dra0202'
--Cybran T2 Torpedo Bomber 'ura0204'
--Cybran T2 Gunship 'ura0203'

--Cybran T3 Spy Plane 'ura0302'
--Cybran T3 ASF 'ura0303'
--Cybran T3 Strategic Bomber 'ura0304'
--Cybran T3 Heavy Gunship 'xra0305'

--Cybran T4 Experimental Gunship 'ura0401'

--'url0205', 'url0104', 'url0101'

--Land:

--Cybran T1 Land Scout 'url0101'
--Cybran T1 Mobile Light Artillery 'url0103'
--Cybran T1 Mobile Anti-Air Gun 'url0104'
--Cybran T1 Light Assault Bot 'url0106'
--Cybran T1 Assault Bot 'url0107'


--Cybran T2 Mobile Missile Launcher 'url0111'
--Cybran T2 Rocket Bot 'drl0204'
--Cybran T2 Heavy Tank 'url0202'
--Cybran T2 Amphibious Tank 'url0203'
--Cybran T2 Mobile AA Flak Artillery 'url0205'
--Cybran T2 Mobile Stealth Field System 'url0306'
--Cybran T2 Mobile Bomb 'xrl0302'

--Cybran T3 Siege Assault Bot 'url0303'
--Cybran T3 Mobile Heavy Artillery 'url0304'
--Cybran T3 Armored Assault Bot 'xrl0305'

--Cybran T3 Support Armored Command Unit 'url0301'

--Cybran T4 Experimental Spider Bot 'url0402'
--Cybran T4 Experimental Megabot 'xrl0403'
--Cybran T4 Experimental Mobile Rapid-Fire Artillery 'url0401'


--Naval:

--T1 Cybran Naval 'urs0103'
--T1 Cybran Attack Submarine 'urs0203'

--T2 Cybran Destroyer 'urs0201'
--T2 Cybran Cruiser 'urs0202'
--T2 Cybran Submarine Killer 'xrs0204'
--T2 Cybran Counter-Intelligence Boat 'xrs0205'

--T3 Cybran Battleship 'urs0302'
--T3 Cybran Aircraft Carrier 'urs0303'
--T3 Cybran Strategic Missile Submarine 'urs0304'
--T3 Cybran Sonar Platform 'urs0305'








CreateWaveTableOrders = function()

WaveOrders = {
{1,  "Survival_LandSpawn1", 80, 'None',
"IssueAttackFormation", LandWaypoints1, nil},

{2, "Survival_LandSpawn2", 95, 'None',
"IssueAttackFormation", LandWaypoints2, nil},

{3, "Survival_LandSpawn3", 95, 'None',
"IssueAttackFormation", LandWaypoints3, nil},

{4, "Survival_LandSpawn4", 85, 'None',
"IssueAttackFormation", LandWaypoints4, nil},


{5, "Survival_LandSpawn1", 120, 'None',
"IssueAttackFormation", LandWaypoints1, nil},

{6, "Survival_LandSpawn2", 135, 'None',
"IssueAttackFormation", LandWaypoints2, nil},

{7, "Survival_LandSpawn3", 135, 'None',
"IssueAttackFormation", LandWaypoints3, nil},

{8, "Survival_LandSpawn4", 125, 'None',
"IssueAttackFormation", LandWaypoints4, nil},


{9, "Survival_LandSpawn1", 160, 'None',
"IssueAttackFormation", LandWaypoints1, nil},

{10, "Survival_LandSpawn2", 175, 'None',
"IssueAttackFormation", LandWaypoints2, nil},

{11, "Survival_LandSpawn3", 175, 'None',
"IssueAttackFormation", LandWaypoints3, nil},

{12, "Survival_LandSpawn4", 165, 'None',
"IssueAttackFormation", LandWaypoints4, nil},


{13, "Survival_LandSpawn1", 200, 'None',
"IssueAttackFormation", LandWaypoints1, nil},

{14, "Survival_LandSpawn2", 215, 'None',
"IssueAttackFormation", LandWaypoints2, nil},

{15, "Survival_LandSpawn3", 215, 'None',
"IssueAttackFormation", LandWaypoints3, nil},

{16, "Survival_LandSpawn4", 205, 'None',
"IssueAttackFormation", LandWaypoints4, nil},


{17, "Survival_LandSpawn1", 240, 'None',
"IssueAttackFormation", LandWaypoints1, nil},

{18, "Survival_LandSpawn2", 255, 'None',
"IssueAttackFormation", LandWaypoints2, nil},

{19, "Survival_LandSpawn3", 255, 'None',
"IssueAttackFormation", LandWaypoints3, nil},

{20, "Survival_LandSpawn4", 245, 'None',
"IssueAttackFormation", LandWaypoints4, nil},


{21, "Survival_LandSpawn1", 300, 'None',
"IssueAttackFormation", LandWaypoints1, nil},

{22, "Survival_LandSpawn2", 315, 'None',
"IssueAttackFormation", LandWaypoints2, nil},

{23, "Survival_LandSpawn3", 315, 'None',
"IssueAttackFormation", LandWaypoints3, nil},

{24, "Survival_LandSpawn4", 305, 'None',
"IssueAttackFormation", LandWaypoints4, nil},


{25, "Survival_LandSpawn1", 305, 'None',
"IssueAttackFormation", LandWaypoints1, nil},

{26, "Survival_LandSpawn2", 320, 'None',
"IssueAttackFormation", LandWaypoints2, nil},

{27, "Survival_LandSpawn3", 320, 'None',
"IssueAttackFormation", LandWaypoints3, nil},

{28, "Survival_LandSpawn4", 310, 'None',
"IssueAttackFormation", LandWaypoints4, nil},


{29, "Survival_LandSpawn1", 340, 'None',
"IssueAttackFormation", LandWaypoints1, nil},

{30, "Survival_LandSpawn2", 355, 'None',
"IssueAttackFormation", LandWaypoints2, nil},

{31, "Survival_LandSpawn3", 355, 'None',
"IssueAttackFormation", LandWaypoints3, nil},

{32, "Survival_LandSpawn4", 345, 'None',
"IssueAttackFormation", LandWaypoints4, nil},


{33, "Survival_LandSpawn1", 345, 'None',
"IssueAttackFormation", LandWaypoints1, nil},

{34, "Survival_LandSpawn2", 360, 'None',
"IssueAttackFormation", LandWaypoints2, nil},

{35, "Survival_LandSpawn3", 360, 'None',
"IssueAttackFormation", LandWaypoints3, nil},

{36, "Survival_LandSpawn4", 355, 'None',
"IssueAttackFormation", LandWaypoints4, nil},


{37, "Survival_LandSpawn1", 380, 'None',
"IssueAttackFormation", LandWaypoints1, nil},

{38, "Survival_LandSpawn2", 395, 'None',
"IssueAttackFormation", LandWaypoints2, nil},

{39, "Survival_LandSpawn3", 395, 'None',
"IssueAttackFormation", LandWaypoints3, nil},

{40, "Survival_LandSpawn4", 385, 'None',
"IssueAttackFormation", LandWaypoints4, nil},


{41, "Survival_LandSpawn1", 385, 'None',
"IssueAttackFormation", LandWaypoints1, nil},

{42, "Survival_LandSpawn2", 400 , 'None',
"IssueAttackFormation", LandWaypoints2, nil},

{43, "Survival_LandSpawn3", 400, 'None',
"IssueAttackFormation", LandWaypoints3, nil},

{44, "Survival_LandSpawn4", 390, 'None',
"IssueAttackFormation", LandWaypoints4, nil},


{45, "Survival_LandSpawn1", 420, 'None',
"IssueAttackFormation", LandWaypoints1, nil},

{46, "Survival_LandSpawn2", 435, 'None',
"IssueAttackFormation", LandWaypoints2, nil},

{47, "Survival_LandSpawn3", 435, 'None',
"IssueAttackFormation", LandWaypoints3, nil},

{48, "Survival_LandSpawn4", 425, 'None',
"IssueAttackFormation", LandWaypoints4, nil},


{49, "Survival_LandSpawn1", 425, 'None',
"IssueAttackFormation", LandWaypoints1, nil},

{50, "Survival_LandSpawn2", 440, 'None',
"IssueAttackFormation", LandWaypoints2, nil},

{51, "Survival_LandSpawn3", 440, 'None',
"IssueAttackFormation", LandWaypoints3, nil},

{52, "Survival_LandSpawn4", 430, 'None',
"IssueAttackFormation", LandWaypoints4, nil},


{53, "Survival_LandSpawn1", 460, 'None',
"IssueAttackFormation", LandWaypoints1, nil},

{54, "Survival_LandSpawn2", 475, 'None',
"IssueAttackFormation", LandWaypoints2, nil},

{55, "Survival_LandSpawn3", 475, 'None',
"IssueAttackFormation", LandWaypoints3, nil},

{56, "Survival_LandSpawn4", 465, 'None',
"IssueAttackFormation", LandWaypoints4, nil},


{57, "Survival_LandSpawn1", 465, 'None',
"IssueAttackFormation", LandWaypoints1, nil},

{58, "Survival_LandSpawn2", 480, 'None',
"IssueAttackFormation", LandWaypoints2, nil},

{59, "Survival_LandSpawn3", 480, 'None',
"IssueAttackFormation", LandWaypoints3, nil},

{60, "Survival_LandSpawn4", 470, 'None',
"IssueAttackFormation", LandWaypoints4, nil},



{61, "Survival_LandSpawn1", 525, 'None',
"IssueMove", LandWaypoints1, nil},

{62, "Survival_LandSpawn2", 540, 'None',
"IssueMove", LandWaypoints2, nil},

{63, "Survival_LandSpawn3", 540, 'None',
"IssueMove", LandWaypoints3, nil},

{64, "Survival_LandSpawn4", 530, 'None',
"IssueMove", LandWaypoints4, nil},


{65, "Survival_LandSpawn1", 565, 'None',
"IssueMove", LandWaypoints1, nil},

{66, "Survival_LandSpawn2", 580, 'None',
"IssueMove", LandWaypoints2, nil},

{67, "Survival_LandSpawn3", 580, 'None',
"IssueMove", LandWaypoints3, nil},

{68, "Survival_LandSpawn4", 570, 'None',
"IssueMove", LandWaypoints4, nil},


{69, "Survival_LandSpawn1", 605, 'None',
"IssueMove", LandWaypoints1, nil},

{70, "Survival_LandSpawn2", 620, 'None',
"IssueMove", LandWaypoints2, nil},

{71, "Survival_LandSpawn3", 620, 'None',
"IssueMove", LandWaypoints3, nil},

{72, "Survival_LandSpawn4", 610, 'None',
"IssueMove", LandWaypoints4, nil},


{73, "Survival_LandSpawn1", 645, 'None',
"IssueMove", LandWaypoints1, nil},

{74, "Survival_LandSpawn2", 660, 'None',
"IssueMove", LandWaypoints2, nil},

{75, "Survival_LandSpawn3", 660, 'None',
"IssueMove", LandWaypoints3, nil},

{76, "Survival_LandSpawn4", 650, 'None',
"IssueMove", LandWaypoints4, nil},


{77, "Survival_LandSpawn1", 685, 'None',
"IssueMove", LandWaypoints1, nil},

{78, "Survival_LandSpawn2", 700, 'None',
"IssueMove", LandWaypoints2, nil},

{79, "Survival_LandSpawn3", 700 , 'None',
"IssueMove", LandWaypoints3, nil},

{80, "Survival_LandSpawn4", 690, 'None',
"IssueMove", LandWaypoints4, nil},




{81, "Survival_LandSpawn1", 745, 'None',
"IssueMove", LandWaypoints1, nil},

{82, "Survival_LandSpawn2", 760, 'None',
"IssueMove", LandWaypoints2, nil},

{83, "Survival_LandSpawn3", 760, 'None',
"IssueMove", LandWaypoints3, nil},

{84, "Survival_LandSpawn4", 750, 'None',
"IssueMove", LandWaypoints4, nil},


{85, "Survival_LandSpawn1", 755, 'None',
"IssueAttackFormation", LandWaypoints1, nil},

{86, "Survival_LandSpawn2", 770, 'None',
"IssueAttackFormation", LandWaypoints2, nil},

{87, "Survival_LandSpawn3", 770, 'None',
"IssueAttackFormation", LandWaypoints3, nil},

{88, "Survival_LandSpawn4", 760, 'None',
"IssueAttackFormation", LandWaypoints4, nil},


{89, "Survival_LandSpawn1", 785, 'None',
"IssueMove", LandWaypoints1, nil},

{90, "Survival_LandSpawn2", 800, 'None',
"IssueMove", LandWaypoints2, nil},

{91, "Survival_LandSpawn3", 800, 'None',
"IssueMove", LandWaypoints3, nil},

{92, "Survival_LandSpawn4", 790, 'None',
"IssueMove", LandWaypoints4, nil},


{93, "Survival_LandSpawn1", 795, 'None',
"IssueAttackFormation", LandWaypoints1, nil},

{94, "Survival_LandSpawn2", 810, 'None',
"IssueAttackFormation", LandWaypoints2, nil},

{95, "Survival_LandSpawn3", 810, 'None',
"IssueAttackFormation", LandWaypoints3, nil},

{96, "Survival_LandSpawn4", 800, 'None',
"IssueAttackFormation", LandWaypoints4, nil},


{97, "Survival_LandSpawn1", 825, 'None',
"IssueMove", LandWaypoints1, nil},

{98, "Survival_LandSpawn2", 840, 'None',
"IssueMove", LandWaypoints2, nil},

{99, "Survival_LandSpawn3", 840, 'None',
"IssueMove", LandWaypoints3, nil},

{100, "Survival_LandSpawn4", 830, 'None',
"IssueMove", LandWaypoints4, nil},


{101, "Survival_LandSpawn1", 835, 'None',
"IssueAttackFormation", LandWaypoints1, nil},

{102, "Survival_LandSpawn2", 850, 'None',
"IssueAttackFormation", LandWaypoints2, nil},

{103, "Survival_LandSpawn3", 850, 'None',
"IssueAttackFormation", LandWaypoints3, nil},

{104, "Survival_LandSpawn4", 840, 'None',
"IssueAttackFormation", LandWaypoints4, nil},


{105, "Survival_LandSpawn1", 875, 'None',
"IssueMove", LandWaypoints1, nil},

{106, "Survival_LandSpawn2", 890, 'None',
"IssueMove", LandWaypoints2, nil},

{107, "Survival_LandSpawn3", 890, 'None',
"IssueMove", LandWaypoints3, nil},

{108, "Survival_LandSpawn4", 880, 'None',
"IssueMove", LandWaypoints4, nil},


{109, "Survival_LandSpawn1", 885, 'None',
"IssueAttackFormation", LandWaypoints1, nil},

{110, "Survival_LandSpawn2", 900, 'None',
"IssueAttackFormation", LandWaypoints2, nil},

{111, "Survival_LandSpawn3", 900, 'None',
"IssueAttackFormation", LandWaypoints3, nil},

{112, "Survival_LandSpawn4", 890, 'None',
"IssueAttackFormation", LandWaypoints4, nil},


{113, "Survival_LandSpawn1", 915, 'None',
"IssueMove", LandWaypoints1, nil},

{114, "Survival_LandSpawn2", 930, 'None',
"IssueMove", LandWaypoints2, nil},

{115, "Survival_LandSpawn3", 930, 'None',
"IssueMove", LandWaypoints3, nil},

{116, "Survival_LandSpawn4", 920, 'None',
"IssueMove", LandWaypoints4, nil},


{117, "Survival_LandSpawn1", 925, 'None',
"IssueAttackFormation", LandWaypoints1, nil},

{118, "Survival_LandSpawn2", 940, 'None',
"IssueAttackFormation", LandWaypoints2, nil},

{119, "Survival_LandSpawn3", 940, 'None',
"IssueAttackFormation", LandWaypoints3, nil},

{120, "Survival_LandSpawn4", 930, 'None',
"IssueAttackFormation", LandWaypoints4, nil},







{121, "Survival_LandSpawn1", 750, 'None',
"IssueAttackFormation", LandWaypoints1, nil},

{122, "Survival_LandSpawn2", 765, 'None',
"IssueAttackFormation", LandWaypoints2, nil},

{123, "Survival_LandSpawn3", 765, 'None',
"IssueAttackFormation", LandWaypoints3, nil},

{124, "Survival_LandSpawn4", 755, 'None',
"IssueAttackFormation", LandWaypoints4, nil},


{125, "Survival_LandSpawn1", 750, 'None',
"GiveAssistOrder", 121, 'url0111'},

{126, "Survival_LandSpawn2", 765, 'None',
"GiveAssistOrder", 122, 'url0111'},

{127, "Survival_LandSpawn3", 765, 'None',
"GiveAssistOrder", 123, 'url0111'},

{128, "Survival_LandSpawn4", 755, 'None',
"GiveAssistOrder", 124, 'url0111'},


{129, "Survival_LandSpawn1", 790, 'None',
"IssueAttackFormation", LandWaypoints1, nil},

{130, "Survival_LandSpawn2", 805, 'None',
"IssueAttackFormation", LandWaypoints2, nil},

{131, "Survival_LandSpawn3", 805, 'None',
"IssueAttackFormation", LandWaypoints3, nil},

{132, "Survival_LandSpawn4", 795, 'None',
"IssueAttackFormation", LandWaypoints4, nil},


{133, "Survival_LandSpawn1", 790, 'None',
"GiveAssistOrder", 129, 'url0111'},

{134, "Survival_LandSpawn2", 805, 'None',
"GiveAssistOrder", 130, 'url0111'},

{135, "Survival_LandSpawn3", 805, 'None',
"GiveAssistOrder", 131, 'url0111'},

{136, "Survival_LandSpawn4", 795, 'None',
"GiveAssistOrder", 132, 'url0111'},


{137, "Survival_LandSpawn1", 830, 'None',
"IssueAttackFormation", LandWaypoints1, nil},

{138, "Survival_LandSpawn2", 845, 'None',
"IssueAttackFormation", LandWaypoints2, nil},

{139, "Survival_LandSpawn3", 845, 'None',
"IssueAttackFormation", LandWaypoints3, nil},

{140, "Survival_LandSpawn4", 835, 'None',
"IssueAttackFormation", LandWaypoints4, nil},


{141, "Survival_LandSpawn1", 830, 'None',
"GiveAssistOrder", 137, 'url0111'},

{142, "Survival_LandSpawn2", 845, 'None',
"GiveAssistOrder", 138, 'url0111'},

{143, "Survival_LandSpawn3", 845, 'None',
"GiveAssistOrder", 139, 'url0111'},

{144, "Survival_LandSpawn4", 835, 'None',
"GiveAssistOrder", 140, 'url0111'},


{145, "Survival_LandSpawn1", 870, 'None',
"IssueAttackFormation", LandWaypoints1, nil},

{146, "Survival_LandSpawn2", 885, 'None',
"IssueAttackFormation", LandWaypoints2, nil},

{147, "Survival_LandSpawn3", 885, 'None',
"IssueAttackFormation", LandWaypoints3, nil},

{148, "Survival_LandSpawn4", 875, 'None',
"IssueAttackFormation", LandWaypoints4, nil},


{149, "Survival_LandSpawn1", 870, 'None',
"GiveAssistOrder", 145, 'url0111'},

{150, "Survival_LandSpawn2", 885, 'None',
"GiveAssistOrder", 146, 'url0111'},

{151, "Survival_LandSpawn3", 885, 'None',
"GiveAssistOrder", 147, 'url0111'},

{152, "Survival_LandSpawn4", 875, 'None',
"GiveAssistOrder", 148, 'url0111'},


{153, "Survival_LandSpawn1", 910, 'None',
"IssueAttackFormation", LandWaypoints1, nil},

{154, "Survival_LandSpawn2", 925, 'None',
"IssueAttackFormation", LandWaypoints2, nil},

{155, "Survival_LandSpawn3", 925, 'None',
"IssueAttackFormation", LandWaypoints3, nil},

{156, "Survival_LandSpawn4", 915, 'None',
"IssueAttackFormation", LandWaypoints4, nil},


{157, "Survival_LandSpawn1", 910, 'None',
"GiveAssistOrder", 153, 'url0111'},

{158, "Survival_LandSpawn2", 925, 'None',
"GiveAssistOrder", 154, 'url0111'},

{159, "Survival_LandSpawn3", 925, 'None',
"GiveAssistOrder", 155, 'url0111'},

{160, "Survival_LandSpawn4", 915, 'None',
"GiveAssistOrder", 156, 'url0111'},





{161, "Survival_Spawn1", 855 + 60, 'None',
"IssueAttackFormation", LandWaypoints5Destroyer, nil},

{162, "Survival_LandSpawn1", 855 + 0, 'None',
"IssueAttackFormation", LandWaypoints1, nil},

{163, "Survival_LandSpawn2", 855 + 65, 'None',
"IssueAttackFormation", LandWaypoints2, nil},

{164, "Survival_LandSpawn2", 855 + 65, 'None',
"IssueAttackFormation", LandWaypoints2, nil},

{165, "Survival_Spawn4", 855 + 250, 'None',
"IssueAttackFormation", NavyLocation, nil},

{166, "Survival_Spawn4", 855 + 185, 'None',
"IssueAttackFormation", LandWaypoints6Destroyer, nil},

{167, "Survival_LandSpawn3", 855 + 70, 'None',
"IssueAttackFormation", LandWaypoints3, nil},

{168, "Survival_LandSpawn4", 855 + 60, 'None',
"IssueMove", LandWaypoints7DestroyerA, nil,
"IssueAttackFormation", LandWaypoints7DestroyerAEnd, nil},

{169, "Survival_LandSpawn4", 855 + 60, 'None',
"IssueMove", LandWaypoints7DestroyerB, nil,
"IssueAttackFormation", LandWaypoints7DestroyerBEnd, nil},

{170, "Survival_LandSpawn4", 855 + 60, 'None',
"IssueMove", LandWaypoints7DestroyerB, nil,
"IssueAttackFormation", LandWaypoints7DestroyerBEnd, nil},

{171, "Survival_LandSpawn4", 855 + 60, 'None',
"IssueMove", LandWaypoints7DestroyerB, nil,
"IssueAttackFormation", LandWaypoints7DestroyerBEnd, nil},

{172, "Survival_LandSpawn4", 855 + 60, 'None',
"IssueMove", LandWaypoints7DestroyerC, nil,
"IssueAttackFormation", LandWaypoints7DestroyerCEnd, nil},

{173, "Survival_LandSpawn4", 855 + 20, 'None',
"IssueAttackFormation", LandWaypoints4, nil},

{174, "Survival_LandSpawn4", 855 + 20, 'None',
"IssueAttackFormation", LandWaypoints4, nil},




{175,  "Survival_LandSpawn1", 985, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints1Form, nil},

{176, "Survival_LandSpawn2", 985 + 50, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints2Form, nil},

{177, "Survival_LandSpawn3", 985 + 65, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints3Form, nil},

{178, "Survival_LandSpawn4", 985 + 45, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints4Form, nil},


{179,  "Survival_LandSpawn1", 985 + 10, 'None',
"GiveAssistOrder", 175, 'url0202'},

{180, "Survival_LandSpawn2", 985 + 50 + 10, 'None',
"GiveAssistOrder", 176, 'url0202'},

{181, "Survival_LandSpawn3", 985 + 65 + 10, 'None',
"GiveAssistOrder", 177, 'url0202'},

{182, "Survival_LandSpawn4", 985 + 45 + 10, 'None',
"GiveAssistOrder", 178, 'url0202'},



{183,  "Survival_LandSpawn1", 1045, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints1Form, nil},

{184, "Survival_LandSpawn2", 1045 + 50, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints2Form, nil},

{185, "Survival_LandSpawn3", 1045 + 65, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints3Form, nil},

{186, "Survival_LandSpawn4", 1045 + 45, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints4Form, nil},


{187,  "Survival_LandSpawn1", 1045 + 10, 'None',
"GiveAssistOrder", 183, 'url0202'},

{188, "Survival_LandSpawn2", 1045 + 50 + 10, 'None',
"GiveAssistOrder", 184, 'url0202'},

{189, "Survival_LandSpawn3", 1045 + 65 + 10, 'None',
"GiveAssistOrder", 185, 'url0202'},

{190, "Survival_LandSpawn4", 1045 + 45 + 10, 'None',
"GiveAssistOrder", 186, 'url0202'},



{191,  "Survival_LandSpawn1", 1105, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints1Form, nil},

{192, "Survival_LandSpawn2", 1105 + 50, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints2Form, nil},

{193, "Survival_LandSpawn3", 1105 + 65, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints3Form, nil},

{194, "Survival_LandSpawn4", 1105 + 45, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints4Form, nil},


{195,  "Survival_LandSpawn1", 1105 + 10, 'None',
"GiveAssistOrder", 191, 'url0202'},

{196, "Survival_LandSpawn2", 1105 + 50 + 10, 'None',
"GiveAssistOrder", 192, 'url0202'},

{197, "Survival_LandSpawn3", 1105 + 65 + 10, 'None',
"GiveAssistOrder", 193, 'url0202'},

{198, "Survival_LandSpawn4", 1105 + 45 + 10, 'None',
"GiveAssistOrder", 194, 'url0202'},



{199,  "Survival_LandSpawn1", 1165, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints1Form, nil},

{200, "Survival_LandSpawn2", 1165 + 50, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints2Form, nil},

{201, "Survival_LandSpawn3", 1165 + 65, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints3Form, nil},

{202, "Survival_LandSpawn4", 1165 + 45, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints4Form, nil},


{203,  "Survival_LandSpawn1", 1165 + 10, 'None',
"GiveAssistOrder", 199, 'url0202'},

{204, "Survival_LandSpawn2", 1165 + 50 + 10, 'None',
"GiveAssistOrder", 200, 'url0202'},

{205, "Survival_LandSpawn3", 1165 + 65 + 10, 'None',
"GiveAssistOrder", 201, 'url0202'},

{206, "Survival_LandSpawn4", 1165 + 45 + 10, 'None',
"GiveAssistOrder", 202, 'url0202'},



{207,  "Survival_LandSpawn1", 1225, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints1Form, nil},

{208, "Survival_LandSpawn2", 1225 + 50, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints2Form, nil},

{209, "Survival_LandSpawn3", 1225 + 65, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints3Form, nil},

{210, "Survival_LandSpawn4", 1225 + 45, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints4Form, nil},


{211,  "Survival_LandSpawn1", 1225 + 10, 'None',
"GiveAssistOrder", 207, 'url0202'},

{212, "Survival_LandSpawn2", 1225 + 50 + 10, 'None',
"GiveAssistOrder", 208, 'url0202'},

{213, "Survival_LandSpawn3", 1225 + 65 + 10, 'None',
"GiveAssistOrder", 209, 'url0202'},

{214, "Survival_LandSpawn4", 1225 + 45 + 10, 'None',
"GiveAssistOrder", 210, 'url0202'},




{215, "Survival_Spawn4", 1315, 'GrowthFormation',
"IssueMoveFormation", NavyLocation, nil},




{216,  "Survival_LandSpawn1", 1315, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints1Form, nil},

{217, "Survival_LandSpawn2", 1315 + 50, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints2Form, nil},

{218, "Survival_LandSpawn3", 1315 + 65, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints3Form, nil},

{219, "Survival_LandSpawn4", 1315 + 45, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints4Form, nil},


{220,  "Survival_LandSpawn1", 1315 + 10, 'None',
"GiveAssistOrder", 216, 'xrl0305'},

{221, "Survival_LandSpawn2", 1315 + 50 + 10, 'None',
"GiveAssistOrder", 217, 'xrl0305'},

{222, "Survival_LandSpawn3", 1315 + 65 + 10, 'None',
"GiveAssistOrder", 218, 'xrl0305'},

{223, "Survival_LandSpawn4", 1315 + 45 + 10, 'None',
"GiveAssistOrder", 219, 'xrl0305'},



{224,  "Survival_LandSpawn1", 1375, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints1Form, nil},

{225, "Survival_LandSpawn2", 1375 + 50, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints2Form, nil},

{226, "Survival_LandSpawn3", 1375 + 65, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints3Form, nil},

{227, "Survival_LandSpawn4", 1375 + 45, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints4Form, nil},


{228,  "Survival_LandSpawn1", 1375 + 10, 'None',
"GiveAssistOrder", 224, 'xrl0305'},

{229, "Survival_LandSpawn2", 1375 + 50 + 10, 'None',
"GiveAssistOrder", 225, 'xrl0305'},

{230, "Survival_LandSpawn3", 1375 + 65 + 10, 'None',
"GiveAssistOrder", 226, 'xrl0305'},

{231, "Survival_LandSpawn4", 1375 + 45 + 10, 'None',
"GiveAssistOrder", 227, 'xrl0305'},



{232,  "Survival_LandSpawn1", 1435, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints1Form, nil},

{233, "Survival_LandSpawn2", 1435 + 50, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints2Form, nil},

{234, "Survival_LandSpawn3", 1435 + 65, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints3Form, nil},

{235, "Survival_LandSpawn4", 1435 + 45, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints4Form, nil},


{236,  "Survival_LandSpawn1", 1435 + 10, 'None',
"GiveAssistOrder", 232, 'xrl0305'},

{237, "Survival_LandSpawn2", 1435 + 50 + 10, 'None',
"GiveAssistOrder", 233, 'xrl0305'},

{238, "Survival_LandSpawn3", 1435 + 65 + 10, 'None',
"GiveAssistOrder", 234, 'xrl0305'},

{239, "Survival_LandSpawn4", 1435 + 45 + 10, 'None',
"GiveAssistOrder", 235, 'xrl0305'},



{240,  "Survival_LandSpawn1", 1495, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints1Form, nil},

{241, "Survival_LandSpawn2", 1495 + 50, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints2Form, nil},

{242, "Survival_LandSpawn3", 1495 + 65, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints3Form, nil},

{243, "Survival_LandSpawn4", 1495 + 45, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints4Form, nil},


{244,  "Survival_LandSpawn1", 1495 + 10, 'None',
"GiveAssistOrder", 240, 'xrl0305'},

{245, "Survival_LandSpawn2", 1495 + 50 + 10, 'None',
"GiveAssistOrder", 241, 'xrl0305'},

{246, "Survival_LandSpawn3", 1495 + 65 + 10, 'None',
"GiveAssistOrder", 242, 'xrl0305'},

{247, "Survival_LandSpawn4", 1495 + 45 + 10, 'None',
"GiveAssistOrder", 243, 'xrl0305'},



{248,  "Survival_LandSpawn1", 1555, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints1Form, nil},

{249, "Survival_LandSpawn2", 1555 + 50, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints2Form, nil},

{250, "Survival_LandSpawn3", 1555 + 65, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints3Form, nil},

{251, "Survival_LandSpawn4", 1555 + 45, 'GrowthFormation',
"IssueMoveFormation", LandWaypoints4Form, nil},


{252,  "Survival_LandSpawn1", 1555 + 10, 'None',
"GiveAssistOrder", 248, 'xrl0305'},

{253, "Survival_LandSpawn2", 1555 + 50 + 10, 'None',
"GiveAssistOrder", 249, 'xrl0305'},

{254, "Survival_LandSpawn3", 1555 + 65 + 10, 'None',
"GiveAssistOrder", 250, 'xrl0305'},

{255, "Survival_LandSpawn4", 1555 + 45 + 10, 'None',
"GiveAssistOrder", 251, 'xrl0305'},




{256,  "Survival_LandSpawn1", 1645, 'AttackFormation',
"IssueMoveFormation", LandWaypoints1Form, nil},

{257, "Survival_LandSpawn2", 1645 + 50, 'AttackFormation',
"IssueMoveFormation", LandWaypoints2Form, nil},

{258, "Survival_LandSpawn3", 1645 + 65, 'AttackFormation',
"IssueMoveFormation", LandWaypoints3Form, nil},

{259, "Survival_LandSpawn4", 1645 + 45, 'AttackFormation',
"IssueMoveFormation", LandWaypoints4Form, nil},


{260,  "Survival_LandSpawn1", 1705, 'AttackFormation',
"IssueMoveFormation", LandWaypoints1Form, nil},

{261, "Survival_LandSpawn2", 1705 + 50, 'AttackFormation',
"IssueMoveFormation", LandWaypoints2Form, nil},

{262, "Survival_LandSpawn3", 1705 + 65, 'AttackFormation',
"IssueMoveFormation", LandWaypoints3Form, nil},

{263, "Survival_LandSpawn4", 1705 + 45, 'AttackFormation',
"IssueMoveFormation", LandWaypoints4Form, nil},


{264,  "Survival_LandSpawn1", 1765, 'AttackFormation',
"IssueMoveFormation", LandWaypoints1Form, nil},

{265, "Survival_LandSpawn2", 1765 + 50, 'AttackFormation',
"IssueMoveFormation", LandWaypoints2Form, nil},

{266, "Survival_LandSpawn3", 1765 + 65, 'AttackFormation',
"IssueMoveFormation", LandWaypoints3Form, nil},

{267, "Survival_LandSpawn4", 1765 + 45, 'AttackFormation',
"IssueMoveFormation", LandWaypoints4Form, nil},


{268,  "Survival_LandSpawn1", 1825, 'AttackFormation',
"IssueMoveFormation", LandWaypoints1Form, nil},

{269, "Survival_LandSpawn2", 1825 + 50, 'AttackFormation',
"IssueMoveFormation", LandWaypoints2Form, nil},

{270, "Survival_LandSpawn3", 1825 + 65, 'AttackFormation',
"IssueMoveFormation", LandWaypoints3Form, nil},

{271, "Survival_LandSpawn4", 1825 + 45, 'AttackFormation',
"IssueMoveFormation", LandWaypoints4Form, nil},


{272,  "Survival_LandSpawn1", 1885, 'AttackFormation',
"IssueMoveFormation", LandWaypoints1Form, nil},

{273, "Survival_LandSpawn2", 1885 + 50, 'AttackFormation',
"IssueMoveFormation", LandWaypoints2Form, nil},

{274, "Survival_LandSpawn3", 1885 + 65, 'AttackFormation',
"IssueMoveFormation", LandWaypoints3Form, nil},

{275, "Survival_LandSpawn4", 1885 + 45, 'AttackFormation',
"IssueMoveFormation", LandWaypoints4Form, nil},






{276, "Survival_Spawn1", 1645 + 145 + WaveDelay[1], 'None',
"IssueMoveFormation", LandWaypoints5Destroyer, nil,
"IssueNameChange", 'url0402', nil},

{277, "Survival_LandSpawn1", 1645 + 145 + WaveDelay[1], 'None',
"IssueMoveFormation", LandWaypoints1, nil,
"IssueNameChange", 'url0402', nil},

{278, "Survival_LandSpawn2", 1645 + 145 + 35 + WaveDelay[2], 'None',
"IssueMoveFormation", LandWaypoints2, nil,
"IssueNameChange", 'url0402', nil},

{279, "Survival_LandSpawn2", 1645 + 145 + 35 + WaveDelay[2], 'None',
"IssueMoveFormation", LandWaypoints2, nil,
"IssueNameChange", 'url0402', nil},

{280, "Survival_Spawn4", 1645 + 145 + 55 + WaveDelay[3], 'None',
"IssueMoveFormation", LandWaypoints6Destroyer, nil,
"IssueNameChange", 'url0402', nil},

{281, "Survival_LandSpawn3", 1645 + 145 + 40 + WaveDelay[3], 'None',
"IssueMoveFormation", LandWaypoints3, nil,
"IssueNameChange", 'url0402', nil},

{282, "Survival_LandSpawn4", 1645 + 145 + 10 + WaveDelay[4], 'None',
"IssueMoveFormation", LandWaypoints4, nil,
"IssueNameChange", 'url0402', nil},

{283, "Survival_LandSpawn4", 1645 + 145 + 10 + WaveDelay[4], 'None',
"IssueMoveFormation", LandWaypoints4, nil,
"IssueNameChange", 'url0402', nil},




{284, "Survival_Spawn4", 1920, 'GrowthFormation',
"IssueMoveFormation", NavyLocation, nil},


{285, "Survival_Spawn4", 2160, 'None',
"IssueAttackFormation", NavyLocation, nil,
"IssueNameChange", 'urs0302', nil},

{286,  "Survival_Spawn4", 2160 + 5, 'None',
"GiveAssistOrder", 285, 'urs0302'},

{391, "Survival_Spawn4", 2160 + 10, 'None',
"IssueAttackFormation", NavyLocation, nil,
"IssueNameChange", 'urs0302', nil},

{392,  "Survival_Spawn4", 2160 + 10 + 5, 'None',
"GiveAssistOrder", 391, 'urs0302'},





{287,  "Survival_LandSpawn1", 1975, 'AttackFormation',
"IssueMoveFormation", LandWaypoints1Form, nil,
"Enhancements", "CombatantStrong", nil},

{288, "Survival_LandSpawn2", 1975 + 50, 'AttackFormation',
"IssueMoveFormation", LandWaypoints2Form, nil,
"Enhancements", "CombatantStrong", nil},

{289, "Survival_LandSpawn3", 1975 + 65, 'AttackFormation',
"IssueMoveFormation", LandWaypoints3Form, nil,
"Enhancements", "CombatantStrong", nil},

{290, "Survival_LandSpawn4", 1975 + 45, 'AttackFormation',
"IssueMoveFormation", LandWaypoints4Form, nil,
"Enhancements", "CombatantStrong", nil},


{291,  "Survival_LandSpawn1", 1975 + 10, 'None',
"GiveAssistOrder", 287, 'xrl0305'},

{292, "Survival_LandSpawn2", 1975 + 50 + 10, 'None',
"GiveAssistOrder", 288, 'xrl0305'},

{293, "Survival_LandSpawn3", 1975 + 65 + 10, 'None',
"GiveAssistOrder", 289, 'xrl0305'},

{294, "Survival_LandSpawn4", 1975 + 45 + 10, 'None',
"GiveAssistOrder", 290, 'xrl0305'},


{295,  "Survival_LandSpawn1", 1975 + 10, 'None',
"GiveAssistOrder", 291, 'url0304'},

{296, "Survival_LandSpawn2", 1975 + 50 + 10, 'None',
"GiveAssistOrder", 292, 'url0304'},

{297, "Survival_LandSpawn3", 1975 + 65 + 10, 'None',
"GiveAssistOrder", 293, 'url0304'},

{298, "Survival_LandSpawn4", 1975 + 45 + 10, 'None',
"GiveAssistOrder", 294, 'url0304'},


{299,  "Survival_LandSpawn1", 2035, 'AttackFormation',
"IssueMoveFormation", LandWaypoints1Form, nil},

{300, "Survival_LandSpawn2", 2035 + 50, 'AttackFormation',
"IssueMoveFormation", LandWaypoints2Form, nil},

{301, "Survival_LandSpawn3", 2035 + 65, 'AttackFormation',
"IssueMoveFormation", LandWaypoints3Form, nil},

{302, "Survival_LandSpawn4", 2035 + 45, 'AttackFormation',
"IssueMoveFormation", LandWaypoints4Form, nil},


{303,  "Survival_LandSpawn1", 2035 + 10, 'None',
"GiveAssistOrder", 299, 'xrl0305'},

{304, "Survival_LandSpawn2", 2035 + 50 + 10, 'None',
"GiveAssistOrder", 300, 'xrl0305'},

{305, "Survival_LandSpawn3", 2035 + 65 + 10, 'None',
"GiveAssistOrder", 301, 'xrl0305'},

{306, "Survival_LandSpawn4", 2035 + 45 + 10, 'None',
"GiveAssistOrder", 302, 'xrl0305'},


{307,  "Survival_LandSpawn1", 2035 + 10, 'None',
"GiveAssistOrder", 303, 'url0304'},

{308, "Survival_LandSpawn2", 2035 + 50 + 10, 'None',
"GiveAssistOrder", 304, 'url0304'},

{309, "Survival_LandSpawn3", 2035 + 65 + 10, 'None',
"GiveAssistOrder", 305, 'url0304'},

{310, "Survival_LandSpawn4", 2035 + 45 + 10, 'None',
"GiveAssistOrder", 306, 'url0304'},


{311,  "Survival_LandSpawn1", 2095, 'AttackFormation',
"IssueMoveFormation", LandWaypoints1Form, nil,
"Enhancements", "CombatantStrong", nil},

{312, "Survival_LandSpawn2", 2095 + 50, 'AttackFormation',
"IssueMoveFormation", LandWaypoints2Form, nil,
"Enhancements", "CombatantStrong", nil},

{313, "Survival_LandSpawn3", 2095 + 65, 'AttackFormation',
"IssueMoveFormation", LandWaypoints3Form, nil,
"Enhancements", "CombatantStrong", nil},

{314, "Survival_LandSpawn4", 2095 + 45, 'AttackFormation',
"IssueMoveFormation", LandWaypoints4Form, nil,
"Enhancements", "CombatantStrong", nil},


{315,  "Survival_LandSpawn1", 2095 + 10, 'None',
"GiveAssistOrder", 311, 'xrl0305'},

{316, "Survival_LandSpawn2", 2095 + 50 + 10, 'None',
"GiveAssistOrder", 312, 'xrl0305'},

{317, "Survival_LandSpawn3", 2095 + 65 + 10, 'None',
"GiveAssistOrder", 313, 'xrl0305'},

{318, "Survival_LandSpawn4", 2095 + 45 + 10, 'None',
"GiveAssistOrder", 314, 'xrl0305'},


{319,  "Survival_LandSpawn1", 2095 + 10, 'None',
"GiveAssistOrder", 315, 'url0304'},

{320, "Survival_LandSpawn2", 2095 + 50 + 10, 'None',
"GiveAssistOrder", 316, 'url0304'},

{321, "Survival_LandSpawn3", 2095 + 65 + 10, 'None',
"GiveAssistOrder", 317, 'url0304'},

{322, "Survival_LandSpawn4", 2095 + 45 + 10, 'None',
"GiveAssistOrder", 318, 'url0304'},


{323,  "Survival_LandSpawn1", 2155, 'AttackFormation',
"IssueMoveFormation", LandWaypoints1Form, nil},

{324, "Survival_LandSpawn2", 2155 + 50, 'AttackFormation',
"IssueMoveFormation", LandWaypoints2Form, nil},

{325, "Survival_LandSpawn3", 2155 + 65, 'AttackFormation',
"IssueMoveFormation", LandWaypoints3Form, nil},

{326, "Survival_LandSpawn4", 2155 + 45, 'AttackFormation',
"IssueMoveFormation", LandWaypoints4Form, nil},


{327,  "Survival_LandSpawn1", 2155 + 10, 'None',
"GiveAssistOrder", 323, 'xrl0305'},

{328, "Survival_LandSpawn2", 2155 + 50 + 10, 'None',
"GiveAssistOrder", 324, 'xrl0305'},

{329, "Survival_LandSpawn3", 2155 + 65 + 10, 'None',
"GiveAssistOrder", 325, 'xrl0305'},

{330, "Survival_LandSpawn4", 2155 + 45 + 10, 'None',
"GiveAssistOrder", 326, 'xrl0305'},


{331,  "Survival_LandSpawn1", 2155 + 10, 'None',
"GiveAssistOrder", 327, 'url0304'},

{332, "Survival_LandSpawn2", 2155 + 50 + 10, 'None',
"GiveAssistOrder", 328, 'url0304'},

{333, "Survival_LandSpawn3", 2155 + 65 + 10, 'None',
"GiveAssistOrder", 329, 'url0304'},

{334, "Survival_LandSpawn4", 2155 + 45 + 10, 'None',
"GiveAssistOrder", 330, 'url0304'},


{335,  "Survival_LandSpawn1", 2215, 'AttackFormation',
"IssueMoveFormation", LandWaypoints1Form, nil,
"Enhancements", "CombatantStrong", nil},

{336, "Survival_LandSpawn2", 2215 + 50, 'AttackFormation',
"IssueMoveFormation", LandWaypoints2Form, nil,
"Enhancements", "CombatantStrong", nil},

{337, "Survival_LandSpawn3", 2215 + 65, 'AttackFormation',
"IssueMoveFormation", LandWaypoints3Form, nil,
"Enhancements", "CombatantStrong", nil},

{338, "Survival_LandSpawn4", 2215 + 45, 'AttackFormation',
"IssueMoveFormation", LandWaypoints4Form, nil,
"Enhancements", "CombatantStrong", nil},


{339,  "Survival_LandSpawn1", 2215 + 10, 'None',
"GiveAssistOrder", 335, 'xrl0305'},

{340, "Survival_LandSpawn2", 2215 + 50 + 10, 'None',
"GiveAssistOrder", 336, 'xrl0305'},

{341, "Survival_LandSpawn3", 2215 + 65 + 10, 'None',
"GiveAssistOrder", 337, 'xrl0305'},

{342, "Survival_LandSpawn4", 2215 + 45 + 10, 'None',
"GiveAssistOrder", 338, 'xrl0305'},


{343,  "Survival_LandSpawn1", 2215 + 10, 'None',
"GiveAssistOrder", 339, 'url0304'},

{344, "Survival_LandSpawn2", 2215 + 50 + 10, 'None',
"GiveAssistOrder", 340, 'url0304'},

{345, "Survival_LandSpawn3", 2215 + 65 + 10, 'None',
"GiveAssistOrder", 341, 'url0304'},

{346, "Survival_LandSpawn4", 2215 + 45 + 10, 'None',
"GiveAssistOrder", 342, 'url0304'},


{347,  "Survival_LandSpawn1", 2275, 'AttackFormation',
"IssueMoveFormation", LandWaypoints1Form, nil},

{348, "Survival_LandSpawn2", 2275 + 50, 'AttackFormation',
"IssueMoveFormation", LandWaypoints2Form, nil},

{349, "Survival_LandSpawn3", 2275 + 65, 'AttackFormation',
"IssueMoveFormation", LandWaypoints3Form, nil},

{350, "Survival_LandSpawn4", 2275 + 45, 'AttackFormation',
"IssueMoveFormation", LandWaypoints4Form, nil},


{351,  "Survival_LandSpawn1", 2275 + 10, 'None',
"GiveAssistOrder", 347, 'xrl0305'},

{352, "Survival_LandSpawn2", 2275 + 50 + 10, 'None',
"GiveAssistOrder", 348, 'xrl0305'},

{353, "Survival_LandSpawn3", 2275 + 65 + 10, 'None',
"GiveAssistOrder", 349, 'xrl0305'},

{354, "Survival_LandSpawn4", 2275 + 45 + 10, 'None',
"GiveAssistOrder", 350, 'xrl0305'},


{355,  "Survival_LandSpawn1", 2275 + 10, 'None',
"GiveAssistOrder", 351, 'url0304'},

{356, "Survival_LandSpawn2", 2275 + 50 + 10, 'None',
"GiveAssistOrder", 352, 'url0304'},

{357, "Survival_LandSpawn3", 2275 + 65 + 10, 'None',
"GiveAssistOrder", 353, 'url0304'},

{358, "Survival_LandSpawn4", 2275 + 45 + 10, 'None',
"GiveAssistOrder", 354, 'url0304'},


{359,  "Survival_LandSpawn1", 2335, 'AttackFormation',
"IssueMoveFormation", LandWaypoints1Form, nil,
"Enhancements", "CombatantStrong", nil},

{360, "Survival_LandSpawn2", 2335 + 50, 'AttackFormation',
"IssueMoveFormation", LandWaypoints2Form, nil,
"Enhancements", "CombatantStrong", nil},

{361, "Survival_LandSpawn3", 2335 + 65, 'AttackFormation',
"IssueMoveFormation", LandWaypoints3Form, nil,
"Enhancements", "CombatantStrong", nil},

{362, "Survival_LandSpawn4", 2335 + 45, 'AttackFormation',
"IssueMoveFormation", LandWaypoints4Form, nil,
"Enhancements", "CombatantStrong", nil},


{363,  "Survival_LandSpawn1", 2335 + 10, 'None',
"GiveAssistOrder", 359, 'xrl0305'},

{364, "Survival_LandSpawn2", 2335 + 50 + 10, 'None',
"GiveAssistOrder", 360, 'xrl0305'},

{365, "Survival_LandSpawn3", 2335 + 65 + 10, 'None',
"GiveAssistOrder", 361, 'xrl0305'},

{366, "Survival_LandSpawn4", 2335 + 45 + 10, 'None',
"GiveAssistOrder", 362, 'xrl0305'},


{367,  "Survival_LandSpawn1", 2335 + 10, 'None',
"GiveAssistOrder", 363, 'url0304'},

{368, "Survival_LandSpawn2", 2335 + 50 + 10, 'None',
"GiveAssistOrder", 364, 'url0304'},

{369, "Survival_LandSpawn3", 2335 + 65 + 10, 'None',
"GiveAssistOrder", 365, 'url0304'},

{370, "Survival_LandSpawn4", 2335 + 45 + 10, 'None',
"GiveAssistOrder", 366, 'url0304'},


{371,  "Survival_LandSpawn1", 2395, 'AttackFormation',
"IssueMoveFormation", LandWaypoints1Form, nil},

{372, "Survival_LandSpawn2", 2395 + 50, 'AttackFormation',
"IssueMoveFormation", LandWaypoints2Form, nil},

{373, "Survival_LandSpawn3", 2395 + 65, 'AttackFormation',
"IssueMoveFormation", LandWaypoints3Form, nil},

{374, "Survival_LandSpawn4", 2395 + 45, 'AttackFormation',
"IssueMoveFormation", LandWaypoints4Form, nil},


{375,  "Survival_LandSpawn1", 2395 + 10, 'None',
"GiveAssistOrder", 371, 'xrl0305'},

{376, "Survival_LandSpawn2", 2395 + 50 + 10, 'None',
"GiveAssistOrder", 372, 'xrl0305'},

{377, "Survival_LandSpawn3", 2395 + 65 + 10, 'None',
"GiveAssistOrder", 373, 'xrl0305'},

{378, "Survival_LandSpawn4", 2395 + 45 + 10, 'None',
"GiveAssistOrder", 374, 'xrl0305'},


{379,  "Survival_LandSpawn1", 2395 + 10, 'None',
"GiveAssistOrder", 375, 'url0304'},

{380, "Survival_LandSpawn2", 2395 + 50 + 10, 'None',
"GiveAssistOrder", 376, 'url0304'},

{381, "Survival_LandSpawn3", 2395 + 65 + 10, 'None',
"GiveAssistOrder", 377, 'url0304'},

{382, "Survival_LandSpawn4", 2395 + 45 + 10, 'None',
"GiveAssistOrder", 378, 'url0304'},






{383, "Survival_Spawn1", 1975 + 80 + WaveDelay[1], 'None',
"IssueAttackFormation", LandWaypoints5Destroyer, nil,
"IssueNameChange", 'xrl0403', nil},

{384, "Survival_LandSpawn1", 1975 + 80 + WaveDelay[1], 'None',
"IssueAttackFormation", LandWaypoints1, nil,
"IssueNameChange", 'xrl0403', nil},

{385, "Survival_LandSpawn2", 1975 + 80 + 35 + WaveDelay[2], 'None',
"IssueAttackFormation", LandWaypoints2, nil,
"IssueNameChange", 'xrl0403', nil},

{386, "Survival_LandSpawn2", 1975 + 80 + 35 + WaveDelay[2], 'None',
"IssueAttackFormation", LandWaypoints2, nil,
"IssueNameChange", 'xrl0403', nil},

{387, "Survival_Spawn4", 1975 + 80 + 55 + WaveDelay[3], 'None',
"IssueAttackFormation", LandWaypoints6Destroyer, nil,
"IssueNameChange", 'xrl0403', nil},

{388, "Survival_LandSpawn3", 1975 + 80 + 40 + WaveDelay[3], 'None',
"IssueAttackFormation", LandWaypoints3, nil,
"IssueNameChange", 'xrl0403', nil},

{389, "Survival_LandSpawn4", 1975 + 80 + 10 + WaveDelay[4], 'None',
"IssueAttackFormation", LandWaypoints4, nil,
"IssueNameChange", 'xrl0403', nil},

{390, "Survival_LandSpawn4", 1975 + 80 + 10 + WaveDelay[4], 'None',
"IssueAttackFormation", LandWaypoints4, nil,
"IssueNameChange", 'xrl0403', nil},




{393, (ShuffleList(AllTransportSpawns))[1], 10 + 9999, 'None',
"LoadUnitsToTransport", 2, "Tech1", nil},

{394, (ShuffleList(AllTransportSpawns))[1], 6 + 9999, 'None',
"IssueAttackFormation", ValidGunshipTargetsA, nil},



{401, "Survival_Spawn1", 1705 + 145 + WaveDelay[1], 'None',
"IssueMoveFormation", LandWaypoints5Destroyer, nil,
"IssueNameChange", 'url0402', nil},

{402, "Survival_LandSpawn1", 1705 + 145 + WaveDelay[1], 'None',
"IssueMoveFormation", LandWaypoints1, nil,
"IssueNameChange", 'url0402', nil},

{403, "Survival_LandSpawn2", 1705 + 145 + 35 + WaveDelay[2], 'None',
"IssueMoveFormation", LandWaypoints2, nil,
"IssueNameChange", 'url0402', nil},

{404, "Survival_LandSpawn2", 1705 + 145 + 35 + WaveDelay[2], 'None',
"IssueMoveFormation", LandWaypoints2, nil,
"IssueNameChange", 'url0402', nil},

{405, "Survival_Spawn4", 1705 + 145 + 55 + WaveDelay[3], 'None',
"IssueMoveFormation", LandWaypoints6Destroyer, nil,
"IssueNameChange", 'url0402', nil},

{406, "Survival_LandSpawn3", 1705 + 145 + 40 + WaveDelay[3], 'None',
"IssueMoveFormation", LandWaypoints3, nil,
"IssueNameChange", 'url0402', nil},

{407, "Survival_LandSpawn4", 1705 + 145 + 10 + WaveDelay[4], 'None',
"IssueMoveFormation", LandWaypoints4, nil,
"IssueNameChange", 'url0402', nil},

{408, "Survival_LandSpawn4", 1705 + 145 + 10 + WaveDelay[4], 'None',
"IssueMoveFormation", LandWaypoints4, nil,
"IssueNameChange", 'url0402', nil},



{409, "Survival_Spawn1", 1755 + 145 + WaveDelay[1], 'None',
"IssueMoveFormation", LandWaypoints5Destroyer, nil,
"IssueNameChange", 'url0402', nil},

{410, "Survival_LandSpawn1", 1755 + 145 + WaveDelay[1], 'None',
"IssueMoveFormation", LandWaypoints1, nil,
"IssueNameChange", 'url0402', nil},

{411, "Survival_LandSpawn2", 1755 + 145 + 35 + WaveDelay[2], 'None',
"IssueMoveFormation", LandWaypoints2, nil,
"IssueNameChange", 'url0402', nil},

{412, "Survival_LandSpawn2", 1755 + 145 + 35 + WaveDelay[2], 'None',
"IssueMoveFormation", LandWaypoints2, nil,
"IssueNameChange", 'url0402', nil},

{413, "Survival_Spawn4", 1755 + 145 + 55 + WaveDelay[3], 'None',
"IssueMoveFormation", LandWaypoints6Destroyer, nil,
"IssueNameChange", 'url0402', nil},

{414, "Survival_LandSpawn3", 1755 + 145 + 40 + WaveDelay[3], 'None',
"IssueMoveFormation", LandWaypoints3, nil,
"IssueNameChange", 'url0402', nil},

{415, "Survival_LandSpawn4", 1755 + 145 + 10 + WaveDelay[4], 'None',
"IssueMoveFormation", LandWaypoints4, nil,
"IssueNameChange", 'url0402', nil},

{416, "Survival_LandSpawn4", 1755 + 145 + 10 + WaveDelay[4], 'None',
"IssueMoveFormation", LandWaypoints4, nil,
"IssueNameChange", 'url0402', nil},



{417, "Survival_Spawn1", 1825 + 145 + WaveDelay[1], 'None',
"IssueMoveFormation", LandWaypoints5Destroyer, nil,
"IssueNameChange", 'url0402', nil},

{418, "Survival_LandSpawn1", 1825 + 145 + WaveDelay[1], 'None',
"IssueMoveFormation", LandWaypoints1, nil,
"IssueNameChange", 'url0402', nil},

{419, "Survival_LandSpawn2", 1825 + 145 + 35 + WaveDelay[2], 'None',
"IssueMoveFormation", LandWaypoints2, nil,
"IssueNameChange", 'url0402', nil},

{420, "Survival_LandSpawn2", 1825 + 145 + 35 + WaveDelay[2], 'None',
"IssueMoveFormation", LandWaypoints2, nil,
"IssueNameChange", 'url0402', nil},

{421, "Survival_Spawn4", 1825 + 145 + 55 + WaveDelay[3], 'None',
"IssueMoveFormation", LandWaypoints6Destroyer, nil,
"IssueNameChange", 'url0402', nil},

{422, "Survival_LandSpawn3", 1825 + 145 + 40 + WaveDelay[3], 'None',
"IssueMoveFormation", LandWaypoints3, nil,
"IssueNameChange", 'url0402', nil},

{423, "Survival_LandSpawn4", 1825 + 145 + 10 + WaveDelay[4], 'None',
"IssueMoveFormation", LandWaypoints4, nil,
"IssueNameChange", 'url0402', nil},

{424, "Survival_LandSpawn4", 1825 + 145 + 10 + WaveDelay[4], 'None',
"IssueMoveFormation", LandWaypoints4, nil,
"IssueNameChange", 'url0402', nil},



{425, "Survival_Spawn1", 1885 + 145 + WaveDelay[1], 'None',
"IssueMoveFormation", LandWaypoints5Destroyer, nil,
"IssueNameChange", 'url0402', nil},

{426, "Survival_LandSpawn1", 1885 + 145 + WaveDelay[1], 'None',
"IssueMoveFormation", LandWaypoints1, nil,
"IssueNameChange", 'url0402', nil},

{427, "Survival_LandSpawn2", 1885 + 145 + 35 + WaveDelay[2], 'None',
"IssueMoveFormation", LandWaypoints2, nil,
"IssueNameChange", 'url0402', nil},

{428, "Survival_LandSpawn2", 1885 + 145 + 35 + WaveDelay[2], 'None',
"IssueMoveFormation", LandWaypoints2, nil,
"IssueNameChange", 'url0402', nil},

{429, "Survival_Spawn4", 1885 + 145 + 55 + WaveDelay[3], 'None',
"IssueMoveFormation", LandWaypoints6Destroyer, nil,
"IssueNameChange", 'url0402', nil},

{430, "Survival_LandSpawn3", 1885 + 145 + 40 + WaveDelay[3], 'None',
"IssueMoveFormation", LandWaypoints3, nil,
"IssueNameChange", 'url0402', nil},

{431, "Survival_LandSpawn4", 1885 + 145 + 10 + WaveDelay[4], 'None',
"IssueMoveFormation", LandWaypoints4, nil,
"IssueNameChange", 'url0402', nil},

{432, "Survival_LandSpawn4", 1885 + 145 + 10 + WaveDelay[4], 'None',
"IssueMoveFormation", LandWaypoints4, nil,
"IssueNameChange", 'url0402', nil},



{433, "Survival_Spawn1", 1945 + 145 + WaveDelay[1], 'None',
"IssueMoveFormation", LandWaypoints5Destroyer, nil,
"IssueNameChange", 'url0402', nil},

{434, "Survival_LandSpawn1", 1945 + 145 + WaveDelay[1], 'None',
"IssueMoveFormation", LandWaypoints1, nil,
"IssueNameChange", 'url0402', nil},

{435, "Survival_LandSpawn2", 1945 + 145 + 35 + WaveDelay[2], 'None',
"IssueMoveFormation", LandWaypoints2, nil,
"IssueNameChange", 'url0402', nil},

{436, "Survival_LandSpawn2", 1945 + 145 + 35 + WaveDelay[2], 'None',
"IssueMoveFormation", LandWaypoints2, nil,
"IssueNameChange", 'url0402', nil},

{437, "Survival_Spawn4", 1945 + 145 + 55 + WaveDelay[3], 'None',
"IssueMoveFormation", LandWaypoints6Destroyer, nil,
"IssueNameChange", 'url0402', nil},

{438, "Survival_LandSpawn3", 1945 + 145 + 40 + WaveDelay[3], 'None',
"IssueMoveFormation", LandWaypoints3, nil,
"IssueNameChange", 'url0402', nil},

{439, "Survival_LandSpawn4", 1945 + 145 + 10 + WaveDelay[4], 'None',
"IssueMoveFormation", LandWaypoints4, nil,
"IssueNameChange", 'url0402', nil},

{440, "Survival_LandSpawn4", 1945 + 145 + 10 + WaveDelay[4], 'None',
"IssueMoveFormation", LandWaypoints4, nil,
"IssueNameChange", 'url0402', nil},



{441, "Survival_Spawn1", 2005 + 145 + WaveDelay[1], 'None',
"IssueMoveFormation", LandWaypoints5Destroyer, nil,
"IssueNameChange", 'url0402', nil},

{442, "Survival_LandSpawn1", 2005 + 145 + WaveDelay[1], 'None',
"IssueMoveFormation", LandWaypoints1, nil,
"IssueNameChange", 'url0402', nil},

{443, "Survival_LandSpawn2", 2005 + 145 + 35 + WaveDelay[2], 'None',
"IssueMoveFormation", LandWaypoints2, nil,
"IssueNameChange", 'url0402', nil},

{444, "Survival_LandSpawn2", 2005 + 145 + 35 + WaveDelay[2], 'None',
"IssueMoveFormation", LandWaypoints2, nil,
"IssueNameChange", 'url0402', nil},

{445, "Survival_Spawn4", 2005 + 145 + 55 + WaveDelay[3], 'None',
"IssueMoveFormation", LandWaypoints6Destroyer, nil,
"IssueNameChange", 'url0402', nil},

{446, "Survival_LandSpawn3", 2005 + 145 + 40 + WaveDelay[3], 'None',
"IssueMoveFormation", LandWaypoints3, nil,
"IssueNameChange", 'url0402', nil},

{447, "Survival_LandSpawn4", 2005 + 145 + 10 + WaveDelay[4], 'None',
"IssueMoveFormation", LandWaypoints4, nil,
"IssueNameChange", 'url0402', nil},

{448, "Survival_LandSpawn4", 2005 + 145 + 10 + WaveDelay[4], 'None',
"IssueMoveFormation", LandWaypoints4, nil,
"IssueNameChange", 'url0402', nil},



{449, "Survival_Spawn1", 2065 + 145 + WaveDelay[1], 'None',
"IssueMoveFormation", LandWaypoints5Destroyer, nil,
"IssueNameChange", 'url0402', nil},

{450, "Survival_LandSpawn1", 2065 + 145 + WaveDelay[1], 'None',
"IssueMoveFormation", LandWaypoints1, nil,
"IssueNameChange", 'url0402', nil},

{451, "Survival_LandSpawn2", 2065 + 145 + 35 + WaveDelay[2], 'None',
"IssueMoveFormation", LandWaypoints2, nil,
"IssueNameChange", 'url0402', nil},

{452, "Survival_LandSpawn2", 2065 + 145 + 35 + WaveDelay[2], 'None',
"IssueMoveFormation", LandWaypoints2, nil,
"IssueNameChange", 'url0402', nil},

{453, "Survival_Spawn4", 2065 + 145 + 55 + WaveDelay[3], 'None',
"IssueMoveFormation", LandWaypoints6Destroyer, nil,
"IssueNameChange", 'url0402', nil},

{454, "Survival_LandSpawn3", 2065 + 145 + 40 + WaveDelay[3], 'None',
"IssueMoveFormation", LandWaypoints3, nil,
"IssueNameChange", 'url0402', nil},

{455, "Survival_LandSpawn4", 2065 + 145 + 10 + WaveDelay[4], 'None',
"IssueMoveFormation", LandWaypoints4, nil,
"IssueNameChange", 'url0402', nil},

{456, "Survival_LandSpawn4", 2065 + 145 + 10 + WaveDelay[4], 'None',
"IssueMoveFormation", LandWaypoints4, nil,
"IssueNameChange", 'url0402', nil},




{457, "Survival_Spawn1", 2125 + 145 + WaveDelay[1], 'None',
"IssueMoveFormation", LandWaypoints5Destroyer, nil,
"IssueNameChange", 'url0402', nil},

{458, "Survival_LandSpawn1", 2125 + 145 + WaveDelay[1], 'None',
"IssueMoveFormation", LandWaypoints1, nil,
"IssueNameChange", 'url0402', nil},

{459, "Survival_LandSpawn2", 2125 + 145 + 35 + WaveDelay[2], 'None',
"IssueMoveFormation", LandWaypoints2, nil,
"IssueNameChange", 'url0402', nil},

{460, "Survival_LandSpawn2", 2125 + 145 + 35 + WaveDelay[2], 'None',
"IssueMoveFormation", LandWaypoints2, nil,
"IssueNameChange", 'url0402', nil},

{461, "Survival_Spawn4", 2125 + 145 + 55 + WaveDelay[3], 'None',
"IssueMoveFormation", LandWaypoints6Destroyer, nil,
"IssueNameChange", 'url0402', nil},

{462, "Survival_LandSpawn3", 2125 + 145 + 40 + WaveDelay[3], 'None',
"IssueMoveFormation", LandWaypoints3, nil,
"IssueNameChange", 'url0402', nil},

{463, "Survival_LandSpawn4", 2125 + 145 + 10 + WaveDelay[4], 'None',
"IssueMoveFormation", LandWaypoints4, nil,
"IssueNameChange", 'url0402', nil},

{464, "Survival_LandSpawn4", 2125 + 145 + 10 + WaveDelay[4], 'None',
"IssueMoveFormation", LandWaypoints4, nil,
"IssueNameChange", 'url0402', nil},



{465, "Survival_Spawn1", 2185 + 145 + WaveDelay[1], 'None',
"IssueMoveFormation", LandWaypoints5Destroyer, nil,
"IssueNameChange", 'url0402', nil},

{466, "Survival_LandSpawn1", 2185 + 145 + WaveDelay[1], 'None',
"IssueMoveFormation", LandWaypoints1, nil,
"IssueNameChange", 'url0402', nil},

{467, "Survival_LandSpawn2", 2185 + 145 + 35 + WaveDelay[2], 'None',
"IssueMoveFormation", LandWaypoints2, nil,
"IssueNameChange", 'url0402', nil},

{468, "Survival_LandSpawn2", 2185 + 145 + 35 + WaveDelay[2], 'None',
"IssueMoveFormation", LandWaypoints2, nil,
"IssueNameChange", 'url0402', nil},

{469, "Survival_Spawn4", 2185 + 145 + 55 + WaveDelay[3], 'None',
"IssueMoveFormation", LandWaypoints6Destroyer, nil,
"IssueNameChange", 'url0402', nil},

{470, "Survival_LandSpawn3", 2185 + 145 + 40 + WaveDelay[3], 'None',
"IssueMoveFormation", LandWaypoints3, nil,
"IssueNameChange", 'url0402', nil},

{471, "Survival_LandSpawn4", 2185 + 145 + 10 + WaveDelay[4], 'None',
"IssueMoveFormation", LandWaypoints4, nil,
"IssueNameChange", 'url0402', nil},

{472, "Survival_LandSpawn4", 2185 + 145 + 10 + WaveDelay[4], 'None',
"IssueMoveFormation", LandWaypoints4, nil,
"IssueNameChange", 'url0402', nil},



{473, "Survival_Spawn1", 2245 + 145 + WaveDelay[1], 'None',
"IssueMoveFormation", LandWaypoints5Destroyer, nil,
"IssueNameChange", 'url0402', nil},

{474, "Survival_LandSpawn1", 2245 + 145 + WaveDelay[1], 'None',
"IssueMoveFormation", LandWaypoints1, nil,
"IssueNameChange", 'url0402', nil},

{475, "Survival_LandSpawn2", 2245 + 145 + 35 + WaveDelay[2], 'None',
"IssueMoveFormation", LandWaypoints2, nil,
"IssueNameChange", 'url0402', nil},

{476, "Survival_LandSpawn2", 2245 + 145 + 35 + WaveDelay[2], 'None',
"IssueMoveFormation", LandWaypoints2, nil,
"IssueNameChange", 'url0402', nil},

{477, "Survival_Spawn4", 2245 + 145 + 55 + WaveDelay[3], 'None',
"IssueMoveFormation", LandWaypoints6Destroyer, nil,
"IssueNameChange", 'url0402', nil},

{478, "Survival_LandSpawn3", 2245 + 145 + 40 + WaveDelay[3], 'None',
"IssueMoveFormation", LandWaypoints3, nil,
"IssueNameChange", 'url0402', nil},

{479, "Survival_LandSpawn4", 2245 + 145 + 10 + WaveDelay[4], 'None',
"IssueMoveFormation", LandWaypoints4, nil,
"IssueNameChange", 'url0402', nil},

{480, "Survival_LandSpawn4", 2245 + 145 + 10 + WaveDelay[4], 'None',
"IssueMoveFormation", LandWaypoints4, nil,
"IssueNameChange", 'url0402', nil},




{481, "Survival_Spawn1", 2035 + 80 + WaveDelay[1], 'None',
"IssueAttackFormation", LandWaypoints5Destroyer, nil,
"IssueNameChange", 'xrl0403', nil},

{482, "Survival_LandSpawn1", 2035 + 80 + WaveDelay[1], 'None',
"IssueAttackFormation", LandWaypoints1, nil,
"IssueNameChange", 'xrl0403', nil},

{483, "Survival_LandSpawn2", 2035 + 80 + 35 + WaveDelay[2], 'None',
"IssueAttackFormation", LandWaypoints2, nil,
"IssueNameChange", 'xrl0403', nil},

{484, "Survival_LandSpawn2", 2035 + 80 + 35 + WaveDelay[2], 'None',
"IssueAttackFormation", LandWaypoints2, nil,
"IssueNameChange", 'xrl0403', nil},

{485, "Survival_Spawn4", 2035 + 80 + 55 + WaveDelay[3], 'None',
"IssueAttackFormation", LandWaypoints6Destroyer, nil,
"IssueNameChange", 'xrl0403', nil},

{486, "Survival_LandSpawn3", 2035 + 80 + 40 + WaveDelay[3], 'None',
"IssueAttackFormation", LandWaypoints3, nil,
"IssueNameChange", 'xrl0403', nil},

{487, "Survival_LandSpawn4", 2035 + 80 + 10 + WaveDelay[4], 'None',
"IssueAttackFormation", LandWaypoints4, nil,
"IssueNameChange", 'xrl0403', nil},

{488, "Survival_LandSpawn4", 2035 + 80 + 10 + WaveDelay[4], 'None',
"IssueAttackFormation", LandWaypoints4, nil,
"IssueNameChange", 'xrl0403', nil},



{489, "Survival_Spawn1", 2095 + 80 + WaveDelay[1], 'None',
"IssueAttackFormation", LandWaypoints5Destroyer, nil,
"IssueNameChange", 'xrl0403', nil},

{490, "Survival_LandSpawn1", 2095 + 80 + WaveDelay[1], 'None',
"IssueAttackFormation", LandWaypoints1, nil,
"IssueNameChange", 'xrl0403', nil},

{491, "Survival_LandSpawn2", 2095 + 80 + 35 + WaveDelay[2], 'None',
"IssueAttackFormation", LandWaypoints2, nil,
"IssueNameChange", 'xrl0403', nil},

{492, "Survival_LandSpawn2", 2095 + 80 + 35 + WaveDelay[2], 'None',
"IssueAttackFormation", LandWaypoints2, nil,
"IssueNameChange", 'xrl0403', nil},

{493, "Survival_Spawn4", 2095 + 80 + 55 + WaveDelay[3], 'None',
"IssueAttackFormation", LandWaypoints6Destroyer, nil,
"IssueNameChange", 'xrl0403', nil},

{494, "Survival_LandSpawn3", 2095 + 80 + 40 + WaveDelay[3], 'None',
"IssueAttackFormation", LandWaypoints3, nil,
"IssueNameChange", 'xrl0403', nil},

{495, "Survival_LandSpawn4", 2095 + 80 + 10 + WaveDelay[4], 'None',
"IssueAttackFormation", LandWaypoints4, nil,
"IssueNameChange", 'xrl0403', nil},

{496, "Survival_LandSpawn4", 2095 + 80 + 10 + WaveDelay[4], 'None',
"IssueAttackFormation", LandWaypoints4, nil,
"IssueNameChange", 'xrl0403', nil},


{497, "Survival_Spawn1", 2155 + 80 + WaveDelay[1], 'None',
"IssueAttackFormation", LandWaypoints5Destroyer, nil,
"IssueNameChange", 'xrl0403', nil},

{498, "Survival_LandSpawn1", 2155 + 80 + WaveDelay[1], 'None',
"IssueAttackFormation", LandWaypoints1, nil,
"IssueNameChange", 'xrl0403', nil},

{499, "Survival_LandSpawn2", 2155 + 80 + 35 + WaveDelay[2], 'None',
"IssueAttackFormation", LandWaypoints2, nil,
"IssueNameChange", 'xrl0403', nil},

{500, "Survival_LandSpawn2", 2155 + 80 + 35 + WaveDelay[2], 'None',
"IssueAttackFormation", LandWaypoints2, nil,
"IssueNameChange", 'xrl0403', nil},

{501, "Survival_Spawn4", 2155 + 80 + 55 + WaveDelay[3], 'None',
"IssueAttackFormation", LandWaypoints6Destroyer, nil,
"IssueNameChange", 'xrl0403', nil},

{502, "Survival_LandSpawn3", 2155 + 80 + 40 + WaveDelay[3], 'None',
"IssueAttackFormation", LandWaypoints3, nil,
"IssueNameChange", 'xrl0403', nil},

{503, "Survival_LandSpawn4", 2155 + 80 + 10 + WaveDelay[4], 'None',
"IssueAttackFormation", LandWaypoints4, nil,
"IssueNameChange", 'xrl0403', nil},

{504, "Survival_LandSpawn4", 2155 + 80 + 10 + WaveDelay[4], 'None',
"IssueAttackFormation", LandWaypoints4, nil,
"IssueNameChange", 'xrl0403', nil},


{505, "Survival_Spawn1", 2215 + 80 + WaveDelay[1], 'None',
"IssueAttackFormation", LandWaypoints5Destroyer, nil,
"IssueNameChange", 'xrl0403', nil},

{506, "Survival_LandSpawn1", 2215 + 80 + WaveDelay[1], 'None',
"IssueAttackFormation", LandWaypoints1, nil,
"IssueNameChange", 'xrl0403', nil},

{507, "Survival_LandSpawn2", 2215 + 80 + 35 + WaveDelay[2], 'None',
"IssueAttackFormation", LandWaypoints2, nil,
"IssueNameChange", 'xrl0403', nil},

{508, "Survival_LandSpawn2", 2215 + 80 + 35 + WaveDelay[2], 'None',
"IssueAttackFormation", LandWaypoints2, nil,
"IssueNameChange", 'xrl0403', nil},

{509, "Survival_Spawn4", 2215 + 80 + 55 + WaveDelay[3], 'None',
"IssueAttackFormation", LandWaypoints6Destroyer, nil,
"IssueNameChange", 'xrl0403', nil},

{510, "Survival_LandSpawn3", 2215 + 80 + 40 + WaveDelay[3], 'None',
"IssueAttackFormation", LandWaypoints3, nil,
"IssueNameChange", 'xrl0403', nil},

{511, "Survival_LandSpawn4", 2215 + 80 + 10 + WaveDelay[4], 'None',
"IssueAttackFormation", LandWaypoints4, nil,
"IssueNameChange", 'xrl0403', nil},

{512, "Survival_LandSpawn4", 2215 + 80 + 10 + WaveDelay[4], 'None',
"IssueAttackFormation", LandWaypoints4, nil,
"IssueNameChange", 'xrl0403', nil},


{513, "Survival_Spawn1", 2275 + 80 + WaveDelay[1], 'None',
"IssueAttackFormation", LandWaypoints5Destroyer, nil,
"IssueNameChange", 'xrl0403', nil},

{514, "Survival_LandSpawn1", 2275 + 80 + WaveDelay[1], 'None',
"IssueAttackFormation", LandWaypoints1, nil,
"IssueNameChange", 'xrl0403', nil},

{515, "Survival_LandSpawn2", 2275 + 80 + 35 + WaveDelay[2], 'None',
"IssueAttackFormation", LandWaypoints2, nil,
"IssueNameChange", 'xrl0403', nil},

{516, "Survival_LandSpawn2", 2275 + 80 + 35 + WaveDelay[2], 'None',
"IssueAttackFormation", LandWaypoints2, nil,
"IssueNameChange", 'xrl0403', nil},

{517, "Survival_Spawn4", 2275 + 80 + 55 + WaveDelay[3], 'None',
"IssueAttackFormation", LandWaypoints6Destroyer, nil,
"IssueNameChange", 'xrl0403', nil},

{518, "Survival_LandSpawn3", 2275 + 80 + 40 + WaveDelay[3], 'None',
"IssueAttackFormation", LandWaypoints3, nil,
"IssueNameChange", 'xrl0403', nil},

{519, "Survival_LandSpawn4", 2275 + 80 + 10 + WaveDelay[4], 'None',
"IssueAttackFormation", LandWaypoints4, nil,
"IssueNameChange", 'xrl0403', nil},

{520, "Survival_LandSpawn4", 2275 + 80 + 10 + WaveDelay[4], 'None',
"IssueAttackFormation", LandWaypoints4, nil,
"IssueNameChange", 'xrl0403', nil},


{521, "Survival_Spawn1", 2335 + 80 + WaveDelay[1], 'None',
"IssueAttackFormation", LandWaypoints5Destroyer, nil,
"IssueNameChange", 'xrl0403', nil},

{522, "Survival_LandSpawn1", 2335 + 80 + WaveDelay[1], 'None',
"IssueAttackFormation", LandWaypoints1, nil,
"IssueNameChange", 'xrl0403', nil},

{523, "Survival_LandSpawn2", 2335 + 80 + 35 + WaveDelay[2], 'None',
"IssueAttackFormation", LandWaypoints2, nil,
"IssueNameChange", 'xrl0403', nil},

{524, "Survival_LandSpawn2", 2335 + 80 + 35 + WaveDelay[2], 'None',
"IssueAttackFormation", LandWaypoints2, nil,
"IssueNameChange", 'xrl0403', nil},

{525, "Survival_Spawn4", 2335 + 80 + 55 + WaveDelay[3], 'None',
"IssueAttackFormation", LandWaypoints6Destroyer, nil,
"IssueNameChange", 'xrl0403', nil},

{526, "Survival_LandSpawn3", 2335 + 80 + 40 + WaveDelay[3], 'None',
"IssueAttackFormation", LandWaypoints3, nil,
"IssueNameChange", 'xrl0403', nil},

{527, "Survival_LandSpawn4", 2335 + 80 + 10 + WaveDelay[4], 'None',
"IssueAttackFormation", LandWaypoints4, nil,
"IssueNameChange", 'xrl0403', nil},

{528, "Survival_LandSpawn4", 2335 + 80 + 10 + WaveDelay[4], 'None',
"IssueAttackFormation", LandWaypoints4, nil,
"IssueNameChange", 'xrl0403', nil},


}
end





function ScenarioUtils.CommanderWarpDelay(cdrUnit, delay)               --Silly way to disable Warp in effect.

	local army = cdrUnit:GetArmy()
	local aiBrain = GetArmyBrain(army)

	if (aiBrain:GetFactionIndex() == 1) then

		cdrUnit:ShowBone(0, true)
		cdrUnit:HideBone('Right_Upgrade', true)
		cdrUnit:HideBone('Left_Upgrade', true)
		cdrUnit:HideBone('Back_Upgrade_B01', true)
		cdrUnit:SetOrientation({0, 1, 0, 0}, true)

	elseif (aiBrain:GetFactionIndex() == 2) then

		cdrUnit:ShowBone(0, true)
		cdrUnit:HideBone('Back_Upgrade', true)
		cdrUnit:HideBone('Right_Upgrade', true)
		cdrUnit:HideBone('Left_Upgrade', true)
		cdrUnit:SetOrientation({0, 1, 0, 0}, true)

	elseif (aiBrain:GetFactionIndex() == 3) then

		cdrUnit:ShowBone(0, true)
		cdrUnit:HideBone('Back_Upgrade', true)
		cdrUnit:HideBone('Right_Upgrade', true)
		cdrUnit:HideBone('Back_Upgrade', true)
		cdrUnit:SetOrientation({0, 1, 0, 0}, true)

	elseif (aiBrain:GetFactionIndex() == 4) then

		cdrUnit:ShowBone(0, true)
		cdrUnit:HideBone('Back_Upgrade', true)
		cdrUnit:HideBone('Right_Upgrade', true)
		cdrUnit:HideBone('Left_Upgrade', true)
		cdrUnit:SetOrientation({0, 1, 0, 0}, true)
	else
		WaitSeconds(delay)
		cdrUnit:PlayCommanderWarpInEffect()
	end
end





function ScenarioUtils.CreateResources()

   	local markers = ScenarioUtils.GetMarkers()
	local ChangeResourcePosition = false

	for i, army in ListArmies() do

	LOG(army)

		if (army == "ARMY_5") then
			ChangeResourcePosition = true
		end

	end

			if (ChangeResourcePosition) then

   			-- create the resource
   			CreateResourceDeposit("Hydrocarbon",	251.5, 22.49, 340.5, 3.00)
   			-- create the resource graphic on the map
   			CreatePropHPR("/env/common/props/hydrocarbonDeposit01_prop.bp", 251.5, 22.49, 340.5, Random(0,6.2832), 0, 0)
   			-- create the resource icon on the map
   			CreateSplat(
   				{251.5, 22.49, 340.5},           # Position
   				0,                          # Heading (rotation)
   				"/env/common/splats/hydrocarbon_marker.dds",                     # Texture name for albedo
   				6, 6,                     # SizeX/Z
   				200,                        # LOD
   				0,                          # Duration (0 == does not expire)
   				-1,                         # army (-1 == not owned by any single army)
   				0							# ???
   			)



   			-- create the resource
   			CreateResourceDeposit("Mass",	247.5 + 1.00, 22.48, 364.5 + 1.00, 1.00)
   			CreatePropHPR("/env/common/props/massDeposit01_prop.bp", 247.5, 22.48, 364.5, Random(0,360), 0, 0)
   			CreateResourceDeposit("Mass",	247.5 + 1.00, 22.48, 364.5 - 1.00, 1.00)
   			CreateResourceDeposit("Mass",	247.5 - 1.00, 22.48, 364.5 + 1.00, 1.00)
   			CreateResourceDeposit("Mass",	247.5 - 1.00, 22.48, 364.5 - 1.00, 1.00)
   			CreateSplat(
   				{247.5, 22.48, 364.5},           # Position
   				0,                          # Heading (rotation)
   				"/env/common/splats/mass_marker.dds",                     # Texture name for albedo
   				4, 4,                     # SizeX/Z
   				100,                        # LOD
   				0,                          # Duration (0 == does not expire)
   				-1,                         # army (-1 == not owned by any single army)
   				0							# ???
   			)










		end

   	for i, tblData in pairs(markers) do

		local spawnresource = false
		local posx = 0
		local posz = 0
		local NewResourcePosition = {}
		local NewResourceSize = 0.00



		if (tblData.resource) then

			for i, army in ListArmies() do

				if (army == "ARMY_1" and tblData.army1resource) then
				spawnresource = true
				elseif (army == "ARMY_2" and tblData.army2resource) then
				spawnresource = true
				elseif (army == "ARMY_3" and tblData.army3resource) then
				spawnresource = true
				elseif (army == "ARMY_4" and tblData.army4resource) then
				spawnresource = true
				elseif (army == "ARMY_5" and tblData.army5resource) then
				spawnresource = true
				end

			end
		end




		if (tblData.resource and tblData.Hydrocarbon4 == true and ChangeResourcePosition) then
			NewResourcePosition = {tblData.position[1] + 3.00, tblData.position[2], tblData.position[3] -3.00}
		elseif (tblData.resource and tblData.Hydrocarbon3 == true and ChangeResourcePosition) then
			NewResourcePosition = {tblData.position[1] - 3.00, tblData.position[2], tblData.position[3] + 3.00}
		elseif (tblData.resource and tblData.Hydrocarbon2 == true and ChangeResourcePosition) then
			NewResourcePosition = {tblData.position[1] + 3.00, tblData.position[2], tblData.position[3] + 3.00}
		elseif (tblData.resource and tblData.Hydrocarbon1 == true and ChangeResourcePosition) then
			NewResourcePosition = {tblData.position[1] - 3.00, tblData.position[2], tblData.position[3] - 3.00}
		elseif (tblData.resource and tblData.Mass23 == true and ChangeResourcePosition) then
  			posx = -14.00
			posz = -2.00
			NewResourcePosition = {tblData.position[1] +posx, tblData.position[2], tblData.position[3] +posz}
		elseif (tblData.resource and tblData.Mass22 == true and ChangeResourcePosition) then
  			posx = 5.50
			posz = 0.00
			NewResourcePosition = {tblData.position[1] + posx, tblData.position[2], tblData.position[3] +posz}
		else
			NewResourcePosition = tblData.position
		end

   		if (spawnresource and not tblData.BigMass) then

   			-- check type of resource and set parameters
   			local bp, albedo, sx, sz, lod


   			if (tblData.type == "Mass") then
   				albedo = "/env/common/splats/mass_marker.dds"
   				bp = "/env/common/props/massDeposit01_prop.bp"
   				sx = 2
   				sz = 2
   				lod = 100
   			else
   				albedo = "/env/common/splats/hydrocarbon_marker.dds"
   				bp = "/env/common/props/hydrocarbonDeposit01_prop.bp"
   				sx = 6
   				sz = 6
   				lod = 200
   			end

   			-- create the resource
   			CreateResourceDeposit(tblData.type,	NewResourcePosition[1], NewResourcePosition[2], NewResourcePosition[3], tblData.size)
   			-- create the resource graphic on the map
   			CreatePropHPR(bp, NewResourcePosition[1], NewResourcePosition[2], NewResourcePosition[3], Random(0,6.2832), 0, 0)
   			-- create the resource icon on the map
   			CreateSplat(
   				NewResourcePosition,           # Position
   				0,                          # Heading (rotation)
   				albedo,                     # Texture name for albedo
   				sx, sz,                     # SizeX/Z
   				lod,                        # LOD
   				0,                          # Duration (0 == does not expire)
   				-1,                         # army (-1 == not owned by any single army)
   				0							# ???
   			)

   		elseif (spawnresource and tblData.BigMass) then
			local bp, albedo, sx, sz, lod
			local variation = 0

			if (tblData.type == "Mass") then
   				albedo = "/env/common/splats/mass_marker.dds"
   				bp = "/env/common/props/massDeposit01_prop.bp"
   				sx = 4
   				sz = 4
   				lod = 100
				variation = 1.00
   			else
   				albedo = "/env/common/splats/hydrocarbon_marker.dds"
   				bp = "/env/common/props/hydrocarbonDeposit01_prop.bp"
   				sx = 12
   				sz = 12
   				lod = 200
				variation = 3.00
			end
   			CreateResourceDeposit(tblData.type,	tblData.position[1] + variation + posx, tblData.position[2], tblData.position[3] + variation +posz, tblData.size)
   			CreatePropHPR(bp, tblData.position[1] + posx, tblData.position[2], tblData.position[3] + posz, Random(0,360), 0, 0)
   			CreateResourceDeposit(tblData.type,	tblData.position[1] + posx + variation, tblData.position[2], tblData.position[3] + posz - variation, tblData.size)
   			CreateResourceDeposit(tblData.type,	tblData.position[1] + posx - variation, tblData.position[2], tblData.position[3] +posz + variation, tblData.size)
   			CreateResourceDeposit(tblData.type,	tblData.position[1] +posx - variation, tblData.position[2], tblData.position[3] +posz - variation, tblData.size)
   			CreateSplat(
   				NewResourcePosition,           # Position
   				0,                          # Heading (rotation)
   				albedo,                     # Texture name for albedo
   				sx, sz,                     # SizeX/Z
   				lod,                        # LOD
   				0,                          # Duration (0 == does not expire)
   				-1,                         # army (-1 == not owned by any single army)
   				0							# ???
   			)
		end
   	end
   end










function OnPopulate()

   	ScenarioUtils.InitializeArmies()
	Survival_InitGame()

end




function OnStart(self)

	ForkThread(Survival_Tick)

end









Survival_InitGame = function()




local EnemyCommander = CreateUnitHPR('URL0001', "ARMY_SURVIVAL_ENEMY", 10, 13.5, -10, 0, 0, 0)
EnemyCommander:SetDoNotTarget(true)
EnemyCommander:SetCanBeKilled(false)
EnemyCommander:SetProductionPerSecondEnergy(90000)
EnemyCommander:SetConsumptionPerSecondEnergy(0)
EnemyCommander:SetProductionPerSecondMass(9999)




ScenarioFramework.SetPlayableArea('AREA_1', false)
ScenarioInfo.MissionNumber = 1
DeathDialogue = ShuffleList(DeathDialogue)



if (ScenarioInfo.Options.opt_defeat_conditions == nil) then
	ScenarioInfo.Options.opt_defeat_conditions = 1
end

	SetArmyColor('ARMY_SURVIVAL_ENEMY', 225, 70, 0)
	ScenarioInfo.Options.Victory = 'sandbox'
	SetIgnoreArmyUnitCap('ARMY_SURVIVAL_ENEMY', true)


------------------------------------------------------------------------------------------When there's less than 4 players, spawn additional commanders on empty slots-------------------------------------------------------------------------------
local CommanderID = ''
local UnoccupiedArmies = {}
local AllArmies = {"ARMY_1", "ARMY_2", "ARMY_3", "ARMY_4", "ARMY_5"}



	for i, army in AllArmies do

		local IsListed = 0

		for k, occarmy in ListArmies() do

			if (occarmy == army) then

				table.insert(OccupiedArmies, army)

				IsListed = 1

				if (occarmy == "ARMY_1") then

					EnableLane1 = 1
					table.insert(BaseRaidingTargets, "PlayerSpawn_1")
					table.insert(ValidTransportDrops, "TransportDrop04")
					table.insert(ValidTransportDrops, "TransportDrop01")
					LOG("Lane 1 Enabled")

				elseif (occarmy == "ARMY_3") then

					EnableLane2 = 1
					table.insert(BaseRaidingTargets, "PlayerSpawn_2")
					table.insert(ValidTransportDrops, "TransportDrop04")
					table.insert(ValidTransportDrops, "TransportDrop01")
					table.insert(ValidTransportDrops, "TransportDrop02")
					LOG("Lane 2 Enabled " .. EnableLane2)

				elseif (occarmy == "ARMY_4") then

					EnableLane3 = 1
					table.insert(BaseRaidingTargets, "PlayerSpawn_3")
					table.insert(ValidTransportDrops, "TransportDrop06")
					table.insert(ValidTransportDrops, "TransportDrop03")
					table.insert(ValidTransportDrops, "TransportDrop02")
					LOG("Lane 3 Enabled")

				elseif (occarmy == "ARMY_2") then

					EnableLane4 = 1
					table.insert(BaseRaidingTargets, "PlayerSpawn_4")
					table.insert(ValidTransportDrops, "TransportDrop06")
					table.insert(ValidTransportDrops, "TransportDrop03")
					LOG("Lane 4 Enabled")

				elseif (occarmy == "ARMY_5" and table.getn(ListArmies()) > 2) then

					EnableLane5 = 1
					table.insert(BaseRaidingTargets, "PatrolBase_5")

					table.insert(ValidTransportDrops, "TransportDrop05")
					LOG("Lane 5 Enabled")

					if ((EnableLane1 == 1 and EnableLane2 == 1) or (EnableLane3 == 1 and EnableLane4 == 1)) then
					table.insert(ValidTransportDrops, "TransportDrop05")
					--LOG("Second TransportDrop Activated.")
					--table.insert(ValidTransportDrops, "TransportDrop05")
					end

				elseif (occarmy == "ARMY_5" and table.getn(ListArmies()) <= 2) then
					EnableLane5 = 1
					--LOG("Lane 5 Enabled. Only ARMY_5 present")
					table.insert(BaseRaidingTargets, "PatrolBase_5")
					table.insert(ValidTransportDrops, "TransportDrop01")
					table.insert(ValidTransportDrops, "TransportDrop02")
					table.insert(ValidTransportDrops, "TransportDrop03")
					table.insert(ValidTransportDrops, "TransportDrop04")
					table.insert(ValidTransportDrops, "TransportDrop05")
				end

			end
		end

		if (IsListed == 0) then

			table.insert(UnoccupiedArmies, army)

		end
	end

	local brain = GetArmyBrain(OccupiedArmies[1]) --Fixes the coop script someone changed.
	SimObjects.playerArmy = brain:GetArmyIndex()


	if (EnableLane1 == 1 or EnableLane2 == 1) then
		table.insert(BaseRaidingTargets, "PatrolBase_7")
	end

	if (EnableLane3 == 1 or EnableLane4 == 1) then
		table.insert(BaseRaidingTargets, "PatrolBase_7")
	end

	table.insert(BaseRaidingTargets, "PatrolBase_6")


	-----------------------------Spawn Destroyer Boss to random, occupied lane
	if (EnableLane1 == 0) then
	table.insert(IgnoredLanesList, 161)
	table.insert(IgnoredLanesList, 162)
	table.insert(IgnoredLanesList, 172)
	end
	if (EnableLane2 == 0) then
	table.insert(IgnoredLanesList, 163)
	table.insert(IgnoredLanesList, 164)
	end
	if (EnableLane3 == 0) then
	table.insert(IgnoredLanesList, 166)
	table.insert(IgnoredLanesList, 167)
	end
	if (EnableLane4 == 0) then
	table.insert(IgnoredLanesList, 173)
	table.insert(IgnoredLanesList, 174)
	table.insert(IgnoredLanesList, 168)
	end
	if (EnableLane5 == 0) then
	table.insert(IgnoredLanesList, 169)
	table.insert(IgnoredLanesList, 170)
	table.insert(IgnoredLanesList, 171)
	end

	if (EnableLane2 == 0 and EnableLane3 == 0) then
	table.insert(IgnoredLanesList, 165)
	end
	---------------------------------------------------------------------------


	if (EnableLane1 == 0 and EnableLane2 == 0 and EnableLane3 == 0 and EnableLane4 == 0 and EnableLane5 == 1) then
	EnableLane5 = 0
	EnableLane3 = 1
	end


	ValidGunshipTargetsA = table.copy(BaseRaidingTargets)
	ShuffleList(ValidGunshipTargetsA)
	ValidGunshipTargetsB = table.copy(BaseRaidingTargets)
	ShuffleList(ValidGunshipTargetsB)
	ValidGunshipTargetsC = table.copy(BaseRaidingTargets)
	ShuffleList(ValidGunshipTargetsC)
	ValidGunshipTargetsD = table.copy(BaseRaidingTargets)
	ShuffleList(ValidGunshipTargetsD)
	ValidGunshipTargetsE = table.copy(BaseRaidingTargets)
	ShuffleList(ValidGunshipTargetsE)
	ValidGunshipTargetsF = table.copy(BaseRaidingTargets)
	ShuffleList(ValidGunshipTargetsF)
	ValidGunshipTargetsG = table.copy(BaseRaidingTargets)
	ShuffleList(ValidGunshipTargetsG)

	ShuffleList(WaveDelay)
	ShuffleList(sACUnames)
	ShuffleList(SpecialNames)
	--ForkThread(ShuffleAllLists)

	--ValidGunshipTargetsA = ForkThread(ShuffleList, ValidGunshipTargetsA)
	--ValidGunshipTargetsB = ForkThread(ShuffleList, ValidGunshipTargetsB)

	CreateWaves()
	CreateWaveTableOrders()
	--ForkThread(ShuffleAllLists)

	--ForkThread(CreateWaves)
	--ForkThread(CreateWaveTableOrders)


	if (EnableLane1 == 1) then
	WaveTable[161] = {161, 'urs0201', 1 + EnableLane5}
	elseif  (EnableLane2 == 1) then
	WaveTable[163] = {163, 'urs0201', 1 + EnableLane5}
	elseif  (EnableLane3 == 1) then
	WaveTable[166] = {166, 'urs0201', 1 + EnableLane5}
	elseif  (EnableLane4 == 1) then
	WaveTable[173] = {173, 'urs0201', 1 + EnableLane5}
	elseif  (EnableLane5 == 1) then
	WaveTable[169] = {169, 'urs0201', 1 + EnableLane5}
	end

	--LOG("IgnoredLanesList")
	--for i = 1, table.getn(IgnoredLanesList) do
	--LOG(IgnoredLanesList[i])
	--end


	ShuffleListPartially(WaveTable, 383, 384)
	ShuffleListPartially(WaveTable, 385, 386)
	ShuffleListPartially(WaveTable, 387, 388)
	ShuffleListPartially(WaveTable, 389, 390)

	ShuffleListPartially(WaveTable, 276, 277)
	ShuffleListPartially(WaveTable, 278, 279)
	ShuffleListPartially(WaveTable, 280, 281)
	ShuffleListPartially(WaveTable, 282, 283)

	ShuffleListPartially(WaveTable, 401, 402)
	ShuffleListPartially(WaveTable, 403, 404)
	ShuffleListPartially(WaveTable, 405, 406)
	ShuffleListPartially(WaveTable, 407, 408)

	ShuffleListPartially(WaveTable, 409, 410)
	ShuffleListPartially(WaveTable, 411, 412)
	ShuffleListPartially(WaveTable, 413, 414)
	ShuffleListPartially(WaveTable, 415, 416)

	ShuffleListPartially(WaveTable, 417, 418)
	ShuffleListPartially(WaveTable, 419, 420)
	ShuffleListPartially(WaveTable, 421, 422)
	ShuffleListPartially(WaveTable, 423, 424)

	ShuffleListPartially(WaveTable, 425, 426)
	ShuffleListPartially(WaveTable, 427, 428)
	ShuffleListPartially(WaveTable, 429, 430)
	ShuffleListPartially(WaveTable, 431, 432)

	ShuffleListPartially(WaveTable, 433, 434)
	ShuffleListPartially(WaveTable, 435, 436)
	ShuffleListPartially(WaveTable, 437, 438)
	ShuffleListPartially(WaveTable, 439, 440)

	ShuffleListPartially(WaveTable, 441, 442)
	ShuffleListPartially(WaveTable, 443, 444)
	ShuffleListPartially(WaveTable, 445, 446)
	ShuffleListPartially(WaveTable, 447, 448)

	ShuffleListPartially(WaveTable, 449, 450)
	ShuffleListPartially(WaveTable, 451, 452)
	ShuffleListPartially(WaveTable, 453, 454)
	ShuffleListPartially(WaveTable, 455, 456)

	ShuffleListPartially(WaveTable, 457, 458)
	ShuffleListPartially(WaveTable, 459, 460)
	ShuffleListPartially(WaveTable, 461, 462)
	ShuffleListPartially(WaveTable, 463, 464)

	ShuffleListPartially(WaveTable, 465, 466)
	ShuffleListPartially(WaveTable, 467, 468)
	ShuffleListPartially(WaveTable, 469, 470)
	ShuffleListPartially(WaveTable, 471, 472)

	ShuffleListPartially(WaveTable, 473, 474)
	ShuffleListPartially(WaveTable, 475, 476)
	ShuffleListPartially(WaveTable, 477, 478)
	ShuffleListPartially(WaveTable, 479, 480)

	ShuffleListPartially(WaveTable, 481, 482)
	ShuffleListPartially(WaveTable, 483, 484)
	ShuffleListPartially(WaveTable, 485, 486)
	ShuffleListPartially(WaveTable, 487, 488)

	ShuffleListPartially(WaveTable, 489, 490)
	ShuffleListPartially(WaveTable, 491, 492)
	ShuffleListPartially(WaveTable, 493, 494)
	ShuffleListPartially(WaveTable, 495, 496)

	ShuffleListPartially(WaveTable, 497, 498)
	ShuffleListPartially(WaveTable, 499, 500)
	ShuffleListPartially(WaveTable, 501, 502)
	ShuffleListPartially(WaveTable, 503, 504)

	ShuffleListPartially(WaveTable, 505, 506)
	ShuffleListPartially(WaveTable, 507, 508)
	ShuffleListPartially(WaveTable, 509, 510)
	ShuffleListPartially(WaveTable, 511, 512)

	ShuffleListPartially(WaveTable, 513, 514)
	ShuffleListPartially(WaveTable, 515, 516)
	ShuffleListPartially(WaveTable, 517, 518)
	ShuffleListPartially(WaveTable, 519, 520)

	ShuffleListPartially(WaveTable, 521, 522)
	ShuffleListPartially(WaveTable, 523, 524)
	ShuffleListPartially(WaveTable, 525, 526)
	ShuffleListPartially(WaveTable, 527, 528)

	ShuffleListPartially(WaveTable, 161, 174, IgnoredLanesList)



CheckFocusArmy()

--local brain = GetArmyBrain(OccupiedArmies[1])
--SimObjects.playerArmy = brain:GetArmyIndex()

--LOG("Occupied armies:")
--for k, army in OccupiedArmies do
--LOG(army)
--end
--LOG("Unoccupied armies:")
--for k, army in UnoccupiedArmies do
--LOG(army)
--end


		-- com:SetCustomName( ArmyBrains[iArmy].Nickname )

UnoccupiedArmies = ShuffleList(UnoccupiedArmies)


	for i, army in ListArmies() do           -------------------------------------------------------------------------------- Set player alliances and army options


		if (army == "ARMY_1" or army == "ARMY_2" or army == "ARMY_3" or army == "ARMY_4" or army == "ARMY_5") then

			local coms = GetArmyBrain(army):GetListOfUnits(categories.COMMAND , false, false)
				for i, com in coms do
					table.insert(cdrUnitList, com)
				end



			ScenarioFramework.AddRestriction(army, categories.WALL)  -- don't allow them to build walls

			for x, armyX in ListArmies() do
				-- if human army
				if (armyX == "ARMY_1" or armyX == "ARMY_2" or armyX == "ARMY_3" or armyX == "ARMY_4" or armyX == "Army_5") then
					SetAlliance(army, armyX, 'Ally')
				end
			end

			SetAlliance(army, "ARMY_SURVIVAL_ENEMY", 'Enemy')

			SetAlliedVictory(army, true)


		end
	end

	cdrUnitCount = table.getn(cdrUnitList)
	Sync.CampaignMode = true				-- Enables campaign UI. Note that spectator mode doesn't work with campaign mode enabled unless you know how to fix it.
	StartMission1()

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------





CheckFocusArmy = function()

	if (GetFocusArmy() < 1) then

		SimObjects.GetFocusArmy = function()      -- <<<<< Fix to spectating not working. GetFocusArmy must never be < 1

		local aiBrain = GetArmyBrain(OccupiedArmies[1])

		return (aiBrain:GetArmyIndex())

		end
	end
end



StartMission1 = function()


	local HowManyMustSurvive = 0
	local Desc = ""


	if (ScenarioInfo.Options.opt_defeat_conditions == nil) then
		ScenarioInfo.Options.opt_defeat_conditions = 1
	end


	if (ScenarioInfo.Options.opt_defeat_conditions == 2) then
		HowManyMustSurvive = cdrUnitCount
		Desc = "Defend against incoming attacks. All ACUs must survive."
	else
		HowManyMustSurvive = 1
		Desc = "Defend against incoming attacks. At least one ACU must survive."
	end


	ScenarioInfo.M1P1 = Objectives.Protect(
		'primary',
		'incomplete',
		"Hold The Line",
		Desc,
		{Units = cdrUnitList,
		Timer = nil,
		NumRequired = HowManyMustSurvive,
		MarkUnits = false,
		}
	)

	ScenarioInfo.M1P1:AddResultCallback(
		function(result)
			if(result == false) then
				ForkThread(OnPlayerDefeat)
			end
		end
	)

end






StartMission2 = function()

	ScenarioInfo.M1P2 = Objectives.Timer(
		'primary',
		'incomplete',
		"Survive Untill Recalled",
		"Survive until HQ can recall your ACU.",
		{Timer = 600,
		ExpireResult = 'complete',
		}
	)

	ScenarioInfo.M1P2:AddResultCallback(
		function(result)
			if(result) then
				--LOG("Timer ran out. Victory here.")
				OnPlayerVictory()
			end
		end
		)


end





StartSecondaryMission1 = function()
	ForkThread(DialogueDelay)
	local UnitList = GetArmyBrain("ARMY_SURVIVAL_ENEMY"):GetListOfUnits(categories.NUKESUB, false, false)

	if (table.getn(UnitList) > 0) then

		ScenarioInfo.M1S1 = Objectives.KillOrCapture(
			'secondary',
			'incomplete',
			"Destroy Missile Submarines",
			"Destroy Strategic Missile Submarines before they can build and launch a nuke. Nukes will launch at 35 minute mark.",
			{Units = UnitList,
			NumRequired = table.getn(UnitList),
			MarkUnits = false,
			ShowProgress = true,
			}
		)

		ScenarioInfo.M1S1:AddResultCallback(
			function(result)
				if(result == false) then
					--LOG("Issuing a nuclear launch. Beep boop.")
					-----------------------------------------------------NUKE LAUNCHING SCRIPT-------------------------------------------------------------------------------------------------------------------------------------------------------------
					UnitList = GetArmyBrain("ARMY_SURVIVAL_ENEMY"):GetListOfUnits(categories.NUKESUB, false, false)
					local NukeTargetUnits = {}
					local PotentialNukeTargetUnits = {}
						for x, army in ListArmies() do
							if (army == "ARMY_1" or army == "ARMY_2" or army == "ARMY_3" or army == "ARMY_4" or army == "ARMY_5") then
								PotentialNukeTargetUnits = GetArmyBrain(army):GetListOfUnits(categories.TECH3 - categories.MOBILE - categories.INDIRECTFIRE - categories.DIRECTFIRE - categories.SHIELD - categories.SILO, false, false)  --Target t3 pgens, t3 mexes, t3 factories.
									for k, unit in PotentialNukeTargetUnits do
									table.insert(NukeTargetUnits, unit)
								end
							end
						end
						if (table.getn(NukeTargetUnits) == 0) then
							for x, army in ListArmies() do
								if (army == "ARMY_1" or army == "ARMY_2" or army == "ARMY_3" or army == "ARMY_4" or army == "ARMY_5") then
									PotentialNukeTargetUnits = GetArmyBrain(army):GetListOfUnits(categories.COMMAND, false, false)          --If no other targets found, target commanders
										for k, unit in PotentialNukeTargetUnits do
										table.insert(NukeTargetUnits, unit)
										end
								end
							end
						end

					if (table.getn(NukeTargetUnits) > 0) then
						NukeTargetUnits = ShuffleList(NukeTargetUnits)
						IssueStrategicMissile(UnitList, NukeTargetUnits)
					end
					----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

				end
			end
		)

	else
	LOG("No nukesubs found, not running secondary objective")
	DontStartNukeObjective = 1
	end

end



DialogueDelay = function()
WaitSeconds(6.0)
ScenarioFramework.Dialogue(import('/maps/X1CA_001/X1CA_001_strings.lua').X01_M01_240, nil, true)
end



OnPlayerVictory = function()

	if (GameHasEnded == 0) then
		GameHasEnded = 1
		ScenarioInfo.M1P1:ManualResult(true)
		local TeleportDelay = 0


		for k, army in ListArmies() do
			if (army == "ARMY_1" or army == "ARMY_2" or army == "ARMY_3" or army == "ARMY_4" or army == "ARMY_5") then
				local coms = GetArmyBrain(army):GetListOfUnits(categories.COMMAND, false, false)
				for i, com in coms do
					ForkThread(FakeCommanderTeleport, com, TeleportDelay)
					TeleportDelay = TeleportDelay + 1.5
				end
			end
		end

		WaitSeconds(TeleportDelay + 3.0)
		IssueClearCommands(GetArmyBrain("ARMY_SURVIVAL_ENEMY"):GetListOfUnits( categories.ALLUNITS , false, false))
		ScenarioFramework.Dialogue(import('/maps/X1CA_004/X1CA_004_strings.lua').X04_M03_270, nil, true)  --"You made it!"
		ScenarioFramework.Dialogue(import('/maps/X1CA_001/X1CA_001_strings.lua').TAUNT33, nil, true)  --Sera Taunt4
		WaitSeconds(4.0)

		for k, army in ListArmies() do
			if (army == "ARMY_1" or army == "ARMY_2" or army == "ARMY_3" or army == "ARMY_4" or army == "ARMY_5") then
				GetArmyBrain(army):OnVictory()
			end
		end

		WaitSeconds(10.0)
		EndGame()

	end
end




function FakeCommanderTeleport(com, delay)

com:SetDoNotTarget(true)
com:SetCanBeKilled(false)
WaitSeconds(delay)
ScenarioFramework.FakeGateInUnit(com)  --This effect is the best one.
com:Destroy()

end







OnPlayerDefeat = function()

	if (GameHasEnded == 0) then
		GameHasEnded = 1


		if (DeathDialogueNumber <= 5) then

			ScenarioFramework.FlushDialogueQueue()

			if (DeathDialogue[DeathDialogueNumber] == 1) then

				ScenarioFramework.Dialogue(import('/maps/X1CA_003/X1CA_003_strings.lua').X03_M02_280, nil, true)
				DeathDialogueNumber = DeathDialogueNumber + 1

			elseif (DeathDialogue[DeathDialogueNumber] == 2) then

				ScenarioFramework.Dialogue(import('/maps/X1CA_001/X1CA_001_strings.lua').TAUNT29, nil, true)
				DeathDialogueNumber = DeathDialogueNumber + 1

			elseif (DeathDialogue[DeathDialogueNumber] == 3) then

				ScenarioFramework.Dialogue(import('/maps/X1CA_005/X1CA_005_strings.lua').X05_DB01_040, nil, true)
				DeathDialogueNumber = DeathDialogueNumber + 1

			elseif (DeathDialogue[DeathDialogueNumber] == 4) then

				ScenarioFramework.Dialogue(import('/maps/X1CA_006/X1CA_006_strings.lua').X06_DB01_030, nil, true)
				DeathDialogueNumber = DeathDialogueNumber + 1

			elseif (DeathDialogue[DeathDialogueNumber] == 5) then

				ScenarioFramework.Dialogue(import('/maps/X1CA_003/X1CA_003_strings.lua').X03_DB01_030, nil, true)
				DeathDialogueNumber = DeathDialogueNumber + 1
			end
		end

		IssueClearCommands(GetArmyBrain("ARMY_SURVIVAL_ENEMY"):GetListOfUnits( categories.ALLUNITS , false, false))
		WaitSeconds(4.0)


		for k, army in ListArmies() do
			if (army == "ARMY_1" or army == "ARMY_2" or army == "ARMY_3" or army == "ARMY_4" or "ARMY_5") then
				GetArmyBrain(army):OnDefeat()
			end
		end

		WaitSeconds(10.0)
		EndGame()
	end

end

local TotalGameTime = 2400

Survival_Tick = function(self)


    --local DoOnce = 0
    local cdrUnitListCurrent = cdrUnitList
    local Time = ScenarioInfo.Options.StartTime
    local cdrUnderwater = 0
    local cdrRaiding = 0
    local cdrRaidingDelay = 0
    local HasAirExperimental = 0

    local OncePerTick =  math.floor(GetGameTimeSeconds())


	if Time == nil then
		Time = 0
	end



	while (GameHasEnded == 0) do



		local PlatoonList = {}
		local cmdunit = nil
		local GameTime = math.floor(GetGameTimeSeconds())




		if (OncePerTick < GameTime) then

			----------------------------------------------------------------------DIALOGUE--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

			if (GameTime == 15) then --"Both QAI and HEX are operating in this area" --At the beginning
				ScenarioFramework.Dialogue(import('/maps/X1CA_005/X1CA_005_strings.lua').X05_M01_011, nil, true)
			end

			if (GameTime == 90) then --"Enemy Units Converging to your position." --Around first waves
				ScenarioFramework.Dialogue(import('/maps/X1CA_002/X1CA_002_strings.lua').X02_M02_090, nil, true)  --X02_M02_090
			end

			if (GameTime == 1170) then
				ScenarioFramework.Dialogue(import('/maps/X1CA_002/X1CA_002_strings.lua').TAUNT25, nil, true)  --QAI taunt around 19:30 min mark
            end

            if (GameTime == 1320) then             --Nuke Sub Mission 1320
                StartSecondaryMission1()
            end

            if (GameTime == 1800) then             --Survive Until Recalled
                StartMission2()
            end

			if (GameTime == 1860) then
				ScenarioFramework.Dialogue(import('/maps/X1CA_005/X1CA_005_strings.lua').TAUNT11, nil, true)  --QAI taunt aroun 31 min mark
			end

            if (GameTime == 2070) then  --"Seraphim taunt1"
                ScenarioFramework.Dialogue(import('/maps/X1CA_001/X1CA_001_strings.lua').TAUNT30, nil, true)  --Sera Taunt1 34:30 min mark
            end

			if (GameTime == 2100) then        ----------------------------------------Nukes launching at 35 min 2100
				if (DontStartNukeObjective == 0) then
					ScenarioInfo.M1S1:ManualResult(false)
				end
            end

            if (GameTime == 2405) then  --"Wait until extraction." --When the countdown begins
                ScenarioFramework.Dialogue(import('/maps/X1CA_004/X1CA_004_strings.lua').X04_M03_020, nil, true)
            end

			--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

			local aiBrain = GetArmyBrain("ARMY_SURVIVAL_ENEMY")

			-------------------------------------------------------LAND UNIT IDLE PREVENTER!-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

			local IdleUnitListLand = {}
			local UnitListLand = GetArmyBrain("ARMY_SURVIVAL_ENEMY"):GetListOfUnits( categories.LAND + categories.DESTROYER - categories.COMMAND, true, false)
			local aiBrainLand = GetArmyBrain("ARMY_SURVIVAL_ENEMY")
			local aiPlatoonLand = aiBrainLand:MakePlatoon('','')


			for k, IdleUnit in UnitListLand do

				if (IdleUnit:IsIdleState()) then
					table.insert(IdleUnitListLand, IdleUnit)
				end

			end


			if (table.getn(IdleUnitListLand) > 0) then

				aiBrainLand:AssignUnitsToPlatoon(aiPlatoonLand, IdleUnitListLand, 'Attack', 'None')

				aiPlatoonLand:AggressiveMoveToLocation(ScenarioUtils.MarkerToPosition((ShuffleList(LandCenter))[1])) 			---- Needs to be aggressive move so they will stop to shoot things
				aiPlatoonLand:AggressiveMoveToLocation(ScenarioUtils.MarkerToPosition(LandCenter[2]))
				aiPlatoonLand:AggressiveMoveToLocation(ScenarioUtils.MarkerToPosition(LandCenter[3]))
				aiPlatoonLand:DisbandOnIdle()

			end


			------------------------------------------------------------TORPEDO BOMBER IDLE PREVENTER!---------------------------------------------------------------------------------------------------------------------------------------------------------------------

			local RandomTorpedoRoute = Random(1, table.getn(AllTorpedoRoutes))
			local IdleUnitListTorpedo = {}
			local aiBrain = GetArmyBrain("ARMY_SURVIVAL_ENEMY")
			local UnitListTorpedo = aiBrain:GetListOfUnits(categories.ANTINAVY - categories.LAND - categories.NAVAL - categories.STRUCTURE, false, false)
			local aiPlatoonTorpedo = aiBrain:MakePlatoon('','')
			aiPlatoonTorpedo:DisbandOnIdle()

			for k, IdleUnit in UnitListTorpedo do

				if (IdleUnit:IsIdleState()) then
					table.insert(IdleUnitListTorpedo, IdleUnit)
				end

			end

			if (table.getn(IdleUnitListTorpedo) > 0) then
				aiBrain:AssignUnitsToPlatoon(aiPlatoonTorpedo, IdleUnitListTorpedo, 'Artillery', 'None')
				for i = 1, table.getn(AllTorpedoRoutes[RandomTorpedoRoute]) do

				aiPlatoonTorpedo:AggressiveMoveToLocation(ScenarioUtils.MarkerToPosition(AllTorpedoRoutes[RandomTorpedoRoute][i]))
				end
				aiPlatoonTorpedo:DisbandOnIdle()
			end


			------------------------------------------------------------BOMBER, GUNSHIP, SCOUT AND FIGHTER IDLE PREVENTER!---------------------------------------------------------------------------------------------------------------------------------------------------------------------
			local RandomBomberRoute = 0
			local RandomRoutePicker = 0



				if (cdrRaiding > 0) then

					--RandomRoutePicker = 1
					RandomRoutePicker = Random(1, 2)

				elseif (cdrUnderwater > 0) then

					RandomRoutePicker = Random(1, 2)

				elseif (cdrRaiding == 0) then

					RandomRoutePicker = 2

				end

				if (RandomRoutePicker == 1) then

					RandomBomberRoute = Random(1, table.getn(AllBomberRoutes))

				elseif (RandomRoutePicker == 2) then

					RandomBomberRoute = Random(1, table.getn(AllBomberBaseRoutes))

				end


			-- - categories.ANTIAIR
			local IdleUnitListBomber = {}
			local UnitListBomber = (aiBrain:GetListOfUnits(categories.AIR - categories.UEF - categories.TRANSPORTATION - categories.ANTINAVY + categories.GROUNDATTACK, false, false))
			local aiPlatoonBomber = aiBrain:MakePlatoon('','')
			aiPlatoonBomber:DisbandOnIdle()

			for k, IdleUnit in UnitListBomber do

				if (IdleUnit:IsIdleState() and IdleUnit:GetBlueprint() != "dra0202" ) then
					table.insert(IdleUnitListBomber, IdleUnit)
				end

			end

			if (table.getn(IdleUnitListBomber) > 0) then
				aiBrain:AssignUnitsToPlatoon(aiPlatoonBomber, IdleUnitListBomber, 'Attack', 'None')

				if (RandomRoutePicker == 1) then

					for i = 1, table.getn(AllBomberRoutes[RandomBomberRoute]) do
					aiPlatoonBomber:AggressiveMoveToLocation(ScenarioUtils.MarkerToPosition(AllBomberRoutes[RandomBomberRoute][i]))
					end

				elseif (RandomRoutePicker == 2) then

					for i = 1, table.getn(AllBomberBaseRoutes[RandomBomberRoute]) do
					aiPlatoonBomber:AggressiveMoveToLocation(ScenarioUtils.MarkerToPosition(AllBomberBaseRoutes[RandomBomberRoute][i]))
					end

				end
				aiPlatoonBomber:DisbandOnIdle()
			end




			---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			----------------------------------------------------------TRANSPORT UNIT IDLE PREVENTER!------------------------------------------------------------------------------------------------------------------------------------------------------------------

			local IdleUnitListTransport = GetArmyBrain("ARMY_SURVIVAL_ENEMY"):GetListOfUnits(categories.TRANSPORTATION , true, false)

					for i, unit in IdleUnitListTransport do


							local TransportPOS = unit:GetPosition()
							local MarkerPOS = ScenarioUtils.MarkerToPosition('Survival_LandSpawn2')                                         ---------Sends used transports to a kill box
							local dist = VDist2(TransportPOS[1], TransportPOS[3], MarkerPOS[1], MarkerPOS[3])


							if (dist <= 10) then


								unit:Destroy()

							end
					end

			local aiBrainTransport = GetArmyBrain("ARMY_SURVIVAL_ENEMY")
			local aiPlatoonTransport = aiBrainTransport:MakePlatoon('','')
			local RandomTransportRoute = Random(1, 2)
			aiBrainTransport:AssignUnitsToPlatoon(aiPlatoonTransport, IdleUnitListTransport, 'Attack', 'None')
			ShuffleList(ValidTransportDrops)

			--local TransportRoute1 = {"TransportPath01", "TransportPath06", "TransportPath08"} --TransportDrop04
			--local TransportRoute2 = {"TransportPath01", "TransportPath06", "TransportPath10", "TransportPath11", "TransportPath12", "TransportPath13"} --TransportDrop04
			--local TransportRoute3 = {"TransportPath01", "TransportPath06", "TransportPath10", "TransportPath11", "TransportPath18", "TransportPath19", "TransportPath20"} --TransportDrop05
			--local TransportRoute4 = {"TransportPath02"} --TransportDrop01
			--local TransportRoute5 = {"TransportPath03"} --TransportDrop02
			--local TransportRoute6 = {"TransportPath04"} --TransportDrop06
			--local TransportRoute7 = {"TransportPath05", "TransportPath07", "TransportPath09"} --TransportDrop03
			--local TransportRoute8 = {"TransportPath05", "TransportPath07", "TransportPath17", "TransportPath16", "TransportPath15", "TransportPath14"} --TransportDrop03
			--local TransportRoute9 = {"TransportPath05", "TransportPath07", "TransportPath17", "TransportPath16", "TransportPath23", "TransportPath22", "TransportPath21"} --TransportDrop05

			if (RandomTransportRoute == 1 and ValidTransportDrops[1] == "TransportDrop04") then

				for i = 1, table.getn(TransportRoute1) do

					aiPlatoonTransport:MoveToLocation(ScenarioUtils.MarkerToPosition(TransportRoute1[i]), false)
				end

				UnloadTransport(aiPlatoonTransport, "TransportDrop04")

			elseif (RandomTransportRoute == 2 and ValidTransportDrops[1] == "TransportDrop04") then

				for i = 1, table.getn(TransportRoute2) do

					aiPlatoonTransport:MoveToLocation(ScenarioUtils.MarkerToPosition(TransportRoute2[i]), false)
				end

				UnloadTransport(aiPlatoonTransport, "TransportDrop04")

			elseif (RandomTransportRoute == 1 and ValidTransportDrops[1] == "TransportDrop05") then

				for i = 1, table.getn(TransportRoute3) do

					aiPlatoonTransport:MoveToLocation(ScenarioUtils.MarkerToPosition(TransportRoute3[i]), false)
				end

				UnloadTransport(aiPlatoonTransport, "TransportDrop05")

			elseif (RandomTransportRoute == 2 and ValidTransportDrops[1] == "TransportDrop05") then

				for i = 1, table.getn(TransportRoute9) do

					aiPlatoonTransport:MoveToLocation(ScenarioUtils.MarkerToPosition(TransportRoute9[i]), false)
				end

				UnloadTransport(aiPlatoonTransport, "TransportDrop05")

			elseif (RandomTransportRoute == 1 and ValidTransportDrops[1] == "TransportDrop03") then

				for i = 1, table.getn(TransportRoute7) do

					aiPlatoonTransport:MoveToLocation(ScenarioUtils.MarkerToPosition(TransportRoute7[i]), false)
				end

				UnloadTransport(aiPlatoonTransport, "TransportDrop03")

			elseif (RandomTransportRoute == 2 and ValidTransportDrops[1] == "TransportDrop03") then

				for i = 1, table.getn(TransportRoute8) do

					aiPlatoonTransport:MoveToLocation(ScenarioUtils.MarkerToPosition(TransportRoute8[i]), false)
				end

				UnloadTransport(aiPlatoonTransport, "TransportDrop03")

			elseif (RandomTransportRoute == 1 and ValidTransportDrops[1] == "TransportDrop01") then

				for i = 1, table.getn(TransportRoute4) do

					aiPlatoonTransport:MoveToLocation(ScenarioUtils.MarkerToPosition(TransportRoute4[i]), false)
				end

				UnloadTransport(aiPlatoonTransport, "TransportDrop01")

			elseif (RandomTransportRoute == 2 and ValidTransportDrops[1] == "TransportDrop01") then

				for i = 1, table.getn(TransportRoute4) do

					aiPlatoonTransport:MoveToLocation(ScenarioUtils.MarkerToPosition(TransportRoute4[i]), false)
				end

				UnloadTransport(aiPlatoonTransport, "TransportDrop01")

			elseif (RandomTransportRoute == 1 and ValidTransportDrops[1] == "TransportDrop02") then

				for i = 1, table.getn(TransportRoute5) do

					aiPlatoonTransport:MoveToLocation(ScenarioUtils.MarkerToPosition(TransportRoute5[i]), false)
				end

				UnloadTransport(aiPlatoonTransport, "TransportDrop02")

			elseif (RandomTransportRoute == 2 and ValidTransportDrops[1] == "TransportDrop02") then

				for i = 1, table.getn(TransportRoute5) do

					aiPlatoonTransport:MoveToLocation(ScenarioUtils.MarkerToPosition(TransportRoute5[i]), false)
				end

				UnloadTransport(aiPlatoonTransport, "TransportDrop02")

			elseif (RandomTransportRoute == 1 and ValidTransportDrops[1] == "TransportDrop06") then

				for i = 1, table.getn(TransportRoute6) do

					aiPlatoonTransport:MoveToLocation(ScenarioUtils.MarkerToPosition(TransportRoute6[i]), false)
				end

				UnloadTransport(aiPlatoonTransport, "TransportDrop06")

			elseif (RandomTransportRoute == 2 and ValidTransportDrops[1] == "TransportDrop06") then

				for i = 1, table.getn(TransportRoute6) do

					aiPlatoonTransport:MoveToLocation(ScenarioUtils.MarkerToPosition(TransportRoute6[i]), false)
				end

				UnloadTransport(aiPlatoonTransport, "TransportDrop06")

			else
			end
			IssueMove(aiPlatoonTransport:GetPlatoonUnits(), ScenarioUtils.MarkerToPosition('Survival_LandSpawn2'))  --Transporter KillBox

			-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

			cdrRaiding = 0
			cdrUnderwater = 0
			HasAirExperimental = 0
			local cdrUnitListNew = {}
			local AtLeastOneACURaiding = 0
			local HasT2Navy = 0
			local HasT3Navy = 0

			for i, army in ListArmies() do

				if (army == "ARMY_1" or army == "ARMY_2" or army == "ARMY_3" or army == "ARMY_4" or army == "ARMY_5") then

					local coms = GetArmyBrain(army):GetListOfUnits(categories.COMMAND , false, false)
					local navyT2 = GetArmyBrain(army):GetListOfUnits(categories.NAVAL - categories.TECH3 - categories.TECH1 - categories.EXPERIMENTAL , false, true)  --Has Tech2 Naval
					local navyT3 = GetArmyBrain(army):GetListOfUnits(categories.NAVAL - categories.TECH1 - categories.TECH2 , false, true)  --Has Tech3 Naval
					local AirT4 = GetArmyBrain(army):GetListOfUnits(categories.EXPERIMENTAL - categories.LAND - categories.NAVAL - categories.STRUCTURE , false, true)

					if (table.getn(coms) == 0) then

					else
						for k, com in coms do

							table.insert(cdrUnitListNew, com)
							local cdrPOS = com:GetPosition()
							local cdrDist = VDist2(cdrPOS[1], cdrPOS[3], 249.50, 288.50)
							local cdrDistLane1 = VDist2(cdrPOS[1], cdrPOS[3], 117.50, 270.50) --45 radius
							local cdrDistLane2 = VDist2(cdrPOS[1], cdrPOS[3], 184.50, 204.50) --45 radius
							local cdrDistLane3 = VDist2(cdrPOS[1], cdrPOS[3], 284.50, 190.50) --60 radius
							local cdrDistLane4 = VDist2(cdrPOS[1], cdrPOS[3], 355.50, 238.50) --50 radius

								if (cdrPOS[2] < 20) then --checks if commander is underwater

								cdrUnderwater = 2

								end

								if (cdrDist > 150 and cdrPOS[2] >= 20) then --checks if commander is far away from the middle

									AtLeastOneACURaiding = 1
									--LOG("ACU is raiding.")

								elseif (EnableLane1 == 0 and cdrDistLane1 < 45 and  cdrPOS[2] >= 20) then

									AtLeastOneACURaiding = 1
									--LOG("ACU is raiding.")

								elseif (EnableLane2 == 0 and cdrDistLane2 < 45 and  cdrPOS[2] >= 20) then

									AtLeastOneACURaiding = 1
									--LOG("ACU is raiding.")

								elseif (EnableLane3 == 0 and cdrDistLane3 < 60 and  cdrPOS[2] >= 20) then

									AtLeastOneACURaiding = 1
									--LOG("ACU is raiding.")

								elseif (EnableLane4 == 0 and cdrDistLane4 < 50 and  cdrPOS[2] >= 20) then

									AtLeastOneACURaiding = 1
									--LOG("ACU is raiding.")

								end
								--if (com:IsIdleState()) then
								--LOG("Commander is idling")
								--else
								--LOG("Commander is not idling")
								--end
						end
					end

					if (table.getn(navyT2) > 0) then

						HasT2Navy = 1

					end

					if (table.getn(navyT3) > 0) then

						HasT3Navy = 1

					end

					if (table.getn(AirT4) > 0) then

						HasAirExperimental = 1

					end

				end
			end

			if (AtLeastOneACURaiding == 1) then

				if (GameTime < 1800) then

					cdrRaidingDelay = cdrRaidingDelay + 1
					--LOG("Raiding Delay is " .. cdrRaidingDelay)

				else

					cdrRaiding = 4
					cdrRaidingDelay = 0

				end

			else

					cdrRaidingDelay = 0
					--LOG("Raiding Delay was reset to 0.")

			end

			if (cdrRaidingDelay >= 150) then

				cdrRaiding = 4
				--LOG("Anti-Raiding waves spawned.")

			end

			if (HasT2Navy == 1) then

				cdrUnderwater = cdrUnderwater + 1

			end

			if (HasT3Navy == 1) then

				cdrUnderwater = cdrUnderwater + 1

			end


			--LOG("Has Air Experimental is " .. HasAirExperimental)

			if (table.getn(cdrUnitListNew) < table.getn(cdrUnitListCurrent)) then
				if (DeathDialogueNumber <= 5) then

					ScenarioFramework.FlushDialogueQueue()

					if (DeathDialogue[DeathDialogueNumber] == 1) then

						ScenarioFramework.Dialogue(import('/maps/X1CA_003/X1CA_003_strings.lua').X03_M02_280, nil, true)
						DeathDialogueNumber = DeathDialogueNumber + 1

					elseif (DeathDialogue[DeathDialogueNumber] == 2) then

						ScenarioFramework.Dialogue(import('/maps/X1CA_001/X1CA_001_strings.lua').TAUNT29, nil, true)
						DeathDialogueNumber = DeathDialogueNumber + 1

					elseif (DeathDialogue[DeathDialogueNumber] == 3) then

						ScenarioFramework.Dialogue(import('/maps/X1CA_005/X1CA_005_strings.lua').X05_DB01_040, nil, true)
						DeathDialogueNumber = DeathDialogueNumber + 1

					elseif (DeathDialogue[DeathDialogueNumber] == 4) then

						ScenarioFramework.Dialogue(import('/maps/X1CA_006/X1CA_006_strings.lua').X06_DB01_030, nil, true)
						DeathDialogueNumber = DeathDialogueNumber + 1

					elseif (DeathDialogue[DeathDialogueNumber] == 5) then

						ScenarioFramework.Dialogue(import('/maps/X1CA_003/X1CA_003_strings.lua').X03_DB01_030, nil, true)
						DeathDialogueNumber = DeathDialogueNumber + 1
					end
				end
			end
			cdrUnitListCurrent = cdrUnitListNew


			--LOG("Commanders in water: " .. cdrUnderwater)
			--LOG("Commanders raiding: ".. cdrRaiding)



			----------------------------------------------------------------------------------SPAWN UNIT WAVES---------------------------------------------------------------------------------------------------------------------------------------


			for i = 1, table.getn(WaveOrders) do


				local WaveInfo = WaveOrders[i]


					if (WaveInfo[3] == GameTime) then


						GiveWaveOrders(i, WaveInfo[1], WaveInfo[2], WaveInfo[4])


					end

			end

			------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



			----------------------------------------------------------------------------------SPAWN AIR SUPPORT---------------------------------------------------------------------------------------------------------------------------------------

			--Air unit counts grow linearly as GameTime increases

			local NumOfInterceptors = math.floor((10 + (EnableLane1 * 3) + (EnableLane2 * 3) + (EnableLane3 * 3) + (EnableLane4 * 3) + (EnableLane5 * 10))  * GameTime/1500) --Max 30 interceptors, 960 sec max
			local UnitListInterceptors = aiBrain:GetListOfUnits(categories.ANTIAIR - categories.LAND - categories.NAVAL - categories.STRUCTURE - categories.EXPERIMENTAL - categories.TECH2 - categories.TECH3, false, false)
			local NumOfASF = math.floor((((14 + (EnableLane1 * 3) + (EnableLane2 * 3) + (EnableLane3 * 3) + (EnableLane4 * 3) + (EnableLane5 * 9)) * (GameTime) * (HasAirExperimental + 1))/(2 * (TotalGameTime - 150)))-5)
			local UnitListASF = aiBrain:GetListOfUnits(categories.ANTIAIR - categories.LAND - categories.NAVAL - categories.STRUCTURE - categories.EXPERIMENTAL - categories.TECH1 - categories.TECH2, false, false)

			local NumOfT1Bombers = math.floor(((14 + (EnableLane1 * 4) + (EnableLane2 * 4) + (EnableLane3 * 4) + (EnableLane4 * 4) + (EnableLane5 * 15)) * (cdrRaiding + cdrUnderwater + 4) * GameTime) / (1080 * 12))
			local UnitListT1Bombers = (aiBrain:GetListOfUnits(categories.BOMBER - categories.ANTINAVY - categories.EXPERIMENTAL - categories.TECH2 - categories.TECH3, false, false))
			local NumOfT3Bombers = math.floor(((12 * (cdrRaiding + cdrUnderwater + (EnableLane5 * 2)) * GameTime) / ((TotalGameTime - 150) * 10)))
			local UnitListT3Bombers = (aiBrain:GetListOfUnits(categories.BOMBER - categories.ANTINAVY - categories.EXPERIMENTAL - categories.TECH1 - categories.TECH2, false, false))

			local NumOfT1Gunships = math.floor((12 * GameTime * cdrRaiding)  / (960 * 4))
			local UnitListT1Gunships = aiBrain:GetListOfUnits(categories.GROUNDATTACK - categories.TRANSPORTATION - categories.LAND - categories.NAVAL - categories.STRUCTURE - categories.EXPERIMENTAL - categories.TECH2 - categories.TECH3, false, false)
			local NumOfT2Gunships = math.floor(((28 * cdrRaiding * GameTime) / (1740 * 4))-12)
			local UnitListT2Gunships = aiBrain:GetListOfUnits(categories.GROUNDATTACK - categories.TRANSPORTATION - categories.LAND - categories.NAVAL - categories.STRUCTURE - categories.EXPERIMENTAL - categories.TECH1 - categories.TECH3, false, false)
			local NumOfT3Gunships = math.floor(((35 * cdrRaiding * GameTime) / ((TotalGameTime - 150)*4) - 20))
			local UnitListT3Gunships = aiBrain:GetListOfUnits(categories.GROUNDATTACK - categories.TRANSPORTATION - categories.LAND - categories.NAVAL - categories.STRUCTURE - categories.EXPERIMENTAL - categories.TECH1 - categories.TECH2, false, false)

			local NumOfTorpedoBombers = math.floor(((70 * cdrUnderwater * GameTime) / ((TotalGameTime - 150) * 4)) - 10)
			local UnitListTorpedoBombers = aiBrain:GetListOfUnits(categories.ANTINAVY - categories.LAND - categories.NAVAL - categories.STRUCTURE - categories.EXPERIMENTAL, false, false)

			local NumOfT1Scouts = math.floor((10 + (EnableLane5 * 8)) * GameTime  / 1380)
			local UnitListT1Scouts = aiBrain:GetListOfUnits(categories.INTELLIGENCE - categories.LAND - categories.NAVAL - categories.STRUCTURE - categories.EXPERIMENTAL - categories.TECH2 - categories.TECH3, false, false)
			local NumOfT3Scouts = math.floor(((20 + (EnableLane5 * 5)) * (cdrUnderwater + 4) * GameTime / (8 * (TotalGameTime - 150)) - 5))
			local UnitListT3Scouts = aiBrain:GetListOfUnits(categories.INTELLIGENCE - categories.LAND - categories.NAVAL - categories.STRUCTURE - categories.EXPERIMENTAL - categories.TECH1 - categories.TECH2, false, false)


			--LOG("cdrRaiding: " .. cdrRaiding)
			--LOG("GameTime: " .. GameTime)

			--LOG("EnableLane1 is: " .. EnableLane1)
			--LOG("EnableLane2 is: " .. EnableLane2)
			--LOG("EnableLane3 is: " .. EnableLane3)
			--LOG("EnableLane4 is: " .. EnableLane4)
			--LOG("EnableLane5 is: " .. EnableLane5)


			--LOG("NumOfInterceptors: " .. NumOfInterceptors)
			--LOG("NumOfASF: " .. NumOfASF)
			--LOG("NumOfT1Bombers: " .. NumOfT1Bombers)
			--LOG("NumOfT3Bombers: " .. NumOfT3Bombers)
			--LOG("NumOfT1Gunships: " .. NumOfT1Gunships)
			--LOG("NumOfT2Gunships: " .. NumOfT2Gunships)
			--LOG("NumOfT3Gunships: " .. NumOfT3Gunships)
			--LOG("NumOfTorpedoBombers: " .. NumOfTorpedoBombers)
			--LOG("NumOfT1Scouts: " .. NumOfT1Scouts)
			--LOG("NumOfT3Scouts: " .. NumOfT3Scouts)

			--LOG("UnitListInterceptors: " .. table.getn(UnitListInterceptors))
			--LOG("UnitListASF: " .. table.getn(UnitListASF))
			--LOG("UnitListT1Bombers: " .. table.getn(UnitListT1Bombers))
			--LOG("UnitListT3Bombers: " .. table.getn(UnitListT3Bombers))
			--LOG("UnitListT1Gunships: " .. table.getn(UnitListT1Gunships))
			--LOG("UnitListT2Gunships: " .. table.getn(UnitListT2Gunships))
			--LOG("UnitListT3Gunships: " .. table.getn(UnitListT3Gunships))
			--LOG("UnitListTorpedoBombers: " .. table.getn(UnitListTorpedoBombers))
			--LOG("UnitListT1Scouts: " .. table.getn(UnitListT1Scouts))
			--LOG("UnitListT3Scouts: " .. table.getn(UnitListT3Scouts))

			--Spawn Figthers
			if (GameTime >= 240 and GameTime <= 1500 - (EnableLane5 * 180)) then
					if (table.getn(UnitListInterceptors) <= math.floor(NumOfInterceptors * 2 / 3)) then
					CreateUnitGroup('ura0102', (ShuffleList(AllEnemySpawns))[1], NumOfInterceptors - table.getn(UnitListInterceptors))
					end
			elseif (GameTime > 1500 - (EnableLane5 * 180)) then
					if (table.getn(UnitListASF) <= math.floor(NumOfASF * 2 / 3)) then
					CreateUnitGroup('ura0303', (ShuffleList(AllEnemySpawns))[1], NumOfASF - table.getn(UnitListASF))
					end
			end


			--Spawn Bombers
			if (GameTime >= 240 and GameTime <= 900) then
					if (table.getn(UnitListT1Bombers) <= math.floor(NumOfT1Bombers * 1/2)) then
					CreateUnitGroup('ura0103', (ShuffleList(AllEnemySpawns))[1], NumOfT1Bombers - table.getn(UnitListT1Bombers))
					end
			elseif (GameTime >= 1680 - (EnableLane5 * 180)) then
					if (table.getn(UnitListT3Bombers) <= math.floor(NumOfT3Bombers * 1/2)) then
					CreateUnitGroup('ura0304', (ShuffleList(AllEnemySpawns))[1], NumOfT3Bombers - table.getn(UnitListT3Bombers))
					end
			end


			--Spawn Gunships
			if (GameTime <= 960) then
					if (table.getn(UnitListT1Gunships) == 0 and NumOfT1Gunships > 0) then
					CreateUnitGroup('xra0105', (ShuffleList(AllEnemySpawns))[1], NumOfT1Gunships)
					end
			elseif (GameTime > 960 and GameTime <= 1740) then
					if (table.getn(UnitListT2Gunships) == 0 and NumOfT2Gunships > 0) then
					CreateUnitGroup('ura0203', (ShuffleList(AllEnemySpawns))[1], NumOfT2Gunships)
					end
			elseif (GameTime > 1740) then
					if (table.getn(UnitListT3Gunships) == 0 and NumOfT3Gunships > 0) then
					CreateUnitGroup('xra0305', (ShuffleList(AllEnemySpawns))[1], NumOfT3Gunships)
					end
			end


			--Spawn Torpedo Bombers
			if (GameTime >= 780) then
					if (table.getn(UnitListT3Bombers) <= math.floor(NumOfT3Bombers * 2/3)) then
					CreateUnitGroup('ura0204', (ShuffleList(AllEnemySpawns))[1], NumOfTorpedoBombers - table.getn(UnitListTorpedoBombers))
					end
			end


			--Spawn Scouts
			if (GameTime >= 180 and GameTime <= 1380 - (EnableLane5 * 180)) then
					if (table.getn(UnitListT1Scouts) < NumOfT1Scouts) then
					CreateUnitGroup('ura0101', (ShuffleList(AllEnemySpawns))[1], 1)
					end
			elseif (GameTime > 1380 - (EnableLane5 * 180)) then
					if (table.getn(UnitListT3Scouts) < NumOfT3Scouts) then
					CreateUnitGroup('ura0302', (ShuffleList(AllEnemySpawns))[1], 1)
					end
			end




			-----------------------------------------------------------------------------------GAME ENDING COUNTDOWN--------------------------------------------------------------------
			if (GameHasEnded == 0 and math.floor(TotalGameTime - GameTime) == 10) then
				ScenarioFramework.Dialogue(import('/maps/X1CA_004/X1CA_004_strings.lua').X04_M03_250, nil, true)  --"Almost there..."
			end


			if (GameHasEnded == 0 and math.floor(TotalGameTime - GameTime) == 3) then
				BroadcastMSG("[Teleporting in 3...]", 0)
			end

			if (GameHasEnded == 0 and math.floor(TotalGameTime - GameTime) == 2) then
				BroadcastMSG("[2...]", 0)
			end

			if (GameHasEnded == 0 and math.floor(TotalGameTime - GameTime) == 1) then
				BroadcastMSG("[1...]", 0)
			end

			if (GameHasEnded == 0 and math.floor(TotalGameTime - GameTime) == 0) then
				BroadcastMSG("", 0)
			end

			-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


		end

		OncePerTick = GameTime

		WaitSeconds(0.25)      --"Tick Rate" of this while loop

	end
end














function GetMarker(MarkerName)


	return Scenario.MasterChain._MASTERCHAIN_.Markers[MarkerName] --Get markers by their name


end










function ShuffleList(list)  --Shuffles lists randomly


local SpawnList = list


	for i = 1, table.getn(SpawnList) do

		--local str1 = ''
		--local str2 = ''

		local RandomIndex = Random(1, table.getn(SpawnList))


		local str1 = SpawnList[i]
		local str2 = SpawnList[RandomIndex]

		SpawnList[i] = str2
		SpawnList[RandomIndex] = str1
	end



return SpawnList


end





function ShuffleListPartially(list, startingID, endingID, IgnoreList) --Shuffles list, expect list IDs that are on IgnoreList

local SpawnList = {}
SpawnList = list
local DoNothing = 0

	if (endingID > table.getn(SpawnList)) then
		LOG("ERROR: not valid range given to ShuffleListPartially.")
		LOG("table.getn(SpawnList) is " .. table.getn(SpawnList))
		LOG("endingID is " .. endingID)
		return SpawnList
	else

		for i = startingID, endingID do

			if (IgnoreList != nil) then

				for k = 1, table.getn(IgnoreList) do

					if (i == IgnoreList[k]) then

					DoNothing = 1

					end
				end

			end

			if (DoNothing == 0) then

				local RandomIndex = Random(i, endingID)

					if (IgnoreList != nil) then


						for j = 1, table.getn(IgnoreList) do

							if (RandomIndex == IgnoreList[j]) then

								RandomIndex = Random(i, endingID)
								j = 1

							end

						end

					end


				local str1 = SpawnList[i]
				local str2 = SpawnList[RandomIndex]

				SpawnList[i] = str2
				SpawnList[RandomIndex] = str1

			end

			DoNothing = 0

		end

		return SpawnList

	end
end

CombineList = function(listA, listB)


local FirstList = {}
local SecondList = {}
FirstList = listA
SecondList = listB

	for i = 1, table.getn(SecondList) do
		FirstList[table.getn(FirstList) + i] = SecondList[i]
	end
	return FirstList


end









GiveAttackOrderFormation = function(aiPlatoon, MarkerList)


	for i, marker in MarkerList do
	aiPlatoon:AggressiveMoveToLocation(ScenarioUtils.MarkerToPosition(marker))
	end


end



GiveMoveOrderFormation = function(aiPlatoon, MarkerList)


	for i, marker in MarkerList do
		aiPlatoon:MoveToLocation(ScenarioUtils.MarkerToPosition(marker), false)
	end


end





GiveAttackOrder = function(aiPlatoon, MarkerList)

		for i, marker in MarkerList do
			IssueAggressiveMove((aiPlatoon:GetPlatoonUnits()), ScenarioUtils.MarkerToPosition(marker), 'GrowthFormation', 10)
		end

end





GiveMoveOrder = function(aiPlatoon, MarkerList) --Need this because platoon:MoveToLocation doesn't work without unit formations

	for k, unit in aiPlatoon:GetPlatoonUnits() do

		local RandomX = Random(-90, 90) / 10
		local RandomY = Random(-90, 90) / 10


		for i, marker in MarkerList do

		local POS = ScenarioUtils.MarkerToPosition(marker)

			IssueMove({unit}, {POS[1] + RandomX, POS[2], POS[3] + RandomY})

		end

	end

end


















GiveAssistOrder = function(aiPlatoon, WaveID, TargetType)

	local CurrentWave = WaveTable[WaveID]
	local UnitList = CurrentWave[1]

	UnitList = ShuffleList(UnitList)  --ERROR: Unit Has Been Destroyed
		for i, unit in UnitList do

			if (unit:BeenDestroyed() == false) then
				if(unit:GetUnitId() == TargetType) then
					IssueGuard(aiPlatoon:GetPlatoonUnits(), UnitList[i])
				end
			end
		end


end




GiveTransportOrder = function(aiPlatoon, Quantity, techlevel)

local UnitList = {}
local POS = aiPlatoon:GetPlatoonPosition()


		for i = 1, Quantity do

			local NewUnit = 0
			if (techlevel == "Tech1") then
			NewUnit = CreateUnitHPR('ura0107', "ARMY_SURVIVAL_ENEMY", POS[1] + ((Random(-50,50) / 15)), POS[2], POS[3] + ((Random(-50,50) / 15)), 0, 0, 0)
			else
			NewUnit = CreateUnitHPR('ura0104', "ARMY_SURVIVAL_ENEMY", POS[1] + ((Random(-50,50) / 15)), POS[2], POS[3] + ((Random(-50,50) / 15)), 0, 0, 0)
			end

			NewUnit:SetProductionPerSecondEnergy(2500)
			NewUnit:SetConsumptionPerSecondEnergy(0)
			NewUnit:SetProductionPerSecondMass(50)
			NewUnit:SetFuelUseTime(9999)
			table.insert(UnitList, NewUnit)
		end

		ScenarioFramework.AttachUnitsToTransports(aiPlatoon:GetPlatoonUnits(), UnitList)

end




UnloadTransport = function(aiPlatoon, marker)

		IssueTransportUnload(aiPlatoon:GetPlatoonUnits(), ScenarioUtils.MarkerToPosition(marker))

end



















BuildEnhancement = function(aiPlatoon, prebuild)

	for k, unit in aiPlatoon:GetPlatoonUnits() do
		if (unit:BeenDestroyed() == false) then
			if (unit:GetUnitId() == 'url0301') then --Cybran sACU
				if (prebuild == "CombatantWeak") then

					unit:CreateEnhancement('FocusConvertor')
					unit:CreateEnhancement('EMPCharge')

				elseif (prebuild == "CombatantMedium") then

					unit:CreateEnhancement('EMPCharge')
					unit:CreateEnhancement('FocusConvertor')
					unit:CreateEnhancement('StealthGenerator')

				elseif (prebuild == "CombatantStrong") then

					unit:CreateEnhancement('EMPCharge')
					unit:CreateEnhancement('FocusConvertor')
					unit:CreateEnhancement('CloakingGenerator')
					unit:EnableIntel('Cloak')

				else
				--Do nothing
				end

				--Name sACUs
				if (sACUnameID <= table.getn(sACUnames)) then

					unit:SetCustomName(sACUnames[sACUnameID])
					sACUnameID = sACUnameID + 1

				elseif (sACUnameID > table.getn(sACUnames)) then

					sACUnameID = 1
					unit:SetCustomName(sACUnames[sACUnameID])
					sACUnameID = sACUnameID + 1

				end

			end
		end

	end
end












IssueNameChange = function(aiPlatoon, UnitID)

	local strUnitID = ''
	strUnitID = UnitID
	local UnitList = aiPlatoon:GetPlatoonUnits()

	for k, unit in UnitList do
		if (unit:BeenDestroyed() == false) then
			if (unit:GetUnitId() == strUnitID) then


				if (SpecialNamesID <= table.getn(SpecialNames)) then

					unit:SetCustomName(SpecialNames[SpecialNamesID])
					SpecialNamesID = SpecialNamesID + 1

				elseif (SpecialNamesID > table.getn(SpecialNames)) then

					SpecialNamesID = 1
					unit:SetCustomName(SpecialNames[SpecialNamesID])
					SpecialNamesID = SpecialNamesID + 1

				end


			end
		end
	end

end










IssueStrategicMissile = function(UnitList, TargetList) --Issue nuke launch

	local target = 1
	IssueClearCommands(UnitList)
	for k, unit in UnitList do


		if (unit:BeenDestroyed() == false) then
			if (unit:GetUnitId() == 'urs0304') then
				local POS = TargetList[target]:GetPosition()
				--LOG("Position: " .. POS[1] .. ", " .. POS[2] .. ", " .. POS[3] .. ".")
				unit:GiveNukeSiloAmmo(1)
				IssueNuke({unit}, POS)
				if (target < table.getn(TargetList)) then
					target = target + 1
				else
				target = 1
				end
			end
		end
	end
end







GiveWaveOrders = function(WaveOrderNumber, WaveID, SpawnPoint, Formation)      ------------------------------------------------------------------------------ Creating waves and giving them orders.

	local strSpawnPoint = ""
	strSpawnPoint = SpawnPoint

	local strFormation = ''
	strFormation = Formation


	local WaveInfo = WaveOrders[WaveOrderNumber]
	local platoon = CreateWaveID(WaveID, strSpawnPoint, strFormation)

	if (platoon != nil) then

		for i = 0, (table.getn(WaveInfo) -4 -3 / 3) do

			local r = 3*i + 4

				if (WaveInfo[r + 1] == "IssueAttackFormation") then

					GiveAttackOrderFormation(platoon, WaveInfo[r + 2])

				elseif (WaveInfo[r + 1] == "GiveAssistOrder") then

					GiveAssistOrder(platoon, WaveInfo[r + 2], WaveInfo[r + 3])

				elseif (WaveInfo[r + 1] == "LoadUnitsToTransport") then

					GiveTransportOrder(platoon, WaveInfo[r + 2], WaveInfo[r + 3])

				elseif (WaveInfo[r + 1] == "UnloadTransport") then

					UnloadTransport(platoon, WaveInfo[r + 2])

				elseif (WaveInfo[r + 1] == "IssueAttack") then

					GiveAttackOrder(platoon, WaveInfo[r + 2])

				elseif (WaveInfo[r + 1] == "Enhancements") then

					BuildEnhancement(platoon, WaveInfo[r + 2])

				elseif (WaveInfo[r + 1] == "IssueMove") then

					GiveMoveOrder(platoon, WaveInfo[r + 2])

				elseif (WaveInfo[r + 1] == "IssueMoveFormation") then

					GiveMoveOrderFormation(platoon, WaveInfo[r + 2])

				elseif (WaveInfo[r + 1] == "IssueNameChange") then

					IssueNameChange(platoon, WaveInfo[r + 2])

				else
				end
		end

	else
	return
	end

end







---------------------------------------------------------------------------------------------------CREATE WAVES FROM WAVETABLE--------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateWaveID = function(ID, SpawnPoint, Formation)


local strSpawnPoint = ""
strSpawnPoint = SpawnPoint
local strFormation = ''
strFormation = Formation


local UnitList = {}
local CurrentWave = WaveTable[ID]
local POS = GetMarker(SpawnPoint).position

	if (WaveTable[ID] != "NULL") then

		for k = 0, ((table.getn(CurrentWave) - 2 - 1) / 2) do
				local r = 2*k + 1

				for i = 1, CurrentWave[2 + r] do
					local NewUnit = CreateUnitHPR(CurrentWave[1 + r], "ARMY_SURVIVAL_ENEMY", POS[1] + (Random(-45,45) / 10), POS[2], POS[3] + (Random(40,45) / 15), 0,0,0) --((Random(-50,50) / 15))


					if EntityCategoryContains(categories.AIR - categories.EXPERIMENTAL, NewUnit) then
						NewUnit:SetFuelUseTime(9999)
					end

					NewUnit:EnableIntel('RadarStealth')
					NewUnit:EnableIntel('Jammer')
					NewUnit:EnableIntel('RadarStealthField')
					NewUnit:EnableIntel('SonarStealth')
					NewUnit:EnableIntel('SonarStealthField')
					table.insert(UnitList, NewUnit)
				end

		end


 		local aiBrain = GetArmyBrain("ARMY_SURVIVAL_ENEMY")
		local aiPlatoon = aiBrain:MakePlatoon('','')
		aiBrain:AssignUnitsToPlatoon(aiPlatoon, UnitList, 'Attack', strFormation)

		CurrentWave[1] = UnitList
		WaveTable[ID] = CurrentWave
		return aiPlatoon
	else
	return nil
	end

end

--WARNING: Error running lua script: Invalid enum value RadarCloak
--         Valid Options are:
--            None
--           Vision
--           WaterVision
--           Radar
--          Sonar
--         Omni
--         RadarStealthField
--          SonarStealthField
--         CloakField
--         Jammer
--          Spoof
--         Cloak
--          RadarStealth
--        SonarStealth

CreateUnitGroup = function(Blueprint, SpawnPoint, Quantity) --Used to creating enemy units outside the wave table

local strBluePrint = ''
strBluePrint = Blueprint
local POS = GetMarker(SpawnPoint).position
		for i = 1, Quantity do
			local NewUnit = CreateUnitHPR(Blueprint, "ARMY_SURVIVAL_ENEMY", POS[1] + ((Random(-110,110) / 10)), POS[2], POS[3] + ((Random(-50,50) / 15)), 0, 0, 0)

			if EntityCategoryContains(categories.AIR - categories.EXPERIMENTAL, NewUnit) then
				NewUnit:SetFuelUseTime(9999)
			end
			NewUnit:EnableIntel('RadarStealth')
			NewUnit:EnableIntel('Jammer')
			NewUnit:EnableIntel('RadarStealthField')
			NewUnit:EnableIntel('SonarStealth')
			NewUnit:EnableIntel('SonarStealthField')
		end
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


BroadcastMSG = function(MSG, Fade, TextColor)
	PrintText(MSG, 20, TextColor, Fade, 'center')
end

ForkThread(function()
    local textPrinter = import('/maps/survival_horde_ee.v0008/src/TextPrinter.lua').newInstance()

    local headerOptions = {color = "ffb4ffd4", duration = 11, location = "leftcenter", size = 35 }
    local textOptions = {color = "ffb4ffd4", duration = 11, location = "leftcenter" }

    textPrinter.print(string.rep( " ", 12 ) .. "Welcome to Survival Horde", headerOptions)
    textPrinter.printBlankLine(textOptions)
    textPrinter.print(string.rep( " ", 20 ) .. "Entropy Edition, version 8", textOptions)
    textPrinter.printBlankLine(textOptions)
    textPrinter.printBlankLine(textOptions)
    textPrinter.print(string.rep( " ", 20 ) .. "You will need some extra AA in this version ;)", textOptions)
end)

local function newAirwingSpawner()
    local mapSizeX, mapSizeY = GetMapSize()
    return import('/maps/survival_horde_ee.v0008/src/AirwingSpawner.lua').newInstance(mapSizeX, mapSizeY, "ARMY_SURVIVAL_ENEMY")
end

ForkThread(function()
    local spawner = newAirwingSpawner()
    spawner.spawn("uea0302", false, {y = 15})
    WaitSeconds(2)
    spawner.spawn("uea0303", false, {y = 15})
    WaitSeconds(2)
    spawner.spawn("uea0304", false, {y = 50})
end)

ForkThread(function()
    WaitSeconds(1490)

    local textPrinter = import('/maps/survival_horde_ee.v0008/src/TextPrinter.lua').newInstance()
    textPrinter.print("Enemy bombers detected!")

    WaitSeconds(10)

    local spawner = newAirwingSpawner()
    spawner.spawn("uea0302", false, {y = 15})
    WaitSeconds(2)
    spawner.spawn("uea0303", false, {y = 15})
    WaitSeconds(2)
    spawner.spawn("dra0202", true, {y = 25, wingRadius = 3})
    WaitSeconds(2)
    spawner.spawn("dra0202", true, {y = 25, wingRadius = 3})
end)

ForkThread(function()
    WaitSeconds(TotalGameTime - 140)

    local textPrinter = import('/maps/survival_horde_ee.v0008/src/TextPrinter.lua').newInstance()
    textPrinter.print("Enemy strategic bombers detected!")

    WaitSeconds(20)

    local spawner = newAirwingSpawner()
    spawner.spawn("uea0302", false, {y = 15})
    WaitSeconds(2)
    spawner.spawn("uea0303", false, {y = 15})
    WaitSeconds(2)
    spawner.spawn("uea0303", true, {y = 15})
    WaitSeconds(2)
    spawner.spawn("uea0304", true, {y = 25, sparseness = 3, wingRadius = 3})
end)
