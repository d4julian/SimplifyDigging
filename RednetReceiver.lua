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
    monitor.write("ID | Checkpoint")
    monitor.setCursorPos(1, 3)
    monitor.write("---------------")
    for id, checkpoint in pairs(turtles) do
        monitor.setCursorPos(1, 3 + id)
        monitor.write(id .. " | " .. checkpoint)
    end
end
updateScreen()

while true do
    -- Wait for a message
    
    local senderId, message, protocol = rednet.receive()
    turtles[senderId] = message
    
    
    print("Turtle id: " .. senderId .. " | Message: " .. message .. " | Protocol: " .. protocol .. "\n")
    updateScreen()
end

