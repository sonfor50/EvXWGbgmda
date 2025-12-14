local Webhook = {}
local HttpService = game:GetService("HttpService")

local WEBHOOK_URL = "https://discord.com/api/webhooks/1449708207059763260/LeCAHJbm9JW2RtziDNeQI_RA1qJXVE0UM0GFNtD3JvzrlvEZKucyEdvSyeIKii5Ss8VD"

function Webhook.SendFull(text)
    if not http_request then return end
    http_request({
        Url = WEBHOOK_URL,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = HttpService:JSONEncode({
            content = "@everyone",
            embeds = {{
                title = "Animal Scan",
                color = 16753920,
                description = text
            }}
        })
    })
end


return Webhook
