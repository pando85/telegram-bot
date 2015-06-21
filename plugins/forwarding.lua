--local table = require "table"
local math = require('math')

local function run(msg, matches)
  local nb_messages = tonumber(matches[1])

  if not nb_messages then
    if not msg_search(get_receiver(msg), matches[1], forwardinglib.search_callback, msg) then
      return 'Failed!'
    end
  else
    if not get_history(get_receiver(msg), nb_messages, forwardinglib.search_callback, msg) then
      return 'Failed!'
    end
  end
end

return {
  description = "Forwards a previous message from that peer",
  usage = "!fwd <number>",
  patterns = {
    "^!fwd +(.+)$"
  },
  run = run
}
