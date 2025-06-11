
local HTTPService = game:GetService("HttpService")

-- local Data = {}

if type(request) == "function" then
else
	warn(identify.." doesn't support 'request' function. Find an executor that does in order to use this library.")

	return
end

local MyHookFunctions = {}
MyHookFunctions.__index = MyHookFunctions

local function GetWebhookURLData(WebhookURL)
	local Split = WebhookURL:split("/")
	
	local ID, Token = Split[6], Split[7]

	if not ID then warn("WebhookURL Data Extraction: No ID found. Check your webhook") end
	if not Token then warn("WebhookURL Data Extraction: No Token found. Check your webhook") end

	return ID, Token
end
local function GetWebhookData(WebhookURL)
	local success, response = pcall(function()
		return request({
			Url = WebhookURL,
			Method = "GET"
		})
	end)

	if success then
		if response and response.StatusCode == 200 then
			return response.Body
		end
	else
		warn("Webhook Data Extration: Something went wrong!", response)
	end
end

function MyHookFunctions.new(WebhookURL)
	local self = setmetatable({}, MyHookFunctions)

	local ID, Token = GetWebhookURLData(WebhookURL)
	local WebhookData = GetWebhookData(WebhookURL)
	
	self.WebhookURL = WebhookURL
	self.DefaultUsername = "MyHook"
	self.WebhookData = WebhookData

	self.WebhookSecrets = {}
	self.WebhookSecrets.WebhookID = ID or 0
	self.WebhookSecrets.WebhookToken = Token or ""

	print("MyHook Status: Successfully created webhook data!")

	return self
end

function MyHookFunctions:SetDefaultUsername(Username: string)
	if not Username then warn("Attempt to set Default Username: No username provided, setting back to original...") self.DefaultUsername = self.WebhookData.name end

	self.DefaultUsername = Username
end

function MyHookFunctions:SendMessage(Message: string)
	local DatatoSend = HTTPService:JSONEncode({
		content = Message,
		username = (self.DefaultUsername ~= "" and self.DefaultUsername) or nil
	})

	local success, response = pcall(function()
		return request({
			Url = self.WebhookURL,
			Method = "POST",
			Headers = {
				["Content-Type"] = "application/json"
			},

			Body = DatatoSend
		})
	end)

	if success then
		if response and response.StatusCode and response.StatusCode == 204 then
			print("MyHook Send Message Status: Successfully sent webhook message", response.StatusCode)
		elseif response.StatusCode == 429 then
			warn("MyHook Send Message Status: Slow down, your sending to many requests at once!", response.StatusCode)
		else
			warn("MyHook Send Message Status: Something went wrong! Status Code: "..response.StatusCode, response)
		end
	else
		warn("MyHook Send Message Status: Something went wrong", response)
	end
end
function MyHookFunctions.NewEmbed()
	local EmbedFunctions = {}
	EmbedFunctions.__index = EmbedFunctions

	local self = setmetatable({}, EmbedFunctions)

	self.EmbedTitle = "Unnamed Embed"
	self.EmbedDescription = ""

	self.Fields = {}

	self.FooterText = ""
	self.FooterImage = ""

	return self
end
function MyHookFunctions:SetTitle(Text: string)
	if not Text then return warn("Embed Set: No title provided **REQUIRED**") end

	self.EmbedTitle = Text
end
function MyHookFunctions:SetDescription(Text: string)
	if not Text then return warn("Embed Set: No description provided") end

	self.EmbedDescription = Text
end
function MyHookFunctions:AddField(Title: string, Description, Inline: boolean)
	if not Title then return warn("Embed Set Add Field: No title provided **REQUIRED**") end
	if not Description then return warn("Embed Set Add Field: No description provided **REQUIRED**") end

	local NewField = {
		name = Title,
		value = Description,
		inline = Inline or false
	}

	table.insert(self.Fields, NewField)
end
function MyHookFunctions:SendEmbed(Embed)
	print(HTTPService(self))
end

return MyHookFunctions
