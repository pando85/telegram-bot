do
local forwardinglib = {}

local math = require('math')

local function get_appropriate_message(messages, original)
  local filtered_table = {}

  while #filtered_table ~= #messages do
    local random_index = math.random(0, #messages)

    if not filtered_table[random_index] then
      if messages[random_index].text ~= original.text then
        return messages[random_index]
      else
        filtered_table[random_index] = true
      end
    end
  end

  return false
end

function forwardinglib.search_callback(cb_extra, success, result)
  if success == 0 then
    print('failed: '..cb_extra)
    return
  end

  print (#result..' messages found. filtering...')
  local filtered_message = get_appropriate_message(result, cb_extra)
  if not filtered_message then
    print ('no appropriate messages found!')
    return
  end

  local receiver = get_receiver(cb_extra)
  print ('forwarding message (id:'..filtered_message.id..') from results of '..receiver)
  fwd_msg (receiver, filtered_message.id, ok_cb, false)
end

return forwardinglib
end