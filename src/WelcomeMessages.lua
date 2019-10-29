newInstance = function(textPrinter, options, mapVersion)
    local WELCOME_MESSAGE_DURATION = 25

    local function displayWeclome()
        local headerOptions = { color = "ff5599ff", duration = WELCOME_MESSAGE_DURATION, location = "leftcenter", size = 35 }
        local versionOptions = { color = "ff5599ff", duration = WELCOME_MESSAGE_DURATION, location = "leftcenter" }
        local textOptions = { color = "ff3377cc", duration = WELCOME_MESSAGE_DURATION, location = "leftcenter" }

        textPrinter.print(string.rep(" ", 12) .. "Welcome to Survival Horde", headerOptions)
        textPrinter.print(string.rep(" ", 34) .. "Entropy Edition, version " .. mapVersion, versionOptions)
        textPrinter.printBlankLine(textOptions)
        textPrinter.printBlankLine(textOptions)
        textPrinter.print(string.rep(" ", 20) .. "Enemies spawn in " .. options.getSpawnDelay() .. " seconds", textOptions)
        textPrinter.print(string.rep(" ", 20) .. "Enemy health: " .. (options.getHealthMultiplier() * 100) .. "%", textOptions)

        textPrinter.print(string.rep(" ", 20) .. "Survival nukes: off", textOptions)

        textPrinter.print(
            string.rep(" ", 20) .. "Auto reclaim: " ..
                    (
                    options.getAutoReclaimPercentage() == 0
                            and "off"
                            or (options.getAutoReclaimPercentage() .. "%")
                    ),
            textOptions
        )
    end

    return {
        startDisplay = function()
            ForkThread(function()
                displayWeclome()
            end)
        end
    }
end