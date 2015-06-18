local math = require('math')

local function run(msg, matches)
  value = math.random(1, 20)

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
  usage = "Josu se jode",
  patterns = {
    "..*"
  }, 
  run = run 
}
