newInstance = function(mapSizeX, mapSizeY, armyName)
    local function newUnitSpawner(blueprintName, isAgressive)
        local spawnEffect = function(unit)
            unit:PlayUnitSound('TeleportStart')
            unit:PlayUnitAmbientSound('TeleportLoop')
            WaitSeconds( 0.1 )
            unit:PlayTeleportInEffects()
            WaitSeconds( 0.1 )
            unit:StopUnitAmbientSound('TeleportLoop')
            unit:PlayUnitSound('TeleportEnd')
        end

        local spawnOutEffect = function(unit)
            unit:PlayUnitSound('TeleportStart')
            unit:PlayUnitAmbientSound('TeleportLoop')
            WaitSeconds( 0.1 )
            unit:PlayTeleportInEffects()
            WaitSeconds( 0.1 )
            unit:StopUnitAmbientSound('TeleportLoop')
            unit:PlayUnitSound('TeleportEnd')
            unit:Destroy()
        end

        local function spawnOutOnceDestinationReached(unit, yLimit)
            ForkThread(function()
                while unit:GetPosition().z < yLimit do
                    WaitSeconds(0.5)
                end

                spawnOutEffect(unit)
            end)
        end

        return {
            spawn = function(x, y)
                local yawInRadians = 0

                local unit = CreateUnitHPR(
                    blueprintName,
                    armyName,
                    x,
                    25.9844,
                    y,
                    0,
                    yawInRadians or 0,
                    0
                )

                unit:SetSpeedMult(0.5)

                ForkThread(spawnEffect, unit)

                if isAgressive then
                    IssueAggressiveMove({unit}, VECTOR3(x, 80, mapSizeY - 10))
                    IssueMove({unit}, VECTOR3(x, 80, mapSizeY - 10))
                else
                    IssueMove({unit}, VECTOR3(x, 80, mapSizeY - 10))
                end

                spawnOutOnceDestinationReached(unit, mapSizeY - 11)

                return unit
            end
        }
    end

    local function newWingSpawner(unitSpanwer, wingRadius)
        return {
            spawnWing = function(x, y)
                local units = {}

                table.insert(units, unitSpanwer.spawn(x, y))

                for i = 1, wingRadius - 1 do
                    table.insert(units, unitSpanwer.spawn(-2 * i + x, -i + y))
                    table.insert(units, unitSpanwer.spawn(2 * i + x, -i + y))
                end

                return units
            end
        }
    end

    local function newWingRowSpawner(unitSpanwer)
        return {
            spawnWings = function(options)
                local options = {
                    x = options.x or mapSizeX / 2,
                    y = options.y or -10,
                    wingRadius = options.wingRadius or 5,
                    formationRadius = options.formationRadius or mapSizeY / ( 10 * ( options.wingRadius or 5 ) ),
                    sparseness = options.sparseness or 1
                }

                local wingSpawner = newWingSpawner(unitSpanwer, options.wingRadius)

                wingSpawner.spawnWing(options.x, options.y)

                for i = 1, options.formationRadius - 1 do
                    if math.mod(i, options.sparseness) == 0 then
                        local y = math.mod(i, 2) == 0 and options.y or options.y - 5
                        wingSpawner.spawnWing(options.x + i * options.wingRadius * 5, y)
                        wingSpawner.spawnWing(options.x - i * options.wingRadius * 5, y)
                    end
                end
            end
        }
    end

    return {
        spawn = function(blueprint, isAgressive, options)
            local unitSpanwer = newUnitSpawner(blueprint, isAgressive)
            local wingRowSpawner = newWingRowSpawner(unitSpanwer)
            wingRowSpawner.spawnWings(options)
        end
    }
end

