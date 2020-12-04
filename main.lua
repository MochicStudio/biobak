local mod = RegisterMod("biobak-ardc", 1)
local game = Game()
local MIN_TEAR_DELAY = 5

-- Set item ENUM with a table
local ItemsId = {
	RISK = Isaac.GetItemIdByName("Risk"),
	JADED_RING = Isaac.GetItemIdByName("Jaded Ring"),
	REVERSE_STOPWATCH = Isaac.GetItemIdByName("Reverse Stopwatch"),
	MAGNIFYING_GLASS = Isaac.GetItemIdByName("Magnifying Glass"),
	BUCKET_OF_GUTS = Isaac.GetItemIdByName("Bucket of Guts")
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
-- ENDS LOCAL FUNCTIONS

-- STARTS GAME LOGIC
-- When the run starts or countinues
function mod:onPlayerInit(player)
	UpdateInventory(player)
end

-- When passive effects should update
function mod:onUpdate(player)
	UpdateInventory(player)
end

-- Update the Cache
function mod:onCache(player, cacheFlag)
	if cacheFlag == CacheFlag.CACHE_DAMAGE then
		-- Passive Item Risk Functionality
		if player:HasCollectible(ItemsId.RISK) then
			player.Damage = player.Damage * ItemsBonus.RISK
		end
	end
end

-- Check damage taken from the player
function mod:onPlayerTookDamage(tookDamage, damageAmount, damageFlags, damageSource, damageCountdownFrames)
	local player = game:GetPlayer(0)
	local additionalDamage = damageAmount - (damageAmount * 2) -- Negative

	if player.Type == tookDamage.Type then
		-- Passive Item Risk functionality
		if player:HasCollectible(ItemsId.RISK) then
			local redHearts = player:GetHearts()
			local soulHearts = player:GetSoulHearts()

			-- Instead of calling TakeDamage method for the entity and
			-- causing a C stack overflow we just remove an additional
			-- damageAmount number of half hearts from the player
			if soulHearts >= 1 then
				player:AddSoulHearts(additionalDamage)
			elseif redHearts >= 1 and soulHearts == 0 then
				player:AddHearts(additionalDamage)
			end
		end
	end
end

-- Use Active Items
function mod:onActiveItemUse(collectibleType, RNG)
	local player = game:GetPlayer(0)

	-- Use Bucket of Guts
	if player:HasCollectible(ItemsId.BUCKET_OF_GUTS) then
		local x = player.Position.X
		local y = player.Position.Y
		-- Inner Creep
		-- Left Side of Puddle Creep
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x - 40, y + 20), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x - 40, y + 40), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x - 40, y), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x - 40, y - 20), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x - 40, y - 40), Vector(0, 0), nil)
		-- Top Side of Puddle Creep
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x - 20, y - 40), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x, y - 40), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x + 20, y - 40), Vector(0, 0), nil)
		-- Right Side of Puddle Creep
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x + 40, y - 20), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x + 40, y - 40), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x + 40, y), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x + 40, y + 20), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x + 40, y + 40), Vector(0, 0), nil)
		-- Bottom Side of Puddle Creep
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x - 20, y + 40), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x, y + 40), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x + 20, y + 40), Vector(0, 0), nil)
		-- External Creep
		-- Left Side of Puddle Creep
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x - 70, y + 20), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x - 70, y + 40), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x - 70, y + 50), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x - 70, y + 70), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x - 70, y), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x - 70, y - 20), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x - 70, y - 40), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x - 70, y - 50), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x - 70, y - 70), Vector(0, 0), nil)
		-- Top Side of Puddle Creep
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x - 20, y - 70), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x - 40, y - 70), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x - 50, y - 70), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x, y - 70), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x + 20, y - 70), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x + 40, y - 70), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x + 50, y - 70), Vector(0, 0), nil)
		-- Right Side of Puddle Creep
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x + 70, y - 20), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x + 70, y - 40), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x + 70, y - 50), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x + 70, y - 70), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x + 70, y), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x + 70, y + 20), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x + 70, y + 40), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x + 70, y + 50), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x + 70, y + 70), Vector(0, 0), nil)
		-- Bottom Side of Puddle Creep
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x - 20, y + 70), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x - 40, y + 70), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x - 50, y + 70), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x, y + 70), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x + 20, y + 70), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x + 40, y + 70), Vector(0, 0), nil)
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_RED, 0, Vector(x + 50, y + 70), Vector(0, 0), nil)
	end
end
-- ENDS GAME LOGIC

-- Callbacks
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.onPlayerInit)
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.onUpdate)
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.onCache)
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.onPlayerTookDamage)
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.onActiveItemUse)
