local Webhook = {}
local HttpService = game:GetService("HttpService")

local WEBHOOK_URL = "PUT_WEBHOOK_HERE"

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