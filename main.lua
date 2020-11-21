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
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, mod.COLLECTIBLE_RISK, Vector(150, 200), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, mod.COLLECTIBLE_JADED_RING, Vector(200, 200), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, mod.COLLECTIBLE_REVERSE_STOPWATCH, Vector(250, 200), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, mod.COLLECTIBLE_MAGNIFYING_GLASS, Vector(300, 200), Vector(0, 0), nil)
	end
end
-- ENDS LOCAL FUNCTIONS
