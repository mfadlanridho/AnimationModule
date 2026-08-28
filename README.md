# 🎭 Standalone AnimationModule

A zero-dependency, Unity-style Animation Engine package for Roblox **Luau**.

---

## 📂 Package Architecture

```text
AnimationModule/
├── init.luau                 -- Core entry point, setNetworkProvider & blend weight helper
├── NetworkBridge.luau        -- Dual-compatible network adapter (ByteNet / RemoteEvents / Local)
├── DirectionalMixerState.luau-- 2D Directional Blend Trees for locomotion
├── Transitions.luau          -- Fade & blend transition solvers
├── AnimationTypes.luau       -- Luau type definitions
└── README.md                 -- Package documentation & code examples
```

---

## 🛠 Features

- 🔌 **100% Plug & Play**: Drop into any project and start calling functions immediately with zero configuration required.
- 🕹 **2D Directional Blend Trees**: Blends 4-way locomotion animations (Forward, Backward, Left, Right) based on a 2D input `Vector2` (just like Unity Mecanim).
- 🌐 **Dual Networking Adapter**: Built-in auto-detection for **ByteNet** buffer serialization, native **RemoteEvents**, or **Local Standalone** mode.
- 🔀 **Weight Blending**: Calculates smooth animation weights on the fly.
- ⚡ **Zero Dependencies**: Works natively with Roblox `Animator` & `Humanoid` instances on any R6 or R15 character.

---

## 🌐 Dual Networking & Custom Providers

`AnimationModule` includes a self-contained `NetworkBridge.luau` that automatically detects the host project environment:
1. **ByteNet Mode**: If `ReplicatedStorage.Packages.ByteNet` exists, it routes network events over ByteNet buffers.
2. **RemoteEvent Mode**: If `ReplicatedStorage.Remotes` or `RemoteEvents` exist, it routes over Roblox `RemoteEvents`.
3. **Local Standalone Mode**: If no networking library is found, it runs locally without errors.

### Explicit Custom Provider Override
```luau
AnimationModule.setNetworkProvider({
    send = function(actionName, payload, targetPlayer)
        -- Route through custom network handler
    end,
    listen = function(actionName, callback)
        -- Route listener
    end,
})
```

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
