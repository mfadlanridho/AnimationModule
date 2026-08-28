--!strict
--[[
    AnimationTypes.luau
    Type definitions for AnimationModule engine.
--]]

export type AnimationClipConfig = {
	animationId: string,
	fadeTime: number?,
	weight: number?,
	speed: number?,
	looped: boolean?,
}

export type AnimationSequenceStep = {
	animationId: string,
	fadeTime: number?,
	weight: number?,
	speed: number?,
	holdLastFrame: boolean?,
}

export type AnimationSequence = {
	name: string,
	clips: { AnimationSequenceStep },
}

export type DirectionalMixerStateHandle = {
	setInput: (self: DirectionalMixerStateHandle, input: Vector2) -> boolean,
	getInput: (self: DirectionalMixerStateHandle) -> Vector2,
	stop: (self: DirectionalMixerStateHandle, fadeTime: number?) -> (),
}

return {}
