
local function run(msg, matches)
  if not is_sudo(msg) then
    return "You are not allowed to do this."
  end

  local destination = matches[1]
  print ('destination: '..destination)
  local text = matches[2]
  print ('text: '..text)
  send_large_msg(destination, text)
end

return {
  description = "Use your bot to speak in chats.",
  usage = "!s chat#id[0-9]+ message",
  patterns = {
    "^!s +(chat#id[0-9]+) +(.+)$"
  }, 
  run = run 
}
