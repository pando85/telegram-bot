local math = require('math')
local counter_start = 0
local max_prob = 4
local counter_flag = 5

local function get_variables_hash(msg)
  if msg.to.type == 'chat' then
    return 'chat:'..msg.to.id..':variables'
  end
  if msg.to.type == 'user' then
    return 'user:'..msg.from.id..':variables'
  end
end

local function get_int_value(redis_value)
  if not redis_value then
      redis:hset(hash, name, counter_start)
    return counter_start
  end

  local int_value = redis_value
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

  local counter = get_int_value(redis:hget(hash, name))

  value = math.random(1, max_prob)
  print ('max_prob: '..max_prob)  

  if counter < counter_flag then
    value = 0
  end

  redis:hset(hash, name, counter + 1)

  if value == 1 then
    print ('Pegándosela a '..name..'.')
    redis:hset(hash, name, counter_start)
    return 'Cállate, '..name..', por favor.'
  end
end

return {
  description = "El plugin de Dios de la Peñita",
  usage = "La pega de vez en cuando. Usa la variable 'pegada_max_prob' para configurar la frecuencia.",
  patterns = {
    "..*"
  }, 
  run = run 
}
