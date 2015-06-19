
local function run(msg, matches)
  local text = string.sub(matches[1], 1, 50)
  
  if not is_chat_msg(msg) then
    return "You are not in a group chat"
  end
  
  -- rename_chat(get_receiver(msg), text)
  
  local receiver = get_receiver(msg)
  print('changing name of chat: '..receiver..' to '..text)
  rename_chat(receiver, text, cb_ok, false)
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
