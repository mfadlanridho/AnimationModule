--!nonstrict
--[[
    Transitions.luau
    Fade and blend transition helpers for AnimationModule.
--]]

local Transitions = {}

function Transitions.blend(laneName: string, owner: string, trackGroup: { [string]: AnimationTrack }, weights: { [string]: number }, fadeTime: number?)
	return {
		type = "blend",
		laneName = laneName,
		owner = owner,
		trackGroup = trackGroup,
		weights = weights,
		fadeTime = fadeTime or 0.2,
	}
end

function Transitions.stop(laneName: string, owner: string, fadeTime: number?)
	return {
		type = "stop",
		laneName = laneName,
		owner = owner,
		fadeTime = fadeTime or 0.2,
	}
end

return Transitions
