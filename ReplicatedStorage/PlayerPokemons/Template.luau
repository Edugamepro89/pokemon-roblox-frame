local module = {}

module.__index = module

module.Pokemons = {}

function module.AddMon(mon, level, nature, moves, EVs, IVs, heldItem, friendShip)
	if #module.Pokemons >= 6 then print("MAX POKEMONS") return end
	
	if typeof(mon) ==  "table" then
		table.insert(module.Pokemons, mon)
		return
	end
	
	local pokemonClass = require(game:GetService("ReplicatedStorage"):WaitForChild("PokemonModule"):WaitForChild("PokemonClass"))
	local TrainerPokemonClass = require(game:GetService("ReplicatedStorage"):WaitForChild("PokemonModule"):WaitForChild("TrainerPokemonClass"))
	
	table.insert(module.Pokemons, TrainerPokemonClass.new(mon, level, nature, moves, EVs, IVs, heldItem, friendShip))
	
end

function module.PrintMons()
	print(module.Pokemons)
end

function module.getMons()
	return module.Pokemons
end

function module.getMon(index)
	if typeof(index) == "string" then
		for i, v in pairs(module.Pokemons) do
			if v.Name == index then
				return v
			end
		end
		
		warn("PLAYER_POKEMONS CLASS: " .. index .. " IS NOT A VALID NAME")
		return nil
	
	elseif typeof(index) == "number" then
		if index < 1 or index > 6 then warn("PLAYER_POKEMONS CLASS : " .. index .. "IS NOT A VALID INDEX") end
		return module.Pokemons[index]
		
	end
	
	warn("PLAYER_POKEMONS CLASS: " .. index .. " IS NOT A VALID NAME OR INDEX")
	return nil
end

return module
