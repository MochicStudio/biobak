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

-- STARTS LOCAL FUNCTIONS
-- Update Inventory
local function UpdateInventory(player)
	HasItem.risk = player:HasCollectible(ItemsId.RISK)
	HasItem.jaded_ring = player:HasCollectible(ItemsId.JADED_RING)
	HasItem.reverse_stopwatch = player:HasCollectible(ItemsId.REVERSE_STOPWATCH)
	HasItem.magnifying_glass = player:HasCollectible(ItemsId.MAGNIFYING_GLASS)
end

-- Spawn Items, on game start. For test purposes.
local function SpawnItems()
	if game:GetFrameCount() == 1 then
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, ItemsId.RISK, Vector(150, 200), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, ItemsId.JADED_RING, Vector(200, 200), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, ItemsId.REVERSE_STOPWATCH, Vector(250, 200), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, ItemsId.MAGNIFYING_GLASS, Vector(300, 200), Vector(0, 0), nil)
	end
end
-- ENDS LOCAL FUNCTIONS

-- STARTS GAME LOGIC
-- When the run starts or countinues
function mod:onPlayerInit(player)
	UpdateInventory(player)
end

-- When passive effects should update
function mod:onUpdate(player)
	SpawnItems()
	UpdateInventory(player)
end

-- Update the Cache
function mod:onCache(player, cacheFlag)
	if cacheFlag == CacheFlag.CACHE_DAMAGE then
		-- Risk passive item
		if player:HasCollectible(ItemsId.RISK) then
			player.Damage = player.Damage * ItemsBonus.RISK
		end
	end
end

-- Check damage taken from the player
function mod:onPlayerTookDamage(tookDamage, damageAmount, damageFlags, damageSource, damageCountdownFrames)
	game:GetPlayer(0):TakeDamage(damageAmount/2, damageFlags, damageSource, damageCountdownFrames)
end
-- ENDS GAME LOGIC

-- Callbacks
-- TODO Check how to use Item Pools and add the item there.
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.onPlayerInit)
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.onUpdate)
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.onCache)
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.onPlayerTookDamage)
