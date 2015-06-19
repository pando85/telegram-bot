local math = require('math')
<<<<<<< HEAD
=======
local history = {}
>>>>>>> parent of e1897dd... Fixed history var init problem

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
