local math = require('math')

local max_prob = 20

local function run(msg, matches)
    value = math.random(1, max_prob)

    if value == 1 then
        msg_search(get_receiver(msg), matches[1], forwardinglib.search_callback, msg)
    end
end

return {
  description = "Autoforwards a previous message from that peer",
  usage = "Activate plugin and enjoy it",
  patterns = {
    ".+ (.+)$"
  },
  run = run
}