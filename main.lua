local mod = RegisterMod("biobak-ardc", 1)

-- Set item ENUM
mod.COLLECTIBLE_RISK = Isaac.GetItemIdByName("Risk")

function mod:PassiveItemRisk()
	-- Beginning of game, initialization
	if Game():GetFrameCount() == 1 then
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, mod.COLLECTIBLE_RISK, Vector(320, 280), Vector(0, 0), nil)
	end
end

-- Callbacks
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.PassiveItemRisk)
