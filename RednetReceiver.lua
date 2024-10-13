local modemSide = arg[1]
local monitorSide = arg[2]

if not modemSide or not monitorSide then
    print("Usage: RednetReceiver <modemSide> <monitorSide>")
    return
end

-- Open the modem
monitor = peripheral.wrap(monitorSide)
rednet.open(modemSide)

print("Rednet Receiver started. Listening for messages...")

local turtles = {}
local function updateScreen()
    monitor.clear()
    monitor.setCursorPos(1, 1)
    monitor.write("Turtles:")
    monitor.setCursorPos(1, 2)
    monitor.write("ID | Status")
    monitor.setCursorPos(1, 3)
    monitor.write("---------------")
    monitor.setCursorPos(1, 4) -- Add a line of space
    local line = 5 -- Start from the next line after the space
    for id, message in pairs(turtles) do
        monitor.setCursorPos(1, line)
        monitor.write(id .. " | " .. message)
        line = line + 1 -- Move to the next line for the next turtle
    end
end
updateScreen()

while true do
    -- Wait for a message
    
    local senderId, message, protocol = rednet.receive()
    turtles[senderId] = message
    
    
    print("Turtle id: " .. senderId .. " | Message: " .. message .. " | Protocol: " .. protocol)
    updateScreen()
end

