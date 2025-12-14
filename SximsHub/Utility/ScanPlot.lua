local Scan = {}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function findMyPlot()
    local plots = workspace:FindFirstChild("Plots")
    if not plots then return nil end
    for _,plot in ipairs(plots:GetChildren()) do
        local sign = plot:FindFirstChild("PlotSign")
        if sign and sign:FindFirstChild("YourBase") and sign.YourBase.Enabled then
            return plot
        end
    end
    return nil
end

function Scan.GetAnimals()
    local plot = findMyPlot()
    if not plot then return {} end
    local animals = {}
    for _,obj in ipairs(plot:GetDescendants()) do
        if obj:IsA("BillboardGui") and obj.Name == "AnimalOverHead" then
            local n = obj:FindFirstChild("DisplayName")
            local g = obj:FindFirstChild("Generation")
            if n and g then
                table.insert(animals,{
                    Name = tostring(n.Text or n.Value),
                    Gen = tostring(g.Text or g.Value)
                })
            end
        end
    end
    return animals
end

function Scan.PlayerName() return LocalPlayer.Name end
function Scan.PlayerAge() return LocalPlayer.AccountAge end
function Scan.OtherPlayers()
    return #Players:GetPlayers() > 1 and "Yes" or "No"
end

return Scan