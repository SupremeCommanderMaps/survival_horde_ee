local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local Objectives = import('/lua/ScenarioFramework.lua').Objectives
local SimObjects = import('/lua/SimObjectives.lua')

local OccupiedArmies = {}

local options = import('/maps/survival_horde_ee.v0019/src/Options.lua').newInstance(ScenarioInfo.Options)

--NAME: Survival Horde

--There was supposed to be 5th player on the middle (this script supports 5th player, only 5th spawn is missing) but I didn't bother to create waves for the fifth player.
--There was also supposed to be transport drops (which are working perfectly) but it would've been too difficult for players to deal with because land waves are so strong. Maybe for fifth player if I ever create the fifth player.
--Thanks for the other survival map creators for giving me some ideas! (survival escape, fifth dimension, mycelium)




--LISTING WAYPOINTS FOR UNIT NAVIGATION

local LandCenter = { "PlayerSpawn_1", "PlayerSpawn_2", "PlayerSpawn_3", "PlayerSpawn_4", "PatrolBase_5", "PatrolBase_6", "PatrolBase_7", "PatrolBase_8", "TransportDrop05" }
local AllEnemySpawns = { "Survival_LandSpawn1", "Survival_LandSpawn2", "Survival_LandSpawn3", "Survival_LandSpawn4", "Survival_Spawn1", "Survival_Spawn4" }


local TransportRoute1 = { "TransportPath01", "TransportPath06" } --TransportDrop04
local TransportRoute2 = { "TransportPath01", "TransportPath06", "TransportPath10", "TransportPath11", "TransportPath18" } --TransportDrop04
local TransportRoute3 = { "TransportPath01", "TransportPath06", "TransportPath10", "TransportPath11", "TransportPath18", "TransportPath19" } --TransportDrop05
local TransportRoute4 = { "TransportPath02" } --TransportDrop01
local TransportRoute5 = { "TransportPath03" } --TransportDrop02
local TransportRoute6 = { "TransportPath04" } --TransportDrop06
local TransportRoute7 = { "TransportPath05", "TransportPath07" } --TransportDrop03
local TransportRoute8 = { "TransportPath05", "TransportPath07", "TransportPath17", "TransportPath16" } --TransportDrop03
local TransportRoute9 = { "TransportPath05", "TransportPath07", "TransportPath17", "TransportPath16", "TransportPath23" } --TransportDrop05



--TORPEDO BOMBER ROUTES
local TorpedoRoute01 = { "TorpedoPatrol01", "TorpedoPatrol02", "TorpedoPatrol03", "TorpedoPatrol04", "TorpedoPatrol05", "TorpedoPatrol06", "TorpedoPatrol07", "TorpedoPatrol08", "TorpedoPatrol09", "TorpedoPatrol10", "TorpedoPatrol11" }
local TorpedoRoute02 = { "TorpedoPatrol08", "TorpedoPatrol07", "TorpedoPatrol06", "TorpedoPatrol05", "TorpedoPatrol04", "TorpedoPatrol03", "TorpedoPatrol02", "TorpedoPatrol01", "TorpedoPatrol11", "TorpedoPatrol10", "TorpedoPatrol09" }
local TorpedoRoute03 = { "TorpedoPatrol12", "TorpedoPatrol13", "TorpedoPatrol14", "TorpedoPatrol15", "TorpedoPatrol16", "TorpedoPatrol17", "TorpedoPatrol18", "TorpedoPatrol19", "TorpedoPatrol20", "TorpedoPatrol21", "TorpedoPatrol22", "TorpedoPatrol23", "TorpedoPatrol24" }
local TorpedoRoute04 = { "TorpedoPatrol19", "TorpedoPatrol18", "TorpedoPatrol17", "TorpedoPatrol16", "TorpedoPatrol15", "TorpedoPatrol14", "TorpedoPatrol13", "TorpedoPatrol12", "TorpedoPatrol24", "TorpedoPatrol23", "TorpedoPatrol22", "TorpedoPatrol21", "TorpedoPatrol20" }
local TorpedoRoute05 = { "TorpedoPatrol25", "TorpedoPatrol26", "TorpedoPatrol27", "TorpedoPatrol28", "TorpedoPatrol29", "TorpedoPatrol30", "TorpedoPatrol31", "TorpedoPatrol32", "TorpedoPatrol33", "TorpedoPatrol34", "TorpedoPatrol35", "TorpedoPatrol36" }
local TorpedoRoute06 = { "TorpedoPatrol32", "TorpedoPatrol31", "TorpedoPatrol30", "TorpedoPatrol29", "TorpedoPatrol28", "TorpedoPatrol27", "TorpedoPatrol26", "TorpedoPatrol25", "TorpedoPatrol36", "TorpedoPatrol35", "TorpedoPatrol34", "TorpedoPatrol33" }
local TorpedoRoute07 = { "TorpedoPatrol37", "TorpedoPatrol38", "TorpedoPatrol39", "TorpedoPatrol40", "TorpedoPatrol41", "TorpedoPatrol42", "TorpedoPatrol43", "TorpedoPatrol44", "TorpedoPatrol45", "TorpedoPatrol46", "TorpedoPatrol47" }
local TorpedoRoute08 = { "TorpedoPatrol44", "TorpedoPatrol43", "TorpedoPatrol42", "TorpedoPatrol41", "TorpedoPatrol40", "TorpedoPatrol39", "TorpedoPatrol38", "TorpedoPatrol37", "TorpedoPatrol47", "TorpedoPatrol46", "TorpedoPatrol45" }
local TorpedoRoute09 = { "TorpedoPatrol48", "TorpedoPatrol49", "TorpedoPatrol50", "TorpedoPatrol51", "TorpedoPatrol52", "TorpedoPatrol53", "TorpedoPatrol54", "TorpedoPatrol55", "TorpedoPatrol56" }
local TorpedoRoute10 = { "TorpedoPatrol54", "TorpedoPatrol53", "TorpedoPatrol52", "TorpedoPatrol51", "TorpedoPatrol50", "TorpedoPatrol49", "TorpedoPatrol48", "TorpedoPatrol56", "TorpedoPatrol55" }
local AllTorpedoRoutes = { TorpedoRoute01, TorpedoRoute02, TorpedoRoute03, TorpedoRoute04, TorpedoRoute05, TorpedoRoute06, TorpedoRoute07, TorpedoRoute08, TorpedoRoute09, TorpedoRoute10 }

--BOMBER BASE ROUTES
local BomberBaseRoute01 = { "BomberBasePath01", "BomberBasePath02", "BomberBasePath03", "BomberBasePath04", "BomberBasePath05", "BomberBasePath06", "BomberBasePath07" }
local BomberBaseRoute02 = { "BomberBasePath06", "BomberBasePath05", "BomberBasePath04", "BomberBasePath03", "BomberBasePath02", "BomberBasePath01", "BomberBasePath08" }
local BomberBaseRoute03 = { "BomberBasePath09", "BomberBasePath10", "BomberBasePath11", "BomberBasePath12", "BomberBasePath13", "BomberBasePath14", "BomberBasePath15" }
local BomberBaseRoute04 = { "BomberBasePath14", "BomberBasePath13", "BomberBasePath12", "BomberBasePath11", "BomberBasePath10", "BomberBasePath09", "BomberBasePath16" }
local BomberBaseRoute05 = { "BomberBasePath17", "BomberBasePath02", "BomberBasePath10", "BomberBasePath18", "BomberBasePath19" }
local BomberBaseRoute06 = { "BomberBasePath18", "BomberBasePath10", "BomberBasePath02", "BomberBasePath17", "BomberBasePath21" }
local BomberBaseRoute07 = { "BomberBasePath22", "BomberBasePath23", "BomberBasePath03", "BomberBasePath24", "BomberBasePath11", "BomberBasePath25", "BomberBasePath26", "BomberBasePath27" }
local BomberBaseRoute08 = { "BomberBasePath26", "BomberBasePath25", "BomberBasePath11", "BomberBasePath24", "BomberBasePath03", "BomberBasePath23", "BomberBasePath22", "BomberBasePath29" }
local BomberBaseRoute09 = { "BomberBasePath30", "BomberBasePath31", "BomberBasePath32", "BomberBasePath33", "BomberBasePath34", "BomberBasePath35", "BomberBasePath36", "BomberBasePath37", "BomberBasePath38" }
local BomberBaseRoute10 = { "BomberBasePath37", "BomberBasePath36", "BomberBasePath35", "BomberBasePath34", "BomberBasePath33", "BomberBasePath32", "BomberBasePath31", "BomberBasePath30", "BomberBasePath40" }
local BomberBaseRoute11 = { "BomberBasePath41", "BomberBasePath42", "BomberBasePath43", "BomberBasePath44", "BomberBasePath34", "BomberBasePath45", "BomberBasePath46", "BomberBasePath47", "BomberBasePath48" }
local BomberBaseRoute12 = { "BomberBasePath47", "BomberBasePath46", "BomberBasePath45", "BomberBasePath34", "BomberBasePath44", "BomberBasePath43", "BomberBasePath42", "BomberBasePath41", "BomberBasePath50" }
local BomberBaseRoute13 = { "BomberBasePath51", "BomberBasePath03", "BomberBasePath52", "BomberBasePath53", "BomberBasePath54", "BomberBasePath55", "BomberBasePath56", "BomberBasePath57" }
local BomberBaseRoute14 = { "BomberBasePath56", "BomberBasePath55", "BomberBasePath54", "BomberBasePath53", "BomberBasePath52", "BomberBasePath03", "BomberBasePath51", "BomberBasePath59" }
local BomberBaseRoute15 = { "BomberBasePath60", "BomberBasePath11", "BomberBasePath61", "BomberBasePath53", "BomberBasePath62", "BomberBasePath63", "BomberBasePath64", "BomberBasePath65" }
local BomberBaseRoute16 = { "BomberBasePath64", "BomberBasePath63", "BomberBasePath62", "BomberBasePath53", "BomberBasePath61", "BomberBasePath11", "BomberBasePath60", "BomberBasePath67" }
local BomberBaseRoute17 = { "BomberBasePath68", "BomberBasePath02", "BomberBasePath69", "BomberBasePath32", "BomberBasePath70", "BomberBasePath71", "BomberBasePath72", "BomberBasePath73" }
local BomberBaseRoute18 = { "BomberBasePath72", "BomberBasePath71", "BomberBasePath70", "BomberBasePath69", "BomberBasePath02", "BomberBasePath68", "BomberBasePath74" }
local BomberBaseRoute19 = { "BomberBasePath75", "BomberBasePath10", "BomberBasePath76", "BomberBasePath43", "BomberBasePath77", "BomberBasePath78", "BomberBasePath79", "BomberBasePath80" }
local BomberBaseRoute20 = { "BomberBasePath79", "BomberBasePath78", "BomberBasePath77", "BomberBasePath43", "BomberBasePath76", "BomberBasePath10", "BomberBasePath75", "BomberBasePath81" }
local BomberBaseRoute21 = { "BomberBasePath82", "BomberBasePath02", "BomberBasePath24", "BomberBasePath44", "BomberBasePath83", "BomberBasePath84", "BomberBasePath85", "BomberBasePath86" }
local BomberBaseRoute22 = { "BomberBasePath85", "BomberBasePath84", "BomberBasePath83", "BomberBasePath44", "BomberBasePath24", "BomberBasePath02", "BomberBasePath82", "BomberBasePath87" }
local BomberBaseRoute23 = { "BomberBasePath88", "BomberBasePath10", "BomberBasePath24", "BomberBasePath33", "BomberBasePath89", "BomberBasePath90", "BomberBasePath91", "BomberBasePath92" }
local BomberBaseRoute24 = { "BomberBasePath91", "BomberBasePath90", "BomberBasePath89", "BomberBasePath33", "BomberBasePath24", "BomberBasePath10", "BomberBasePath88", "BomberBasePath93" }
local BomberBaseRoute25 = { "BomberBasePath94", "BomberBasePath03", "BomberBasePath52", "BomberBasePath53", "BomberBasePath95", "BomberBasePath96", "BomberBasePath97", "BomberBasePath98", "BomberBasePath99" }
local BomberBaseRoute26 = { "BomberBasePath98", "BomberBasePath97", "BomberBasePath96", "BomberBasePath95", "BomberBasePath53", "BomberBasePath52", "BomberBasePath03", "BomberBasePath94", "BomberBasePath101" }
local BomberBaseRoute27 = { "BomberBasePath102", "BomberBasePath11", "BomberBasePath61", "BomberBasePath53", "BomberBasePath103", "BomberBasePath104", "BomberBasePath105", "BomberBasePath106", "BomberBasePath107" }
local BomberBaseRoute28 = { "BomberBasePath106", "BomberBasePath105", "BomberBasePath104", "BomberBasePath103", "BomberBasePath53", "BomberBasePath61", "BomberBasePath11", "BomberBasePath102", "BomberBasePath109" }
local AllBomberBaseRoutes = { BomberBaseRoute01, BomberBaseRoute02, BomberBaseRoute03, BomberBaseRoute04, BomberBaseRoute05, BomberBaseRoute06, BomberBaseRoute07, BomberBaseRoute08, BomberBaseRoute09, BomberBaseRoute10, BomberBaseRoute11, BomberBaseRoute12, BomberBaseRoute13, BomberBaseRoute14, BomberBaseRoute15, BomberBaseRoute16, BomberBaseRoute17, BomberBaseRoute18, BomberBaseRoute19, BomberBaseRoute20, BomberBaseRoute21, BomberBaseRoute22, BomberBaseRoute23, BomberBaseRoute24, BomberBaseRoute25, BomberBaseRoute26, BomberBaseRoute27, BomberBaseRoute28 }

--BOMBER ROUTES
local BomberRoute01 = { "BomberPath01", "BomberPath02", "BomberPath03", "BomberPath04", "BomberPath05", "BomberPath06", "BomberPath07", "BomberPath08", "BomberPath09", "BomberPath10", "BomberPath11" }
local BomberRoute02 = { "BomberPath08", "BomberPath07", "BomberPath06", "BomberPath05", "BomberPath04", "BomberPath03", "BomberPath02", "BomberPath01", "BomberPath11", "BomberPath10", "BomberPath09" }
local BomberRoute03 = { "BomberPath12", "BomberPath13", "BomberPath14", "BomberPath15", "BomberPath16", "BomberPath17", "BomberPath18", "BomberPath19", "BomberPath20", "BomberPath21", "BomberPath22" }
local BomberRoute04 = { "BomberPath19", "BomberPath18", "BomberPath17", "BomberPath16", "BomberPath15", "BomberPath14", "BomberPath13", "BomberPath12", "BomberPath22", "BomberPath21", "BomberPath20" }
local BomberRoute05 = { "BomberPath23", "BomberPath24", "BomberPath25", "BomberPath26", "BomberPath27", "BomberPath28", "BomberPath29", "BomberPath30" }
local BomberRoute06 = { "BomberPath28", "BomberPath27", "BomberPath26", "BomberPath25", "BomberPath24", "BomberPath23", "BomberPath30", "BomberPath29" }
local BomberRoute07 = { "BomberPath31", "BomberPath32", "BomberPath33", "BomberPath34", "BomberPath35", "BomberPath36", "BomberPath37", "BomberPath38" }
local BomberRoute08 = { "BomberPath36", "BomberPath35", "BomberPath34", "BomberPath33", "BomberPath32", "BomberPath31", "BomberPath38", "BomberPath37" }
local BomberRoute09 = { "BomberPath39", "BomberPath40", "BomberPath41", "BomberPath42", "BomberPath43", "BomberPath44", "BomberPath45", "BomberPath46", "BomberPath47" }
local BomberRoute10 = { "BomberPath45", "BomberPath44", "BomberPath43", "BomberPath42", "BomberPath41", "BomberPath40", "BomberPath39", "BomberPath47", "BomberPath46" }
local BomberRoute11 = { "BomberPath48", "BomberPath49", "BomberPath50", "BomberPath51", "BomberPath52", "BomberPath53", "BomberPath54", "BomberPath55", "BomberPath56" }
local BomberRoute12 = { "BomberPath54", "BomberPath53", "BomberPath52", "BomberPath51", "BomberPath50", "BomberPath49", "BomberPath48", "BomberPath56", "BomberPath55" }
local BomberRoute13 = { "BomberPath59", "BomberPath60", "BomberPath61", "BomberPath62", "BomberPath63", "BomberPath57", "BomberPath58" }
local BomberRoute14 = { "BomberPath62", "BomberPath61", "BomberPath60", "BomberPath59", "BomberPath58", "BomberPath57", "BomberPath63" }
local AllBomberRoutes = { BomberRoute01, BomberRoute02, BomberRoute03, BomberRoute04, BomberRoute05, BomberRoute06, BomberRoute07, BomberRoute08, BomberRoute09, BomberRoute10, BomberRoute11, BomberRoute12, BomberRoute13, BomberRoute14 }

--NAMES
local SpecialNames = { "Ripper", "Judas", "Hellbringer", "Trix", "Bulldog", "Doomer", "Punisher", "Ludvig", "Odyssey", "Little Furball", "Stompy", "Flamer", "Inferno", "The Barbarian", "Barbarossa" }
local SpecialNamesID = 1
local sACUnames = { "Jackson", "Anders", "Leo", "Max", "Adrik", "Alexei", "Iona", "Ali", "Felix", "Jade", "Anna", "Ellie", "Jacob", "Jill", "Rick", "Adrian", "Geoff", "Peter", "Adam", "Jack", "Thomas", "Neon" }
local sACUnameID = 1

--OTHER
local DontStartNukeObjective = 0
local GameHasEnded = 0
local cdrUnitList = {}
local cdrUnitCount = 0
local DeathDialogueNumber = 1
local DeathDialogue = { 1, 2, 3, 4, 5 }

local WaveOrders = {}
local WaveTable = {}
local WaveDelay = { 0, 60, 120, 180 }
local EnableLane1 = 0
local EnableLane2 = 0
local EnableLane3 = 0
local EnableLane4 = 0
local EnableLane5 = 0
local IgnoredLanesList = {}
local BaseRaidingTargets = {}
local ValidTransportDrops = {}


function ShuffleList(list)
    local SpawnList = list

    for i = 1, table.getn(SpawnList) do
        local RandomIndex = Random(1, table.getn(SpawnList))

        SpawnList[i] = SpawnList[RandomIndex]
        SpawnList[RandomIndex] = SpawnList[i]
    end

    return SpawnList
end


DeathDialogue = ShuffleList(DeathDialogue)
ShuffleList(WaveDelay)
ShuffleList(sACUnames)
ShuffleList(SpecialNames)



function ScenarioUtils.CommanderWarpDelay(cdrUnit, delay) --Silly way to disable Warp in effect.

    local army = cdrUnit:GetArmy()
    local aiBrain = GetArmyBrain(army)

    if (aiBrain:GetFactionIndex() == 1) then
        cdrUnit:ShowBone(0, true)
        cdrUnit:HideBone('Right_Upgrade', true)
        cdrUnit:HideBone('Left_Upgrade', true)
        cdrUnit:HideBone('Back_Upgrade_B01', true)
        cdrUnit:SetOrientation({ 0, 1, 0, 0 }, true)
    elseif (aiBrain:GetFactionIndex() == 2) then
        cdrUnit:ShowBone(0, true)
        cdrUnit:HideBone('Back_Upgrade', true)
        cdrUnit:HideBone('Right_Upgrade', true)
        cdrUnit:HideBone('Left_Upgrade', true)
        cdrUnit:SetOrientation({ 0, 1, 0, 0 }, true)
    elseif (aiBrain:GetFactionIndex() == 3) then
        cdrUnit:ShowBone(0, true)
        cdrUnit:HideBone('Back_Upgrade', true)
        cdrUnit:HideBone('Right_Upgrade', true)
        cdrUnit:HideBone('Back_Upgrade', true)
        cdrUnit:SetOrientation({ 0, 1, 0, 0 }, true)
    elseif (aiBrain:GetFactionIndex() == 4) then
        cdrUnit:ShowBone(0, true)
        cdrUnit:HideBone('Back_Upgrade', true)
        cdrUnit:HideBone('Right_Upgrade', true)
        cdrUnit:HideBone('Left_Upgrade', true)
        cdrUnit:SetOrientation({ 0, 1, 0, 0 }, true)
    else
        WaitSeconds(delay)
        cdrUnit:PlayCommanderWarpInEffect()
    end
end





function ScenarioUtils.CreateResources()

    local markers = ScenarioUtils.GetMarkers()
    local ChangeResourcePosition = false

    for i, army in ListArmies() do
        --LOG(army)

        if (army == "ARMY_5") then
            ChangeResourcePosition = true
        end
    end

    if (ChangeResourcePosition) then

        -- create the resource
        CreateResourceDeposit("Hydrocarbon", 251.5, 22.49, 340.5, 3.00)
        -- create the resource graphic on the map
        CreatePropHPR("/env/common/props/hydrocarbonDeposit01_prop.bp", 251.5, 22.49, 340.5, Random(0, 6.2832), 0, 0)
        -- create the resource icon on the map
        CreateSplat({ 251.5, 22.49, 340.5 }, -- Position
            0, -- Heading (rotation)
            "/env/common/splats/hydrocarbon_marker.dds", -- Texture name for albedo
            6, 6, -- SizeX/Z
            200, -- LOD
            0, -- Duration (0 == does not expire)
            -1, -- army (-1 == not owned by any single army)
            0
        )

        -- create the resource
        CreateResourceDeposit("Mass", 247.5 + 1.00, 22.48, 364.5 + 1.00, 1.00)
        CreatePropHPR("/env/common/props/massDeposit01_prop.bp", 247.5, 22.48, 364.5, Random(0, 360), 0, 0)
        CreateResourceDeposit("Mass", 247.5 + 1.00, 22.48, 364.5 - 1.00, 1.00)
        CreateResourceDeposit("Mass", 247.5 - 1.00, 22.48, 364.5 + 1.00, 1.00)
        CreateResourceDeposit("Mass", 247.5 - 1.00, 22.48, 364.5 - 1.00, 1.00)
        CreateSplat({ 247.5, 22.48, 364.5 }, -- Position
            0, -- Heading (rotation)
            "/env/common/splats/mass_marker.dds", -- Texture name for albedo
            4, 4, -- SizeX/Z
            100, -- LOD
            0, -- Duration (0 == does not expire)
            -1, -- army (-1 == not owned by any single army)
            0
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
            NewResourcePosition = { tblData.position[1] + 3.00, tblData.position[2], tblData.position[3] - 3.00 }
        elseif (tblData.resource and tblData.Hydrocarbon3 == true and ChangeResourcePosition) then
            NewResourcePosition = { tblData.position[1] - 3.00, tblData.position[2], tblData.position[3] + 3.00 }
        elseif (tblData.resource and tblData.Hydrocarbon2 == true and ChangeResourcePosition) then
            NewResourcePosition = { tblData.position[1] + 3.00, tblData.position[2], tblData.position[3] + 3.00 }
        elseif (tblData.resource and tblData.Hydrocarbon1 == true and ChangeResourcePosition) then
            NewResourcePosition = { tblData.position[1] - 3.00, tblData.position[2], tblData.position[3] - 3.00 }
        elseif (tblData.resource and tblData.Mass23 == true and ChangeResourcePosition) then
            posx = -14.00
            posz = -2.00
            NewResourcePosition = { tblData.position[1] + posx, tblData.position[2], tblData.position[3] + posz }
        elseif (tblData.resource and tblData.Mass22 == true and ChangeResourcePosition) then
            posx = 5.50
            posz = 0.00
            NewResourcePosition = { tblData.position[1] + posx, tblData.position[2], tblData.position[3] + posz }
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
            CreateResourceDeposit(tblData.type, NewResourcePosition[1], NewResourcePosition[2], NewResourcePosition[3], tblData.size)
            -- create the resource graphic on the map
            CreatePropHPR(bp, NewResourcePosition[1], NewResourcePosition[2], NewResourcePosition[3], Random(0, 6.2832), 0, 0)
            -- create the resource icon on the map
            CreateSplat(NewResourcePosition, -- Position
                0, -- Heading (rotation)
                albedo, -- Texture name for albedo
                sx, sz, -- SizeX/Z
                lod, -- LOD
                0, -- Duration (0 == does not expire)
                -1, -- army (-1 == not owned by any single army)
                0 -- ???
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
            CreateResourceDeposit(tblData.type, tblData.position[1] + variation + posx, tblData.position[2], tblData.position[3] + variation + posz, tblData.size)
            CreatePropHPR(bp, tblData.position[1] + posx, tblData.position[2], tblData.position[3] + posz, Random(0, 360), 0, 0)
            CreateResourceDeposit(tblData.type, tblData.position[1] + posx + variation, tblData.position[2], tblData.position[3] + posz - variation, tblData.size)
            CreateResourceDeposit(tblData.type, tblData.position[1] + posx - variation, tblData.position[2], tblData.position[3] + posz + variation, tblData.size)
            CreateResourceDeposit(tblData.type, tblData.position[1] + posx - variation, tblData.position[2], tblData.position[3] + posz - variation, tblData.size)
            CreateSplat(NewResourcePosition, -- Position
                0, -- Heading (rotation)
                albedo, -- Texture name for albedo
                sx, sz, -- SizeX/Z
                lod, -- LOD
                0, -- Duration (0 == does not expire)
                -1, -- army (-1 == not owned by any single army)
                0 -- ???
            )
        end
    end
end

local function ShuffleListPartially(list, startingID, endingID, IgnoreList) --Shuffles list, expect list IDs that are on IgnoreList

    local SpawnList = {}
    SpawnList = list
    local DoNothing = 0

    if (endingID > table.getn(SpawnList)) then
        return SpawnList
    else

        for i = startingID, endingID do

            if (IgnoreList ~= nil) then

                for k = 1, table.getn(IgnoreList) do

                    if (i == IgnoreList[k]) then

                        DoNothing = 1
                    end
                end
            end

            if (DoNothing == 0) then

                local RandomIndex = Random(i, endingID)

                if (IgnoreList ~= nil) then


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

local CheckFocusArmy = function()

    if (GetFocusArmy() < 1) then

        SimObjects.GetFocusArmy = function() -- <<<<< Fix to spectating not working. GetFocusArmy must never be < 1

            local aiBrain = GetArmyBrain(OccupiedArmies[1])

            return (aiBrain:GetArmyIndex())
        end
    end
end

StartMission1 = function()
    local HowManyMustSurvive = 0
    local Desc = ""

    if options.allAcusNeedToSurvive() then
        HowManyMustSurvive = cdrUnitCount
        Desc = "Defend against incoming attacks. All ACUs must survive."
    else
        HowManyMustSurvive = 1
        Desc = "Defend against incoming attacks. At least one ACU must survive."
    end


    ScenarioInfo.M1P1 = Objectives.Protect('primary',
        'incomplete',
        "Hold The Line",
        Desc,
        {
            Units = cdrUnitList,
            Timer = nil,
            NumRequired = HowManyMustSurvive,
            MarkUnits = false,
        })

    ScenarioInfo.M1P1:AddResultCallback(function(result)
        if (result == false) then
            ForkThread(OnPlayerDefeat)
        end
    end)
end




CreateWaves = function()
    WaveTable = import('/maps/survival_horde_ee.v0019/src/WaveTable.lua').getWaveTable(
        EnableLane1,
        EnableLane2,
        EnableLane3,
        EnableLane4,
        EnableLane5
    )
end

CreateWaveTableOrders = function()
    local ValidGunshipTargetsA = table.copy(BaseRaidingTargets)
    ShuffleList(ValidGunshipTargetsA)

    WaveOrders = import('/maps/survival_horde_ee.v0019/src/WaveOrders.lua').getWaveTable(
        WaveDelay, -- TODO: move to WaveOrders.lua
        ShuffleList,
        ValidGunshipTargetsA
    )
end

local unitCreator = import('/maps/survival_horde_ee.v0019/src/lib/UnitCreator.lua').newUnitCreator()

if options.getHealthMultiplier() ~= 1 then
    unitCreator.onUnitCreated(function(unit, unitInfo)
        if unitInfo.isSurvivalSpawned then
            unit:SetMaxHealth(unit:GetMaxHealth() * options.getHealthMultiplier())
            unit:SetHealth(unit, unit:GetMaxHealth())
        end
    end)
end

local function createSurvivalUnit(blueprint, x, z, y)
    local unit = unitCreator.spawnSurvivalUnit({
        blueprintName = blueprint,
        armyName = "ARMY_SURVIVAL_ENEMY",
        x = x,
        z = z,
        y = y
    })

    return unit
end

function OnPopulate()
    ScenarioUtils.InitializeArmies()

    local init = function()
        local EnemyCommander = createSurvivalUnit('URL0001', 10, 13.5, -10)
        EnemyCommander:SetDoNotTarget(true)
        EnemyCommander:SetCanBeKilled(false)
        EnemyCommander:SetProductionPerSecondEnergy(90000)
        EnemyCommander:SetConsumptionPerSecondEnergy(0)
        EnemyCommander:SetProductionPerSecondMass(9999)

        ScenarioFramework.SetPlayableArea('AREA_1', false)
        ScenarioInfo.MissionNumber = 1

        SetArmyColor('ARMY_SURVIVAL_ENEMY', 225, 70, 0)
        ScenarioInfo.Options.Victory = 'sandbox'
        SetIgnoreArmyUnitCap('ARMY_SURVIVAL_ENEMY', true)


        ------------------------------------------------------------------------------------------ When there's less than 4 players, spawn additional commanders on empty slots-------------------------------------------------------------------------------
        local UnoccupiedArmies = {}
        local AllArmies = { "ARMY_1", "ARMY_2", "ARMY_3", "ARMY_4", "ARMY_5" }



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

                    elseif (occarmy == "ARMY_3") then

                        EnableLane2 = 1
                        table.insert(BaseRaidingTargets, "PlayerSpawn_2")
                        table.insert(ValidTransportDrops, "TransportDrop04")
                        table.insert(ValidTransportDrops, "TransportDrop01")
                        table.insert(ValidTransportDrops, "TransportDrop02")

                    elseif (occarmy == "ARMY_4") then

                        EnableLane3 = 1
                        table.insert(BaseRaidingTargets, "PlayerSpawn_3")
                        table.insert(ValidTransportDrops, "TransportDrop06")
                        table.insert(ValidTransportDrops, "TransportDrop03")
                        table.insert(ValidTransportDrops, "TransportDrop02")

                    elseif (occarmy == "ARMY_2") then

                        EnableLane4 = 1
                        table.insert(BaseRaidingTargets, "PlayerSpawn_4")
                        table.insert(ValidTransportDrops, "TransportDrop06")
                        table.insert(ValidTransportDrops, "TransportDrop03")

                    elseif (occarmy == "ARMY_5" and table.getn(ListArmies()) > 2) then

                        EnableLane5 = 1
                        table.insert(BaseRaidingTargets, "PatrolBase_5")

                        table.insert(ValidTransportDrops, "TransportDrop05")

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


        ----------------------------- Spawn Destroyer Boss to random, occupied lane
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
    end

    init()

    CreateWaves()
    CreateWaveTableOrders()


    if (EnableLane1 == 1) then
        WaveTable[161] = { 161, 'urs0201', 1 + EnableLane5 }
    elseif (EnableLane2 == 1) then
        WaveTable[163] = { 163, 'urs0201', 1 + EnableLane5 }
    elseif (EnableLane3 == 1) then
        WaveTable[166] = { 166, 'urs0201', 1 + EnableLane5 }
    elseif (EnableLane4 == 1) then
        WaveTable[173] = { 173, 'urs0201', 1 + EnableLane5 }
    elseif (EnableLane5 == 1) then
        WaveTable[169] = { 169, 'urs0201', 1 + EnableLane5 }
    end


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

    for i, army in ListArmies() do -------------------------------------------------------------------------------- Set player alliances and army options


        if (army == "ARMY_1" or army == "ARMY_2" or army == "ARMY_3" or army == "ARMY_4" or army == "ARMY_5") then

            local coms = GetArmyBrain(army):GetListOfUnits(categories.COMMAND, false, false)
            for i, com in coms do
                table.insert(cdrUnitList, com)
            end



            ScenarioFramework.AddRestriction(army, categories.WALL) -- don't allow them to build walls

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
    Sync.CampaignMode = true -- Enables campaign UI. Note that spectator mode doesn't work with campaign mode enabled unless you know how to fix it.

    StartMission1()
end




function OnStart(self)

    ForkThread(Survival_Tick)
end















StartMission2 = function()

    ScenarioInfo.M1P2 = Objectives.Timer('primary',
        'incomplete',
        "Survive Untill Recalled",
        "Survive until HQ can recall your ACU.",
        {
            Timer = 600,
            ExpireResult = 'complete',
        })

    ScenarioInfo.M1P2:AddResultCallback(function(result)
        if (result) then
            --LOG("Timer ran out. Victory here.")
            OnPlayerVictory()
        end
    end)
end


local function IssueStrategicMissile(UnitList, TargetList) --Issue nuke launch
    LOG("====================================================================== Launching nuke |||||||||||||")
    local target = 1
    IssueClearCommands(UnitList)
    for k, unit in UnitList do
        if (unit:BeenDestroyed() == false) then
            if (unit:GetUnitId() == 'urs0304') then
                local POS = TargetList[target]:GetPosition()
                unit:GiveNukeSiloAmmo(1)
                IssueNuke({ unit }, POS)
                if (target < table.getn(TargetList)) then
                    target = target + 1
                else
                    target = 1
                end
            end
        end
    end
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
            {
                Units = UnitList,
                NumRequired = table.getn(UnitList),
                MarkUnits = false,
                ShowProgress = true,
            }
        )

        ScenarioInfo.M1S1:AddResultCallback(function(result)
            if (result == false) then
                UnitList = GetArmyBrain("ARMY_SURVIVAL_ENEMY"):GetListOfUnits(categories.NUKESUB, false, false)
                local NukeTargetUnits = {}
                local PotentialNukeTargetUnits = {}
                for x, army in ListArmies() do
                    if (army == "ARMY_1" or army == "ARMY_2" or army == "ARMY_3" or army == "ARMY_4" or army == "ARMY_5") then
                        PotentialNukeTargetUnits = GetArmyBrain(army):GetListOfUnits(categories.TECH3 - categories.MOBILE - categories.INDIRECTFIRE - categories.DIRECTFIRE - categories.SHIELD - categories.SILO, false, false) --Target t3 pgens, t3 mexes, t3 factories.
                        for k, unit in PotentialNukeTargetUnits do
                            table.insert(NukeTargetUnits, unit)
                        end
                    end
                end
                if (table.getn(NukeTargetUnits) == 0) then
                    for x, army in ListArmies() do
                        if (army == "ARMY_1" or army == "ARMY_2" or army == "ARMY_3" or army == "ARMY_4" or army == "ARMY_5") then
                            PotentialNukeTargetUnits = GetArmyBrain(army):GetListOfUnits(categories.COMMAND, false, false) --If no other targets found, target commanders
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
            end
        end)

    else
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
        IssueClearCommands(GetArmyBrain("ARMY_SURVIVAL_ENEMY"):GetListOfUnits(categories.ALLUNITS, false, false))
        ScenarioFramework.Dialogue(import('/maps/X1CA_004/X1CA_004_strings.lua').X04_M03_270, nil, true) --"You made it!"
        ScenarioFramework.Dialogue(import('/maps/X1CA_001/X1CA_001_strings.lua').TAUNT33, nil, true) --Sera Taunt4
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
    ScenarioFramework.FakeGateInUnit(com) --This effect is the best one.
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

        IssueClearCommands(GetArmyBrain("ARMY_SURVIVAL_ENEMY"):GetListOfUnits(categories.ALLUNITS, false, false))
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
    local cdrUnitListCurrent = cdrUnitList
    local Time = ScenarioInfo.Options.StartTime
    local cdrUnderwater = 0
    local cdrRaiding = 0
    local cdrRaidingDelay = 0
    local HasAirExperimental = 0

    local OncePerTick = math.floor(GetGameTimeSeconds())


    if Time == nil then
        Time = 0
    end



    while (GameHasEnded == 0) do



        local PlatoonList = {}
        local cmdunit = nil
        local GameTime = math.floor(GetGameTimeSeconds())
        local gameTimeMinusSpawnDelay = GameTime - options.getSpawnDelay() + 80


        if (OncePerTick < GameTime) then

            ---------------------------------------------------------------------- DIALOGUE--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

            if GameTime == 15 and options.getSpawnDelay() > 40 then --"Both QAI and HEX are operating in this area" --At the beginning
                ScenarioFramework.Dialogue(import('/maps/X1CA_005/X1CA_005_strings.lua').X05_M01_011, nil, true)
            end

            if gameTimeMinusSpawnDelay == 90 then --"Enemy Units Converging to your position." --Around first waves
                ScenarioFramework.Dialogue(import('/maps/X1CA_002/X1CA_002_strings.lua').X02_M02_090, nil, true) --X02_M02_090
            end

            if gameTimeMinusSpawnDelay == 1170 then
                ScenarioFramework.Dialogue(import('/maps/X1CA_002/X1CA_002_strings.lua').TAUNT25, nil, true) --QAI taunt around 19:30 min mark
            end

            if gameTimeMinusSpawnDelay == 1320 then --Nuke Sub Mission 1320
                StartSecondaryMission1()
            end

            if gameTimeMinusSpawnDelay == 1800 then --Survive Until Recalled
                StartMission2()
            end

            if gameTimeMinusSpawnDelay == 1860 then
                ScenarioFramework.Dialogue(import('/maps/X1CA_005/X1CA_005_strings.lua').TAUNT11, nil, true) --QAI taunt aroun 31 min mark
            end

            if gameTimeMinusSpawnDelay == 2070 then --"Seraphim taunt1"
                ScenarioFramework.Dialogue(import('/maps/X1CA_001/X1CA_001_strings.lua').TAUNT30, nil, true) --Sera Taunt1 34:30 min mark
            end

            if gameTimeMinusSpawnDelay == 2100 then
                if (DontStartNukeObjective == 0) then
                    ScenarioInfo.M1S1:ManualResult(false)
                end
            end

            if gameTimeMinusSpawnDelay == 2405 then --"Wait until extraction." --When the countdown begins
                ScenarioFramework.Dialogue(import('/maps/X1CA_004/X1CA_004_strings.lua').X04_M03_020, nil, true)
            end

            --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

            local aiBrain = GetArmyBrain("ARMY_SURVIVAL_ENEMY")

            ------------------------------------------------------- LAND UNIT IDLE PREVENTER!-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

            local IdleUnitListLand = {}
            local UnitListLand = GetArmyBrain("ARMY_SURVIVAL_ENEMY"):GetListOfUnits(categories.LAND + categories.DESTROYER - categories.COMMAND, true, false)
            local aiBrainLand = GetArmyBrain("ARMY_SURVIVAL_ENEMY")
            local aiPlatoonLand = aiBrainLand:MakePlatoon('', '')


            for k, IdleUnit in UnitListLand do

                if (IdleUnit:IsIdleState()) then
                    table.insert(IdleUnitListLand, IdleUnit)
                end
            end


            if (table.getn(IdleUnitListLand) > 0) then

                aiBrainLand:AssignUnitsToPlatoon(aiPlatoonLand, IdleUnitListLand, 'Attack', 'None')

                aiPlatoonLand:AggressiveMoveToLocation(ScenarioUtils.MarkerToPosition((ShuffleList(LandCenter))[1])) --- - Needs to be aggressive move so they will stop to shoot things
                aiPlatoonLand:AggressiveMoveToLocation(ScenarioUtils.MarkerToPosition(LandCenter[2]))
                aiPlatoonLand:AggressiveMoveToLocation(ScenarioUtils.MarkerToPosition(LandCenter[3]))
                aiPlatoonLand:DisbandOnIdle()
            end


            ------------------------------------------------------------ TORPEDO BOMBER IDLE PREVENTER!---------------------------------------------------------------------------------------------------------------------------------------------------------------------

            local RandomTorpedoRoute = Random(1, table.getn(AllTorpedoRoutes))
            local IdleUnitListTorpedo = {}
            local aiBrain = GetArmyBrain("ARMY_SURVIVAL_ENEMY")
            local UnitListTorpedo = aiBrain:GetListOfUnits(categories.ANTINAVY - categories.LAND - categories.NAVAL - categories.STRUCTURE, false, false)
            local aiPlatoonTorpedo = aiBrain:MakePlatoon('', '')
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


            ------------------------------------------------------------ BOMBER, GUNSHIP, SCOUT AND FIGHTER IDLE PREVENTER!---------------------------------------------------------------------------------------------------------------------------------------------------------------------
            local RandomBomberRoute = 0
            local RandomRoutePicker = 0



            if (cdrRaiding > 0) then
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
            local aiPlatoonBomber = aiBrain:MakePlatoon('', '')
            aiPlatoonBomber:DisbandOnIdle()

            for k, IdleUnit in UnitListBomber do

                if (IdleUnit:IsIdleState() and IdleUnit:GetBlueprint() ~= "dra0202") then
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
            ---------------------------------------------------------- TRANSPORT UNIT IDLE PREVENTER!------------------------------------------------------------------------------------------------------------------------------------------------------------------

            local IdleUnitListTransport = GetArmyBrain("ARMY_SURVIVAL_ENEMY"):GetListOfUnits(categories.TRANSPORTATION, true, false)

            for i, unit in IdleUnitListTransport do
                local TransportPOS = unit:GetPosition()
                local MarkerPOS = ScenarioUtils.MarkerToPosition('Survival_LandSpawn2') --------- Sends used transports to a kill box
                local dist = VDist2(TransportPOS[1], TransportPOS[3], MarkerPOS[1], MarkerPOS[3])

                if (dist <= 10) then
                    unit:Destroy()
                end
            end

            local aiBrainTransport = GetArmyBrain("ARMY_SURVIVAL_ENEMY")
            local aiPlatoonTransport = aiBrainTransport:MakePlatoon('', '')
            local RandomTransportRoute = Random(1, 2)
            aiBrainTransport:AssignUnitsToPlatoon(aiPlatoonTransport, IdleUnitListTransport, 'Attack', 'None')
            ShuffleList(ValidTransportDrops)


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
            IssueMove(aiPlatoonTransport:GetPlatoonUnits(), ScenarioUtils.MarkerToPosition('Survival_LandSpawn2')) --Transporter KillBox

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

                    local coms = GetArmyBrain(army):GetListOfUnits(categories.COMMAND, false, false)
                    local navyT2 = GetArmyBrain(army):GetListOfUnits(categories.NAVAL - categories.TECH3 - categories.TECH1 - categories.EXPERIMENTAL, false, true) --Has Tech2 Naval
                    local navyT3 = GetArmyBrain(army):GetListOfUnits(categories.NAVAL - categories.TECH1 - categories.TECH2, false, true) --Has Tech3 Naval
                    local AirT4 = GetArmyBrain(army):GetListOfUnits(categories.EXPERIMENTAL - categories.LAND - categories.NAVAL - categories.STRUCTURE, false, true)

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
                            elseif (EnableLane1 == 0 and cdrDistLane1 < 45 and cdrPOS[2] >= 20) then
                                AtLeastOneACURaiding = 1
                            elseif (EnableLane2 == 0 and cdrDistLane2 < 45 and cdrPOS[2] >= 20) then
                                AtLeastOneACURaiding = 1
                            elseif (EnableLane3 == 0 and cdrDistLane3 < 60 and cdrPOS[2] >= 20) then
                                AtLeastOneACURaiding = 1
                            elseif (EnableLane4 == 0 and cdrDistLane4 < 50 and cdrPOS[2] >= 20) then
                                AtLeastOneACURaiding = 1
                            end
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
                else
                    cdrRaiding = 4
                    cdrRaidingDelay = 0
                end
            else
                cdrRaidingDelay = 0
            end

            if (cdrRaidingDelay >= 150) then
                cdrRaiding = 4
            end

            if (HasT2Navy == 1) then
                cdrUnderwater = cdrUnderwater + 1
            end

            if (HasT3Navy == 1) then
                cdrUnderwater = cdrUnderwater + 1
            end

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


            ---------------------------------------------------------------------------------- SPAWN UNIT WAVES---------------------------------------------------------------------------------------------------------------------------------------

            for i = 1, table.getn(WaveOrders) do
                local WaveInfo = WaveOrders[i]
                local spawnTime = WaveInfo[3] - 80 + options.getSpawnDelay()

                if (GameTime == spawnTime) then
                    GiveWaveOrders(i, WaveInfo[1], WaveInfo[2], WaveInfo[4])
                end
            end

            ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



            ---------------------------------------------------------------------------------- SPAWN AIR SUPPORT---------------------------------------------------------------------------------------------------------------------------------------

            --Air unit counts grow linearly as GameTime increases

            local NumOfInterceptors = math.floor((10 + (EnableLane1 * 3) + (EnableLane2 * 3) + (EnableLane3 * 3) + (EnableLane4 * 3) + (EnableLane5 * 10)) * GameTime / 1500) --Max 30 interceptors, 960 sec max
            local UnitListInterceptors = aiBrain:GetListOfUnits(categories.ANTIAIR - categories.LAND - categories.NAVAL - categories.STRUCTURE - categories.EXPERIMENTAL - categories.TECH2 - categories.TECH3, false, false)
            local NumOfASF = math.floor((((14 + (EnableLane1 * 3) + (EnableLane2 * 3) + (EnableLane3 * 3) + (EnableLane4 * 3) + (EnableLane5 * 9)) * (GameTime) * (HasAirExperimental + 1)) / (2 * (TotalGameTime - 150))) - 5)
            local UnitListASF = aiBrain:GetListOfUnits(categories.ANTIAIR - categories.LAND - categories.NAVAL - categories.STRUCTURE - categories.EXPERIMENTAL - categories.TECH1 - categories.TECH2, false, false)

            local NumOfT1Bombers = math.floor(((14 + (EnableLane1 * 4) + (EnableLane2 * 4) + (EnableLane3 * 4) + (EnableLane4 * 4) + (EnableLane5 * 15)) * (cdrRaiding + cdrUnderwater + 4) * GameTime) / (1080 * 12))
            local UnitListT1Bombers = (aiBrain:GetListOfUnits(categories.BOMBER - categories.ANTINAVY - categories.EXPERIMENTAL - categories.TECH2 - categories.TECH3, false, false))
            local NumOfT3Bombers = math.floor(((12 * (cdrRaiding + cdrUnderwater + (EnableLane5 * 2)) * GameTime) / ((TotalGameTime - 150) * 10)))
            local UnitListT3Bombers = (aiBrain:GetListOfUnits(categories.BOMBER - categories.ANTINAVY - categories.EXPERIMENTAL - categories.TECH1 - categories.TECH2, false, false))

            local NumOfT1Gunships = math.floor((12 * GameTime * cdrRaiding) / (960 * 4))
            local UnitListT1Gunships = aiBrain:GetListOfUnits(categories.GROUNDATTACK - categories.TRANSPORTATION - categories.LAND - categories.NAVAL - categories.STRUCTURE - categories.EXPERIMENTAL - categories.TECH2 - categories.TECH3, false, false)
            local NumOfT2Gunships = math.floor(((28 * cdrRaiding * GameTime) / (1740 * 4)) - 12)
            local UnitListT2Gunships = aiBrain:GetListOfUnits(categories.GROUNDATTACK - categories.TRANSPORTATION - categories.LAND - categories.NAVAL - categories.STRUCTURE - categories.EXPERIMENTAL - categories.TECH1 - categories.TECH3, false, false)
            local NumOfT3Gunships = math.floor(((35 * cdrRaiding * GameTime) / ((TotalGameTime - 150) * 4) - 20))
            local UnitListT3Gunships = aiBrain:GetListOfUnits(categories.GROUNDATTACK - categories.TRANSPORTATION - categories.LAND - categories.NAVAL - categories.STRUCTURE - categories.EXPERIMENTAL - categories.TECH1 - categories.TECH2, false, false)

            local NumOfTorpedoBombers = math.floor(((70 * cdrUnderwater * GameTime) / ((TotalGameTime - 150) * 4)) - 10)
            local UnitListTorpedoBombers = aiBrain:GetListOfUnits(categories.ANTINAVY - categories.LAND - categories.NAVAL - categories.STRUCTURE - categories.EXPERIMENTAL, false, false)

            local NumOfT1Scouts = math.floor((10 + (EnableLane5 * 8)) * GameTime / 1380)
            local UnitListT1Scouts = aiBrain:GetListOfUnits(categories.INTELLIGENCE - categories.LAND - categories.NAVAL - categories.STRUCTURE - categories.EXPERIMENTAL - categories.TECH2 - categories.TECH3, false, false)
            local NumOfT3Scouts = math.floor(((20 + (EnableLane5 * 5)) * (cdrUnderwater + 4) * GameTime / (8 * (TotalGameTime - 150)) - 5))
            local UnitListT3Scouts = aiBrain:GetListOfUnits(categories.INTELLIGENCE - categories.LAND - categories.NAVAL - categories.STRUCTURE - categories.EXPERIMENTAL - categories.TECH1 - categories.TECH2, false, false)

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
                if (table.getn(UnitListT1Bombers) <= math.floor(NumOfT1Bombers * 1 / 2)) then
                    CreateUnitGroup('ura0103', (ShuffleList(AllEnemySpawns))[1], NumOfT1Bombers - table.getn(UnitListT1Bombers))
                end
            elseif (GameTime >= 1680 - (EnableLane5 * 180)) then
                if (table.getn(UnitListT3Bombers) <= math.floor(NumOfT3Bombers * 1 / 2)) then
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
                if (table.getn(UnitListT3Bombers) <= math.floor(NumOfT3Bombers * 2 / 3)) then
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




            ----------------------------------------------------------------------------------- GAME ENDING COUNTDOWN--------------------------------------------------------------------
            if (GameHasEnded == 0 and math.floor(TotalGameTime - GameTime) == 10) then
                ScenarioFramework.Dialogue(import('/maps/X1CA_004/X1CA_004_strings.lua').X04_M03_250, nil, true) --"Almost there..."
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

        WaitSeconds(0.25) --"Tick Rate" of this while loop
    end
end




function GetMarker(MarkerName)
    return Scenario.MasterChain._MASTERCHAIN_.Markers[MarkerName] --Get markers by their name
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
            IssueMove({ unit }, { POS[1] + RandomX, POS[2], POS[3] + RandomY })
        end
    end
end




GiveAssistOrder = function(aiPlatoon, WaveID, TargetType)
    local CurrentWave = WaveTable[WaveID]
    local UnitList = CurrentWave[1]

    UnitList = ShuffleList(UnitList) --ERROR: Unit Has Been Destroyed
    for i, unit in UnitList do

        if (unit:BeenDestroyed() == false) then
            if (unit:GetUnitId() == TargetType) then
                IssueGuard(aiPlatoon:GetPlatoonUnits(), UnitList[i])
            end
        end
    end
end




GiveTransportOrder = function(aiPlatoon, Quantity, techlevel)
    local UnitList = {}
    local POS = aiPlatoon:GetPlatoonPosition()

    for i = 1, Quantity do
        local NewUnit = createSurvivalUnit(
            techlevel == "Tech1" and 'ura0107' or 'ura0104',
            POS[1] + ((Random(-50, 50) / 15)),
            POS[2],
            POS[3] + ((Random(-50, 50) / 15))
        )

        NewUnit:SetProductionPerSecondEnergy(2500)
        NewUnit:SetConsumptionPerSecondEnergy(0)
        NewUnit:SetProductionPerSecondMass(50)
        table.insert(UnitList, NewUnit)
    end

    ScenarioFramework.AttachUnitsToTransports(aiPlatoon:GetPlatoonUnits(), UnitList)
end




UnloadTransport = function(aiPlatoon, marker)
    IssueTransportUnload(
        aiPlatoon:GetPlatoonUnits(),
        ScenarioUtils.MarkerToPosition(marker)
    )
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
    local UnitList = aiPlatoon:GetPlatoonUnits()

    for k, unit in UnitList do
        if (unit:BeenDestroyed() == false) then
            if (unit:GetUnitId() == UnitID) then
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





GiveWaveOrders = function(WaveOrderNumber, WaveID, SpawnPoint, Formation)
    local WaveInfo = WaveOrders[WaveOrderNumber]
    local platoon = CreateWaveID(WaveID, SpawnPoint, Formation)

    if (platoon == nil) then
        return
    end

    for i = 0, (table.getn(WaveInfo) - 4 - 3 / 3) do
        local r = 3 * i + 4

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
        end
    end
end








CreateWaveID = function(ID, SpawnPoint, Formation)
    local strSpawnPoint = ""
    strSpawnPoint = SpawnPoint
    local strFormation = ''
    strFormation = Formation


    local UnitList = {}
    local CurrentWave = WaveTable[ID]
    local POS = GetMarker(SpawnPoint).position

    if (WaveTable[ID] == "NULL") then
        return nil
    else
        for k = 0, ((table.getn(CurrentWave) - 2 - 1) / 2) do
            local r = 2 * k + 1

            for i = 1, CurrentWave[2 + r] do
                local NewUnit = createSurvivalUnit(
                    CurrentWave[1 + r],
                    POS[1] + (Random(-45, 45) / 10),
                    POS[2],
                    POS[3] + (Random(40, 45) / 15)
                )

                NewUnit:EnableIntel('RadarStealth')
                NewUnit:EnableIntel('Jammer')
                NewUnit:EnableIntel('RadarStealthField')
                NewUnit:EnableIntel('SonarStealth')
                NewUnit:EnableIntel('SonarStealthField')
                table.insert(UnitList, NewUnit)
            end
        end


        local aiBrain = GetArmyBrain("ARMY_SURVIVAL_ENEMY")
        local aiPlatoon = aiBrain:MakePlatoon('', '')
        aiBrain:AssignUnitsToPlatoon(aiPlatoon, UnitList, 'Attack', strFormation)

        CurrentWave[1] = UnitList
        WaveTable[ID] = CurrentWave
        return aiPlatoon
    end
end

CreateUnitGroup = function(Blueprint, SpawnPoint, Quantity) --Used to creating enemy units outside the wave table

    local strBluePrint = ''
    strBluePrint = Blueprint
    local POS = GetMarker(SpawnPoint).position
    for i = 1, Quantity do
        local NewUnit = createSurvivalUnit(
            Blueprint,
            POS[1] + ((Random(-110, 110) / 10)),
            POS[2],
            POS[3] + ((Random(-50, 50) / 15))
        )

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


local function newAirwingSpawner()
    local mapSizeX, mapSizeY = GetMapSize()
    return import('/maps/survival_horde_ee.v0019/src/lib/AirwingSpawner.lua').newInstance(mapSizeX, mapSizeY, "ARMY_SURVIVAL_ENEMY")
end

local textPrinter = import('/maps/survival_horde_ee.v0019/src/lib/TextPrinter.lua').newInstance()

ForkThread(function()
    if options.airWavesAreEnabled() then
        local airwings = import('/maps/survival_horde_ee.v0019/src/Airwings.lua').newInstance(
            newAirwingSpawner(),
            textPrinter,
            TotalGameTime
        )

        airwings.init()
    end
end)

local function setupAutoReclaim()
    local percentage = options.getAutoReclaimPercentage()

    if percentage > 0 then
        unitCreator.onUnitCreated(function(unit, unitInfo)
            if unitInfo.isSurvivalSpawned then
                unit.CreateWreckage = function() end
            end
        end)

        ForkThread(
            import('/maps/survival_horde_ee.v0019/src/lib/AutoReclaim.lua').AutoResourceThread,
            percentage / 100,
            percentage / 100
        )
    end
end

setupAutoReclaim()

local welcomeMessages = import('/maps/survival_horde_ee.v0019/src/WelcomeMessages.lua').newInstance(
    textPrinter,
    options,
    ScenarioInfo.map_version
)

welcomeMessages.startDisplay()