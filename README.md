# 1. Setup

The setup is basic, just do the following.
```
local MyHookFunctions = loadstring(game:HttpGet("https://raw.githubusercontent.com/Itzmrchicken/MyHook/refs/heads/main/MyHookFunctions.lua"))()
local Hook1 = MyHookFunctions.new("your-webhook-url")
```

# 2. Functions

Setup your webhook with the library
```
local Hook1 = MyHookFunctions.new("your-webhook-url")
```

Set the webhooks username
```
local Hook1 = MyHookFunctions.new("your-webhook-url")
Hook1:SetDefaultUsername("new-username")
```

Send a message using the webhook
```
local Hook1 = MyHookFunctions.new("your-webhook-url")
Hook1:SendMessage("your-message")
```

Create an embed
```
local Hook1 = MyHookFunctions.new("your-webhook-url")
local Embed1 = Hook1.NewEmbed(Hook1)
```

Change embed data
```
local Hook1 = MyHookFunctions.new("your-webhook-url")
local Embed1 = Hook1.NewEmbed(Hook1)

Embed1:SetTitle("your-title")
Embed1:SetDescription("your-description")
Embed1:AddField("field-name", "field-description", inline -> true/false)
Embed1:SetFooter("your-footer-text")
Embed1:SetFooterImage("your-footer-image-url")
```

Send embed
```
local Hook1 = MyHookFunctions.new("your-webhook-url")
local Embed1 = Hook1.NewEmbed(Hook1)

Embed1:SendEmbed()
```
