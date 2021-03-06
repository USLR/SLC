--[[
 Enable HTTP Service to make the script work.
 ]]

local folder = script.Parent
local url = script.Parent.ServerListServerURL.Value
local authCode = script.Parent.AuthenticationCode.Value

local instanceId = game.JobId
local currentPlayers = #(game.Players:GetPlayers())
local placeId = game.PlaceId

local httpService = game:GetService("HttpService")

local link = url .. "/registerserver?code=" .. authCode .. "&instance_id=" .. instanceId .. "&place_id=" .. placeId .. "&regpc=" .. currentPlayers

game:BindToClose(function() 
	print("got the game is closing")
	local closeLink = script.Parent.ServerListServerURL.Value .. "/delserver?code=" .. script.Parent.AuthenticationCode.Value .. "&instance_id=" .. game.JobId
	print("sending del server")
	local potato = game:GetService("HttpService")
	potato:PostAsync(closeLink, "")
	print("sent")
end)

local function onAdded(player) 
	print("detected person, sending id to server")
	local link = script.Parent.ServerListServerURL.Value .. "/setplayercount?code=" .. script.Parent.AuthenticationCode.Value .. "&instance_id=" .. game.JobId .. "&number=1"	
	print("sending id")
	local potato = game:GetService("HttpService")
	potato:PostAsync(link, "")
	print("i sent it lol")
end

local function onRemove(player)
	print("detected person removal, sending id to server")
	local link = script.Parent.ServerListServerURL.Value .. "/setplayercount?code=" .. script.Parent.AuthenticationCode.Value .. "&instance_id=" .. game.JobId .. "&number=-1"	
	print("sending id")
	local potato = game:GetService("HttpService")
	potato:PostAsync(link, "")
	print("i sent it lol")
end

game.Players.PlayerAdded:Connect(onAdded)
game.Players.PlayerRemoving:Connect(onRemove)

print("sending code") 
--print(link)
httpService:PostAsync(link, "")
print("code sent to server")