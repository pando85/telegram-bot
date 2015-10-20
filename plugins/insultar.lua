local math = require('math')
local counter_start = 0
local max_prob = 4
local counter_flag = 1

local insultos = {"abanto","abrazafarolas","adufe","alcornoque","alfeñique","andurriasmo","arrastracueros","artabán","atarre","baboso","barrabás","barriobajero","bebecharcos","bellaco","belloto","berzotas","besugo","bobalicón","bocabuzón","bocachancla","bocallanta","boquimuelle","borrico","botarate","brasas","cabestro","cabezaalberca","cabezabuque","cachibache","cafre","cagalindes","cagarruta","calambuco","calamidad","caldúo","calientahielos","calzamonas","cansalmas","cantamañanas","capullo","caracaballo","caracartón","caraculo","caraflema","carajaula","carajote","carapapa","carapijo","cazurro","cebollino","cenizo","cenutrio","ceporro","cernícalo","charrán","chiquilicuatre","chirimbaina","chupacables","chupasangre","chupóptero","cierrabares","cipote","comebolsas","comechapas","comeflores","comestacas","cretino","cuerpoescombro","culopollo","descerebrado","desgarracalzas","dondiego","donnadie","echacantos","ejarramantas","energúmeno","esbaratabailes","escolimoso","escornacabras","estulto","fanfosquero","fantoche","fariseo","filimincias","foligoso","fulastre","ganapán","ganapio","gandúl","gañán","gaznápiro","gilipuertas","giraesquinas","gorrino","gorrumino","guitarro","gurriato","habahelá","huelegatera","huevón","lamecharcos","lameculos","lameplatos","lechuguino","lerdo","letrín","lloramigas","longanizas","lumbreras","maganto","majadero","malasangre","malasombra","malparido","mameluco","mamporrero","manegueta","mangarrán","mangurrián","mastuerzo","matacandiles","meapilas","melón","mendrugo","mentecato","mequetrefe","merluzo","metemuertos","metijaco","mindundi","morlaco","morroestufa","muerdesartenes","orate","ovejo","pagafantas","palurdo","pamplinas","panarra","panoli","papafrita","papanatas","papirote","paquete","pardillo","parguela","pasmarote","pasmasuegras","pataliebre","patán","pavitonto","pazguato","pecholata","pedorro","peinabombillas","peinaovejas","pelagallos","pelagambas","pelagatos","pelatigres","pelazarzas","pelele","pelma","percebe","perrocostra","perroflauta","peterete","petimetre","picapleitos","pichabrava","pillavispas","piltrafa","pinchauvas","pintamonas","piojoso","pitañoso","pitofloro","plomo","pocasluces","pollopera","quitahipos","rastrapajo","rebañasandías","revientabaules","ríeleches","robaperas","ronchalastimas","sabandija","sacamuelas","sanguijuela","sinentraero","sinsustancia","sonajas","sonso","soplagaitas","soplaguindas","sosco","tagarote","tarado","tarugo","tiralevitas","tocapelotas","tocho","tolai","tontaco","tontucio","tordo","tragaldabas","tuercebotas","tunante","zamacuco","zambombo","zampabollos","zamugo","zángano","zarrapastroso","zascandil","zopenco","zoquete","zote","zullenco","zurcefrenillos"}

local function Set (list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end

local targets = Set {33698741}

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

  user_id = msg.from.id
  value = math.random(1, max_prob)
  print('user_id:'..user_id)
  print('name:'..name)
  print('counter:'..counter)
  print ('max_prob: '..max_prob)  

  if counter < counter_flag then
    value = 0
  end

  redis:hset(hash, name, counter + 1)

  if (value == 1 and targets[user_id]) then
    print ('Insultando a '..name..'.')
    redis:hset(hash, name, counter_start)
    return 'Que pasa '..name..' pareces el típico '..insultos[math.random(#insultos)]..'.'
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
