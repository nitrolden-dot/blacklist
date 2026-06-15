if not game:IsLoaded() then game.Loaded:Wait() end


local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer
local placeId = game.PlaceId

function missing(t, f, fallback)
	if type(f) == t then return f end
	return fallback
end


queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/nitrolden-dot/blacklist/refs/heads/main/lo.luau'))()")

local Filter = {
    "Legendary",
    "Mythic",
    "Super"
}

local Plots = {
    "Plot1",
    "Plot2",
    "Plot3",
    "Plot4",
    "Plot5",
    "Plot6",
    "Plot7",
    "Plot8"
}

local Raritys = {
    ["Carrot"] = "Common",
    ["Strawberry"] = "Common",
    ["Blueberry"] = "Common",
    ["Tulip"] = "Uncommon",
    ["Tomato"] = "Uncommon",
    ["Apple"] = "Uncommon",
    ["Bamboo"] = "Rare",
    ["Corn"] = "Rare",
    ["Cactus"] = "Rare",
    ["Pineapple"] = "Rare",
    ["Mushroom"] = "Epic",
    ["Green Bean"] = "Epic",
    ["Banana"] = "Epic",
    ["Grape"] = "Epic",
    ["Coconut"] = "Epic",
    ["Mango"] = "Epic",
    ["Dragon Fruit"] = "Legendary",
    ["Acorn"] = "Legendary",
    ["Cherry"] = "Legendary",
    ["Sunflower"] = "Legendary",
    ["Poison Ivy"] = "Legendary",
    ["Venus Fly Trap"] = "Mythic",
    ["Pomegranate"] = "Mythic",
    ["Poison Apple"] = "Mythic",
    ["Ghost Pepper"] = "Mythic",
    ["Moon Bloom"] = "Super",
    ["Dragon's Breath"] = "Super"
}

local Good = {}

for plotnum, garden in ipairs(workspace.Gardens:GetChildren()) do 
    if table.find(Plots, garden.Name) then
        print("Looking at "..garden.Name)
        for plantnum, plant in ipairs(garden.Plants:GetChildren()) do
            if plant:GetAttribute("SeedName") then
                print(garden.Name.." Contains: "..plant:GetAttribute("SeedName"))
                local rarity = Raritys[plant:GetAttribute("SeedName")]
                if rarity then
                    if table.find(Filter, rarity) then
                        table.insert(Good, "Found: "..rarity.." "..plant:GetAttribute("SeedName"))
                    end
                end
            end
        end
    end
end

print("Done")

for i = 1, 5000 do
    print(string.rep(" ", i%2))
end

if #Good == 0 then
    	local success, result = pcall(function()

		return HttpService:JSONDecode(game:HttpGet(

			"https://games.roblox.com/v1/games/"..placeId.."/servers/Public?sortOrder=Asc&limit=100"

		))

	end)

	if success and result and result.data and #result.data > 0 then

		local validServers = {}

		for _, server in ipairs(result.data) do

			if server.id ~= game.JobId and server.playing < server.maxPlayers then

				table.insert(validServers, server)

			end

		end

		if #validServers > 0 then

			local chosen = validServers[math.random(1, #validServers)]

			TeleportService:TeleportToPlaceInstance(placeId, chosen.id, player)

			return

		end

	end
else
    print("\n"..table.concat(Good, "\n"))
end

local TeleportCheck = false
Players.LocalPlayer.OnTeleport:Connect(function(State)
    if (not TeleportCheck) then
        TeleportCheck = true
    end
end)
