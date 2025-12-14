local NoSee = {}
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local function hideChar(char)
    for _,v in ipairs(char:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Transparency = 1
            v.CanCollide = false
        elseif v:IsA("Decal") then
            v.Transparency = 1
        end
    end
end

function NoSee.Enable()
    pcall(function()
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
    end)

    for _,plr in ipairs(Players:GetPlayers()) do
        if plr ~= Players.LocalPlayer then
            if plr.Character then hideChar(plr.Character) end
            plr.CharacterAdded:Connect(hideChar)
        end
    end

    Players.PlayerAdded:Connect(function(plr)
        if plr ~= Players.LocalPlayer then
            plr.CharacterAdded:Connect(hideChar)
        end
    end)
end

return NoSee