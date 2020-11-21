local mod = RegisterMod("biobak-ardc", 1)
local game = Game()
local MIN_TEAR_DELAY = 5

-- Set item ENUM with a table
local ItemsId = {
	RISK = Isaac.GetItemIdByName("Risk"),
	JADED_RING = Isaac.GetItemIdByName("Jaded Ring"),
	REVERSE_STOPWATCH = Isaac.GetItemIdByName("Reverse Stopwatch"),
	MAGNIFYING_GLASS = Isaac.GetItemIdByName("Magnifying Glass")
}

-- Check in the game whether or not the player has an item
local HasItem = {
	risk = false,
	jaded_ring = false,
	reverse_stopwatch = false,
	magnifying_glass = false
}

-- Stat changes with every item
local ItemsBonus = {
	RISK = 2, -- Multiplies damage
	JADED_RING_SPEED = 0.5, -- Subtract movement speed
	JADED_RING_SHOT_SPEED = 2 -- Subtract shoot speed
}

function mod:PassiveItemRisk()
	-- Beginning of game, initialization
	if Game():GetFrameCount() == 1 then
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, mod.COLLECTIBLE_RISK, Vector(150, 200), Vector(0, 0), nil)
	end
end

function mod:PassiveItemJadedRing()
	-- Beginning of game, initialization
	if Game():GetFrameCount() == 1 then
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, mod.COLLECTIBLE_JADED_RING, Vector(200, 200), Vector(0, 0), nil)
	end
end

function mod:PassiveItemReverseStopwatch()
	-- Beginning of game, initialization
	if Game():GetFrameCount() == 1 then
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, mod.COLLECTIBLE_REVERSE_STOPWATCH, Vector(250, 200), Vector(0, 0), nil)
	end
end

function mod:PassiveItemMagnifyingGlass()
	-- Beginning of game, initialization
	if Game():GetFrameCount() == 1 then
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, mod.COLLECTIBLE_MAGNIFYING_GLASS, Vector(300, 200), Vector(0, 0), nil)
	end
end

-- Callbacks
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.PassiveItemRisk)
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.PassiveItemJadedRing)
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.PassiveItemReverseStopwatch)
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.PassiveItemMagnifyingGlass)
