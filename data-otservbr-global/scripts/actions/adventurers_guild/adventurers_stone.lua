local config = {
	enableTemplaes = true,
	enableDepots = false,

	Temples = {
		{ fromPos = Position(32718, 31628, 7), toPos = Position(32736, 31639, 7), townId = TOWNS_LIST.AB_DENDRIEL },
		{ fromPos = Position(32356, 31775, 7), toPos = Position(32364, 31787, 7), townId = TOWNS_LIST.CARLIN },
		{ fromPos = Position(32642, 31921, 11), toPos = Position(32656, 31929, 11), townId = TOWNS_LIST.KAZORDOON },
		{ fromPos = Position(32364, 32231, 7), toPos = Position(32374, 32243, 7), townId = TOWNS_LIST.THAIS },
		{ fromPos = Position(32953, 32072, 7), toPos = Position(32963, 32081, 7), townId = TOWNS_LIST.VENORE },
		{ fromPos = Position(33188, 32844, 8), toPos = Position(33201, 32857, 8), townId = TOWNS_LIST.ANKRAHMUN },
		{ fromPos = Position(33208, 31803, 8), toPos = Position(33225, 31819, 8), townId = TOWNS_LIST.EDRON },
		{ fromPos = Position(33018, 31514, 11), toPos = Position(33032, 31531, 11), townId = TOWNS_LIST.FARMINE },
		{ fromPos = Position(33210, 32450, 1), toPos = Position(33217, 32457, 1), townId = TOWNS_LIST.DARASHIA },
		{ fromPos = Position(32313, 32818, 7), toPos = Position(32322, 32830, 7), townId = TOWNS_LIST.LIBERTY_BAY },
		{ fromPos = Position(32590, 32740, 7), toPos = Position(32600, 32750, 7), townId = TOWNS_LIST.PORT_HOPE },
		{ fromPos = Position(32207, 31127, 7), toPos = Position(32218, 31138, 7), townId = TOWNS_LIST.SVARGROND },
		{ fromPos = Position(32785, 31274, 7), toPos = Position(32789, 31279, 7), townId = TOWNS_LIST.YALAHAR },
		{ fromPos = Position(33442, 31312, 9), toPos = Position(33454, 31326, 9), townId = TOWNS_LIST.GRAY_BEACH },
		{ fromPos = Position(33586, 31895, 6), toPos = Position(33603, 31903, 6), townId = TOWNS_LIST.RATHLETON },
		{ fromPos = Position(33510, 32360, 6), toPos = Position(33516, 32366, 6), townId = TOWNS_LIST.ROSHAMUUL },
		{ fromPos = Position(33916, 31474, 5), toPos = Position(33927, 31484, 5), townId = TOWNS_LIST.ISSAVI },
	},

	Depots = {
		{ fromPos = Position(32677, 31682, 7), toPos = Position(32684, 31690, 7), townId = TOWNS_LIST.AB_DENDRIEL },
		{ fromPos = Position(32331, 31776, 7), toPos = Position(32339, 31787, 7), townId = TOWNS_LIST.CARLIN },
		{ fromPos = Position(32644, 31903, 8), toPos = Position(32665, 31920, 8), townId = TOWNS_LIST.KAZORDOON },
		{ fromPos = Position(32340, 32217, 7), toPos = Position(32355, 32232, 7), townId = TOWNS_LIST.THAIS },
		{ fromPos = Position(32910, 32070, 7), toPos = Position(32930, 32082, 7), townId = TOWNS_LIST.VENORE },
		{ fromPos = Position(33119, 32836, 7), toPos = Position(33133, 32850, 7), townId = TOWNS_LIST.ANKRAHMUN },
		{ fromPos = Position(33160, 31794, 8), toPos = Position(33175, 31814, 8), townId = TOWNS_LIST.EDRON },
		{ fromPos = Position(33018, 31448, 11), toPos = Position(33035, 31457, 11), townId = TOWNS_LIST.FARMINE },
		{ fromPos = Position(33205, 32455, 8), toPos = Position(33223, 32466, 8), townId = TOWNS_LIST.DARASHIA },
		{ fromPos = Position(32327, 32831, 7), toPos = Position(32340, 32847, 7), townId = TOWNS_LIST.LIBERTY_BAY },
		{ fromPos = Position(32619, 32737, 7), toPos = Position(32635, 32747, 7), townId = TOWNS_LIST.PORT_HOPE },
		{ fromPos = Position(32253, 31137, 7), toPos = Position(32275, 31145, 7), townId = TOWNS_LIST.SVARGROND },
		{ fromPos = Position(32777, 31243, 7), toPos = Position(32796, 31253, 7), townId = TOWNS_LIST.YALAHAR },
		{ fromPos = Position(33437, 31308, 8), toPos = Position(33456, 31323, 8), townId = TOWNS_LIST.GRAY_BEACH },
		{ fromPos = Position(33618, 31889, 7), toPos = Position(33648, 31900, 7), townId = TOWNS_LIST.RATHLETON },
		{ fromPos = Position(33544, 32373, 6), toPos = Position(33562, 32388, 6), townId = TOWNS_LIST.ROSHAMUUL },
		{ fromPos = Position(33916, 31474, 7), toPos = Position(33916, 31474, 7), townId = TOWNS_LIST.ISSAVI },
	},
}

local adventurersStone = Action()

function adventurersStone.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local playerPos, allowed, townId = player:getPosition(), false
	if config.enableTemplaes then
		for _, temple in ipairs(config.Temples) do
			if isInRangeIgnoreZ(playerPos, temple.fromPos, temple.toPos) then
				allowed, townId = true, temple.townId
				break
			end
		end
	end

	if config.enableDepots then
		for _, depot in ipairs(config.Depots) do
			if isInRangeIgnoreZ(playerPos, depot.fromPos, depot.toPos) then
				allowed, townId = true, depot.townId
				break
			end
		end
	end

	if not allowed then
		local enabledLocations = {}
		if config.enableTemplaes then
			table.insert(enabledLocations, 'temple')
		end
		if config.enableDepots then
			table.insert(enabledLocations, 'depot')
		end
		local message = 'Try to move more to the center of a ' .. table.concat(enabledLocations, ' or ') .. ' to use the spiritual energy for a teleport.'
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
		return true
	end

	player:setStorageValue(Storage.AdventurersGuild.Stone, townId)
	playerPos:sendMagicEffect(CONST_ME_TELEPORT)

	local destination = Position(32210, 32300, 6)
	player:teleportTo(destination)
	destination:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

adventurersStone:id(16277)
adventurersStone:register()
