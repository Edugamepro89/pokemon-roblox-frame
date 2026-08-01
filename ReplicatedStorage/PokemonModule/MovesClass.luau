type Pokemon = {
	["Name"] : string,
	["Stats"] : {
		["Atk"] : number,
		["Def"] : number,
		["HP"] : number,
		["MaxHP"] : number,
		["SpAtk"] : number,
		["SpDef"] : number,
		["Spd"] : number
	},
	["Type1"] : string,
	["Type2"] : string,
	["friendShip"] : number,
	["heldItem"] : string,
	["level"] : number,
	["moves"] : {},
}

type Move = {
	power : number,
	acc : number,
	pp : number,
	maxPP : number,
	type : string,
	category : string,
	contact : boolean,
	Name : string,
}

local module = {}

module.__index = module

local functionPresets = {
	calculateDamage = function(move : Move, attacker : Pokemon, defender : Pokemon)
		if move.category == "Physical" then
			return math.floor(((((2 * attacker.level) / 5) + 2) * move.power * (attacker.Stats.Atk / defender.Stats.Def)) / 50) + 2
		
		elseif move.category == "Special" then
			return math.floor(((((2 * attacker.level) / 5) + 2) * move.power * (attacker.Stats.SpAtk / defender.Stats.SpDef)) / 50) + 2
		
		else
			warn(move.Name .. " is not a valid move or has no damage category")
			return 0
		end
	end,
}


local list = {
	Tackle = {
		power = 40,
		acc = 1,
		pp = 35,
		maxPP = 35,
		type = "Normal",
		category = "Physical",
		contact = true,
	},
}

local functionList = {
	Tackle = function()
		print("Tackle function called")
	end,
	
}

function module.moveFunction(name)
	return functionList[name]
end

function module.new(name)
	local self = setmetatable({},module)
	
	if not list[name] then
		warn("MOVES CLASS: " .. name .. " IS NOT A VALID MOVE")
		return nil
	end
	
	self = list[name]
	self.Name = name
	
	return self
end

return module
