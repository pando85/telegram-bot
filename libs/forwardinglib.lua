do 
local forwardinglib = {}

local math = require('math')

local function get_appropriate_message(messages, original)
  local filtered_table = {}

  local j = 0
  for i = 0, #messages do
    if messages[i].text ~= original.text then
        filtered_table[j] = messages[i]
        j = j + 1
    end
  end
  if j == 0 then
    return false
  end

  local selected_index = math.random(0, #filtered_table)
  return filtered_table[selected_index]
end

function forwardinglib:search_callback(cb_extra, success, result)
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