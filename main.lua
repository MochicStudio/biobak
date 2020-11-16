local mod = RegisterMod("biobak-ardc", 1)

-- Set item ENUM
mod.COLLECTIBLE_RISK = Isaac.GetItemIdByName("Risk")
mod.COLLECTIBLE_JADED_RING = Isaac.GetItemIdByName("Jaded Ring")
mod.COLLECTIBLE_REVERSE_STOPWATCH = Isaac.GetItemIdByName("Reverse Stopwatch")

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

-- Callbacks
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.PassiveItemRisk)
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.PassiveItemJadedRing)
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.PassiveItemReverseStopwatch)
