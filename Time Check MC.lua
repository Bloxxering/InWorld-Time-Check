while true do
    -- Function to set redstone
    function signal(value, shut, on)
        if value >= shut and value < on then
            redstone.setOutput("back", true)
        else
            redstone.setOutput("back", false)
        end
    end

    -- Monitor Adjustment
    local monitor = peripheral.wrap("left")
    monitor.setTextScale(0.5)
    local x, y = monitor.getSize()
    local localTime = textutils.formatTime(os.time("local")) -- Get current time in PST
    local timeValue = os.time("local") -- Current time in decimal (# of hours past midnight)
    local shutoff = 0.75 -- Threshold time for shutoff of generators (4AM EST)
    local enabled = 19.5 -- Threshold time to turn on generators (11 PM EST)
    term.clear()
    term.setCursorPos(1,1)
    term.setTextColor(colors.white)
    
    -- Group of Text to print
    print("Current: "..localTime.." PST")
    print("Shutoff - "..textutils.formatTime(shutoff).." PST")
    print("Enabled - "..textutils.formatTime(enabled).." PST")

    term.setTextColor(colors.yellow)
    print("This automated shutoff can be overwritten by switching the lever")
    print("")
    print("Auto Shutoff is: ")
    if redstone.getInput("bottom") then -- If lever is ON
        signal(timeValue, shutoff, enabled)
        term.setTextColor(colors.green)
        print("ENABLED")
        term.setTextColor(colors.white)
    else -- If lever is OFF
        redstone.setOutput("back", false)
        term.setTextColor(colors.red)
        print("DISABLED")
        term.setTextColor(colors.white)
    end
    sleep(1)
end