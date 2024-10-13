-- This program is used for the pocket computer
if not rednet.isOpen() then
    rednet.open("back")
end
 
print("Rednet Receiver started. Listening for messages...")
 
local turtles = {}
 
-- Function to update the screen on the pocket computer
local function updateScreen()
    term.clear()
    term.setCursorPos(1, 1)
    print("Turtles:")
    print("ID | Status")
    print("---------------")
    for id, message in pairs(turtles) do
        io.write(id .. " | " .. message)
    end
end
updateScreen()
 
-- Function to listen for rednet messages
local function rednetListener()
    while true do
        -- Wait for a message
        local senderId, message, protocol = rednet.receive()
        turtles[senderId] = message
 
        updateScreen()
    end
end
 
-- Function to refresh the screen when the user touches the pocket computer screen
local function pocketClickListener()
    while true do
        -- Detect when the user interacts with the pocket computer screen
        local event, side = os.pullEvent("mouse_click")
        updateScreen()
    end
end
 
-- Run both functions in parallel
parallel.waitForAll(rednetListener, pocketClickListener)