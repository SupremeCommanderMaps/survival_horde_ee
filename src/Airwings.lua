newInstance = function(spawner, textPrinter, TotalGameTime)
    local function spawnWelcomeShow()
        ForkThread(function()
            spawner.spawn("uea0302", false, {y = 15})
            WaitSeconds(2)
            spawner.spawn("uea0303", false, {y = 15})
            WaitSeconds(2)
            spawner.spawn("uea0304", false, {y = 50})
        end)
    end

    local function spawnT2Bombers(delayInSeconds)
        ForkThread(function()
            WaitSeconds(delayInSeconds)

            textPrinter.print("Enemy bombers detected!")

            WaitSeconds(10)

            spawner.spawn("uea0302", false, {y = 15})
            WaitSeconds(2)
            spawner.spawn("uea0303", false, {y = 15})
            WaitSeconds(2)
            spawner.spawn("dra0202", true, {y = 25, wingRadius = 3})
            WaitSeconds(2)
            spawner.spawn("dra0202", true, {y = 25, wingRadius = 3})
        end)
    end

    local function spawnStrategicBombers(delayInSeconds)
        ForkThread(function()
            WaitSeconds(delayInSeconds)

            textPrinter.print("Enemy strategic bombers detected!")

            WaitSeconds(20)

            spawner.spawn("uea0303", false, {y = 15})
            WaitSeconds(2)
            spawner.spawn("uea0304", true, {y = 15, sparseness = 3, wingRadius = 3})
            WaitSeconds(2)
            spawner.spawn("uea0303", true, {y = 15})
            WaitSeconds(20)
            spawner.spawn("uea0304", true, {y = 15, sparseness = 5, wingRadius = 2})
        end)
    end

    return {
        init = function()
            spawnWelcomeShow()
            spawnT2Bombers(TotalGameTime - 910)
            spawnStrategicBombers(TotalGameTime - 140)
        end
    }
end

