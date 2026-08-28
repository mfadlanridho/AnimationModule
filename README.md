# 🎭 Standalone AnimationModule

A zero-dependency, Unity-style Animation Engine package for Roblox **Luau**.

---

## 📂 Package Architecture

```text
AnimationModule/
├── init.luau                 -- Core entry point & 4-way blend weight helper
├── DirectionalMixerState.luau-- 2D Directional Blend Trees for locomotion
├── Transitions.luau          -- Fade & blend transition solvers
├── AnimationTypes.luau       -- Luau type definitions
└── README.md                 -- Package documentation & code examples
```

---

## 🛠 Features

- 🕹 **2D Directional Blend Trees**: Blends 4-way locomotion animations (Forward, Backward, Left, Right) based on a 2D input `Vector2` (just like Unity Mecanim).
- 🔀 **Weight Blending**: Calculates smooth animation weights on the fly.
- ⚡ **Zero Dependencies**: Works natively with Roblox `Animator` & `Humanoid` instances on any R6 or R15 character.

---

## 🚀 Usage Example

```luau
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AnimationModule = require(ReplicatedStorage.Packages.AnimationModule)

-- Calculate 4-way locomotion weights from Humanoid.MoveDirection
local moveInput = Vector2.new(humanoid.MoveDirection.X, humanoid.MoveDirection.Z)
local weights = AnimationModule.build4WayBlendWeights(moveInput)

print("Forward weight:", weights.Forward)
print("Left weight:", weights.Left)
```

---

## 📄 License
MIT License - Free for use across all your Roblox projects.
