local math = require('math')

local max_prob = 20

local function run(msg, matches)
    value = math.random(1, max_prob)

    if value == 1 then
    	local words = {}
    	for word in matches[1]:gmatch("[^%s]+") do
    	  table.insert(words, word)
        end

    	local random_index = math.random(1, #words)
    	msg_search(get_receiver(msg), words[random_index], forwardinglib.search_callback, msg)
    end
end

return {
  description = "Autoforwards a previous message from that peer",
  usage = "Activate plugin and enjoy it",
  patterns = {
    "^ *(.*[^ ]) *$"
  },
  run = run
}