local math = require('math')
local var_name = 'pegada_max_prob'
local default_max_prob = 20

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
    return default_max_prob
  end

  local int_value = tonumber(redis_value)
  if not int_value or int_value < 1 then
    return default_max_prob
  end

  return int_value
end

local function run(msg, matches)
  local hash = get_variables_hash(msg)
  local max_prob = get_int_value(redis:hget(hash, var_name))

  print ('max_prob: '..max_prob)
  value = math.random(1, max_prob)

  name = msg.from.first_name
  if name == "" then
    name = "pedazo de mierda"
  end

  if value == 1 then
    print ('Pegándosela a '..name..'.')
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
