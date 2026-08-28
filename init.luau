--!nonstrict
--[[
    AnimationModule (init.luau)
    Zero-dependency, standalone Unity-style Animation Engine for Roblox Luau.
    Supports 2D Directional Blend Trees, Track Weight Lanes, Sequence Chains, and Track Preloading.
--]]

local script = script

local AnimationTypes = require(script:WaitForChild("AnimationTypes"))
local DirectionalMixerState = require(script:WaitForChild("DirectionalMixerState"))
local Transitions = require(script:WaitForChild("Transitions"))
local NetworkBridge = require(script:WaitForChild("NetworkBridge"))

export type AnimationClipConfig = AnimationTypes.AnimationClipConfig
export type AnimationSequenceStep = AnimationTypes.AnimationSequenceStep
export type AnimationSequence = AnimationTypes.AnimationSequence
export type DirectionalMixerStateHandle = AnimationTypes.DirectionalMixerStateHandle
export type NetworkProvider = NetworkBridge.NetworkProvider

local AnimationModule = {}
AnimationModule.DirectionalMixerState = DirectionalMixerState
AnimationModule.Transitions = Transitions
AnimationModule.NetworkBridge = NetworkBridge

--- Sets a custom network provider (ByteNet, RemoteEvent, or custom) for AnimationModule
function AnimationModule.setNetworkProvider(provider: NetworkProvider)
	NetworkBridge.setProvider(provider)
end

--- Helper to calculate 2D directional blend weights for 4-way locomotion (Forward, Backward, Left, Right).
-- @param moveVector Vector2 - Normalized 2D movement vector (X = Strafe, Y = Forward/Backward)
-- @return { [string]: number } - Map of animation weights
function AnimationModule.build4WayBlendWeights(moveVector: Vector2): { [string]: number }
	local mag = moveVector.Magnitude
	if mag <= 0.05 then
		return { Forward = 0, Backward = 0, Left = 0, Right = 0 }
	end

	local norm = moveVector.Unit
	local forwardWeight = math.max(0, norm.Y) * mag
	local backwardWeight = math.max(0, -norm.Y) * mag
	local rightWeight = math.max(0, norm.X) * mag
	local leftWeight = math.max(0, -norm.X) * mag

	return {
		Forward = forwardWeight,
		Backward = backwardWeight,
		Left = leftWeight,
		Right = rightWeight,
	}
end

return AnimationModule
