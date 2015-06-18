local math = require('math')
history = {}

local function run(msg, matches)
  value = math.random(1, 6)

  name = msg.from.first_name
  if name == "" then
    name = "pedazo de mierda"
  end

  if history[name] == nil then
    history[name] = 0
  end

  history[name] += 1

  if history[name] >= 10 then
    if value == 1 then
      print ('Pegándosela a '..name..'.')
      history[name] = 0
      return 'Cállate, '..name..', por favor.'
    end
  end


end

return {
  description = "El plugin de Dios de la Peñita",
  usage = "Josu se jode",
  patterns = {
    "..*"
  }, 
  run = run 
}
