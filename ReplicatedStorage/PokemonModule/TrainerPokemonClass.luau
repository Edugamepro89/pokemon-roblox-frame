--Modules
local PokemonClass = require(script.Parent:WaitForChild("PokemonClass"))
local MovesClass = require(script.Parent:WaitForChild("MovesClass"))





local module = {}
module.__index = module

local function calcStats(self)
	local baseStats = PokemonClass.getBaseStats(self.Name)
	local nature = PokemonClass.getNature(self.nature)

	self.Stats.MaxHP = math.floor(((2 * baseStats.HP + self.IVs.HP + math.floor(self.EVs.HP/4)) * self.level) / 100) + self.level + 10
	self.Stats.Atk = math.floor(math.floor(((2 * baseStats.Atk + self.IVs.Atk + math.floor(self.EVs.Atk/4)) * self.level) / 100 + 5) * nature.Atk)
	self.Stats.Def = math.floor(math.floor(((2 * baseStats.Def + self.IVs.Def + math.floor(self.EVs.Def/4)) * self.level) / 100 + 5) * nature.Def)
	self.Stats.SpAtk = math.floor(math.floor(((2 * baseStats.SpAtk + self.IVs.SpAtk + math.floor(self.EVs.SpAtk/4)) * self.level) / 100 + 5) * nature.SpAtk)
	self.Stats.SpDef = math.floor(math.floor(((2 * baseStats.SpDef + self.IVs.SpDef + math.floor(self.EVs.SpDef/4)) * self.level) / 100 + 5) * nature.SpDef)
	self.Stats.Spd = math.floor(math.floor(((2 * baseStats.Spd + self.IVs.Spd + math.floor(self.EVs.Spd/4)) * self.level) / 100 + 5) * nature.Spd)
end

function module.new(name, level, nature, moves, EVs, IVs, heldItem, friendShip)
	local self = setmetatable(PokemonClass.new(name, level), module)

	self.moves = moves or {
		MovesClass.new("Tackle"),
		MovesClass.new("Tackle"),
		MovesClass.new("Tackle"),
		MovesClass.new("Tackle"),
	}

	self.EVs = EVs or {
		HP = 0,
		Atk = 0,
		Def = 0,
		SpAtk = 0,
		SpDef = 0,
		Spd = 0
	}

	self.IVs = IVs or {
		HP = 0,
		Atk = 0,
		Def = 0,
		SpAtk = 0,
		SpDef = 0,
		Spd = 0
	}

	self.nature = nature or "hardy"

	self.heldItem = heldItem or "None"

	self.friendShip = friendShip or 50

	calcStats(self)

	self.Stats.HP = self.Stats.MaxHP

	return self
end

function module:levelUp(amount)
	
	if not amount or amount < 1 then amount = 1 end
	self.level = math.clamp(self.level + amount, 1, 100)

	
	calcStats(self)
end




return module