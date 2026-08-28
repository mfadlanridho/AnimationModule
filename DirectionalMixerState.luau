--!nonstrict
--[[
    DirectionalMixerState.luau
    Handles 2D directional locomotion weight blending for animations.
--]]

local script = script
local Transitions = require(script.Parent:WaitForChild("Transitions"))
local AnimationTypes = require(script.Parent:WaitForChild("AnimationTypes"))

export type BuildWeights = (Vector2) -> { [string]: number }

local DirectionalMixerState = {}
DirectionalMixerState.__index = DirectionalMixerState

function DirectionalMixerState.new(
	runtime: any,
	laneName: string,
	owner: string,
	trackGroup: { [string]: AnimationTrack },
	buildWeights: BuildWeights,
	fadeTime: number?
)
	local self = setmetatable({}, DirectionalMixerState)
	self._runtime = runtime
	self._laneName = laneName
	self._owner = owner
	self._trackGroup = trackGroup
	self._buildWeights = buildWeights
	self._fadeTime = fadeTime
	self._input = Vector2.zero
	return self
end

function DirectionalMixerState:play(initialInput: Vector2?): boolean
	return self:setInput(initialInput or Vector2.zero)
end

function DirectionalMixerState:setInput(input: Vector2): boolean
	self._input = input
	if not self._runtime then return false end

	self._runtime:play(Transitions.blend(
		self._laneName,
		self._owner,
		self._trackGroup,
		self._buildWeights(input),
		self._fadeTime
	))
	return true
end

function DirectionalMixerState:getInput(): Vector2
	return self._input
end

function DirectionalMixerState:stop(fadeTime: number?)
	if self._runtime then
		self._runtime:play(Transitions.stop(self._laneName, self._owner, fadeTime or self._fadeTime))
	end
end

return DirectionalMixerState
