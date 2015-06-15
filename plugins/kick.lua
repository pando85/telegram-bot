do

local function callback(extra, success, result)
  vardump(success)
  vardump(result)
end

local function run(msg, matches)
  local user = matches[2]

  -- User submitted a user name
  if matches[1] == "name" then
    user = string.gsub(user," ","_")
  end
  
  -- User submitted an id
  if matches[1] == "id" then
    user = 'user#id'..user
  end

  -- The message must come from a chat group
  if msg.to.type == 'chat' then
    local chat = 'chat#id'..msg.to.id
    chat_del_user(chat, user, callback, false)
    return "Kick: "..user.." from "..chat
  else 
    return 'This isnt a chat group!'
  end

end

return {
  description = "kick other user from the chat group", 
  usage = {
    "!kick name [user_name]", 
    "!kick id [user_id]" },
  patterns = {
    "^!kick (name) (.*)$",
    "^!kick (id) (%d+)$"
  }, 
  run = run 
}

end