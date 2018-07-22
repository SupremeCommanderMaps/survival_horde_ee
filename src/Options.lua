local function defaultOptions(scenarioOptions)
    local optionDefaults = {
        opt_defeat_conditions = 1,
        opt_HordeSpawnDelay = 80,
        opt_HordeHealthMultiplier = 1,
        opt_HordeAutoReclaim = 0,
        opt_HordeAirWaves = 1
    }

    for optionName, defaultValue in pairs(optionDefaults) do
        if (scenarioOptions[optionName] == nil) then
            scenarioOptions[optionName] = defaultValue
        end
    end

    return scenarioOptions
end

function newInstance(ScenarioInfoOptions)
    local rawOptions = defaultOptions(ScenarioInfoOptions)
    local this = {}

    this.getSpawnDelay = function()
        return rawOptions.opt_HordeSpawnDelay
    end

    this.allAcusNeedToSurvive = function()
        return rawOptions.opt_defeat_conditions == 2
    end

    this.getAutoReclaimPercentage = function()
        return rawOptions.opt_HordeAutoReclaim
    end

    this.airWavesAreEnabled = function()
        return rawOptions.opt_HordeAirWaves == 1
    end

    this.getHealthMultiplier = function()
        return rawOptions.opt_HordeHealthMultiplier
    end

    return this
end