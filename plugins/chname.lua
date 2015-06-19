
local function run(msg, matches)
  local text = matches[1]

  if not is_chat_msg(msg) then
    return "You are not in a group chat"
  end

  rename_chat(get_receiver(msg), text)
  return "Done!"
end

return {
  description = "Changes the group name",
  usage = "!chname [group name]: sets the group name to [group name]",
  patterns = {
    "^!chname +(.+)$"
  }, 
  run = run 
}
