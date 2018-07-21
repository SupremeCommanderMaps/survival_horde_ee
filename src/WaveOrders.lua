getWaveTable = function(WaveDelay, ShuffleList, ValidGunshipTargetsA)
    local LandWaypoints1 = {"R1Path01", "R1Path02", "R1Path03", "R1Path04", "R1Path05", "PlayerSpawn_1"}
    local LandWaypoints2 = {"R2Path01", "R2Path02", "R2Path03", "R2Path04", "R2Path05", "PlayerSpawn_2"}
    local LandWaypoints3 = {"R3Path01", "R3Path02", "R3Path03", "R3Path04", "R3Path05", "PlayerSpawn_3"}
    local LandWaypoints4 = {"R4Path01", "R4Path02", "R4Path03", "R4Path04", "R4Path05", "PlayerSpawn_4"}

    local LandWaypoints1Form = {"R1Path01Form", "R1Path02Form", "PlayerSpawn_1"}
    local LandWaypoints2Form = {"R2Path05", "PlayerSpawn_2"}
    local LandWaypoints3Form = {"R3Path02", "R3Path05", "PlayerSpawn_3"}
    local LandWaypoints4Form = {"R4Path02", "PlayerSpawn_4" }

    local NavyLocation = {"BattleshipSpot1" }

    local AllTransportSpawns = {"Survival_LandSpawn1", "Survival_LandSpawn3", "Survival_LandSpawn4", "Survival_Spawn1", "Survival_Spawn4" }

    local LandWaypoints5Destroyer = {"R1Path03", "R1Path04", "R1Path05", "PlayerSpawn_1"}
    local LandWaypoints6Destroyer = {"R3Path05", "PlayerSpawn_3"}
    local LandWaypoints7DestroyerA = {"R4Path01", "R4Path02", "R4Path03", "R4Path04", "DestroyerSpot1"}
    local LandWaypoints7DestroyerB = {"R4Path01", "R4Path02", "R4Path03", "R4Path04", "DestroyerSpot1", "DestroyerSpot2"}
    local LandWaypoints7DestroyerC = {"R4Path01", "R4Path02", "R4Path03", "R4Path04", "DestroyerSpot1", "DestroyerSpot2", "DestroyerSpot3"}
    local LandWaypoints7DestroyerAEnd = {"DestroyerSpot2", "DestroyerSpot3"}
    local LandWaypoints7DestroyerBEnd = {"DestroyerSpot3", "DestroyerSpot2", "DestroyerSpot1"}
    local LandWaypoints7DestroyerCEnd = {"DestroyerSpot2", "DestroyerSpot1", "DestroyerSpot2"}

    return  {

        -- {
        --  WaveID, SpawnPoint, GameTime, Formation
        --  order name, order argument 1, order argument 2, etc
        --  optional second order, argument 1, argument 2, etc
        -- }

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