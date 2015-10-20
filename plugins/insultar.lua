local math = require('math')
local counter_start = 0
local max_prob = 2
local counter_flag = 1
local targets = Set {"33698741", "7055881"}

function Set (list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end

local function get_variables_hash(msg)
  if msg.to.type == 'chat' then
    return 'chat:'..msg.to.id..':pegada'
  end
  if msg.to.type == 'user' then
    return 'user:'..msg.from.id..':pegada'
  end
end

local function get_int_value(redis_value, hash)
  if not redis_value then
    redis:hset(hash, name, counter_start)
    return counter_start
  end

  local int_value = tonumber(redis_value)
  if not int_value or int_value < 1 then
    return counter_start
  end

  return int_value
end

local function run(msg, matches)
  local hash = get_variables_hash(msg)
  name = msg.from.first_name
  if name == "" then
    name = "pedazo de mierda"
  end
  local counter = get_int_value(redis:hget(hash, name), hash)

  value = math.random(1, max_prob)
  print('user_id:'..user_id)
  print('name:'..name)
  print('counter:'..counter)
  print ('max_prob: '..max_prob)  

  if counter < counter_flag then
    value = 0
  end

  redis:hset(hash, name, counter + 1)

  user_id = msg.from.id
  if (value == 1 and targets[user_id]) then
    print ('Pegándosela a '..name..'.')
    redis:hset(hash, name, counter_start)
    return ' '..name..', muerete por favor.'
  end
end

return {
  description = "El plugin que insulta a el tipico anormal",
  usage = "Insulta sin parar",
  patterns = {
    "..*"
  }, 
  run = run 
}
