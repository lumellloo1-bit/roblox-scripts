# Lumello — Roblox Scripts

Gameplay systems I built in Luau for Roblox. Each folder is a working system taken from one of my places.

**Portfolio:** https://lumellloo1-bit.github.io/roblox-scripts/  
**Contact:** Discord `lumello`

---

## 1. Custom physics vehicle system — `CarSystem/`

Cars that don't use Roblox constraints. Every wheel casts its own ray, solves its suspension and pushes real forces into the chassis through `VectorForce`s. Turning comes from the lateral forces of the tires, so grip loss and drifting happen on their own.

| File | What it does |
|---|---|
| [`VehicleModule.luau`](CarSystem/VehicleModule.luau) | Suspension, tire grip, steering, wheel spin, engine, gearbox, brakes and engine sound |
| [`CarLibrary.luau`](CarSystem/CarLibrary.luau) | Tuning presets per car type (tires, steering, suspension, engine, transmission) |
| [`controller.client.luau`](CarSystem/controller.client.luau) | Starts and stops client control when the player sits in or leaves the car |
| [`models/CarSystem.rbxm`](models/CarSystem.rbxm) | The model with both modules, ready to drop into Studio |

**How it works**

- **Suspension:** a ray per wheel from above the wheel to below its rest length. The hit gives the compression, and the force is `k·x + c·ẋ` (spring + damper), clamped to zero so the suspension can only push. The damper is derived from a damping ratio (`ζ = 0.7` by default).
- **Tire grip:** lateral force from the slip angle with a simplified Pacejka curve `sin(C·atan(B·slip))`, capped by `μ·N`. The velocity at each wheel includes the rotation of the car (`v + ω × r`).
- **Steering:** Ackermann geometry (inner and outer wheels turn different angles) and a maximum angle that shrinks with speed.
- **Drivetrain:** Gaussian torque curve, 6-speed automatic gearbox with speed bands and hysteresis, reverse with a speed limit, hill hold, aerodynamic drag, rolling resistance and downforce.
- **Feel:** nose dive under braking, a jolt on gear changes, engine pitch and volume tied to RPM.

---

## 2. Music-synced sound system — `SoundSystem/`

A full party venue: players request songs, set up the light show for their song, and become the DJ while it plays.

Open `places/SoundSystem.rbxl` in Studio to try it. The scripts in `SoundSystem/src/` follow the same hierarchy as in Studio.

**Features**

- **Song requests** (`StarterGui/.../Music/Buscar`): the player pastes an audio ID. It's validated with `MarketplaceService` (it must exist, be an audio asset, not be deleted and not already be in the playlist).
- **Loudness analysis:** before queueing, the song is pre-played to measure its average and peak `PlaybackLoudness`. The lights use those values to scale their reaction to each song.
- **Light show setup** (`Suselful/...`): the requester picks the beat color, the ambient color and its intensity from 1 to 10, the smoke color and the fire color. Everything is sent to the server and saved with the song (`ServerScriptService/.../Peticiones`).
- **Playlist** (`ServerScriptService/.../SoundService`): plays requests in order and loads that song's light settings. When the queue is empty it falls back to a default playlist.
- **Requester becomes the DJ:** their avatar is built from their `HumanoidDescription` and placed at the DJ booth while their song plays.
- **Vote to skip** (`ServerScriptService/.../Skip`): one vote per player per song. The track skips when more than half of the server votes.
- **Speakers that pulse** (`ReplicatedStorage/.../PunchPunch`): speaker cones scale with `PlaybackLoudness` every frame.
- **Stage effects:** moving spotlights on servos, DJ lights, ambient lights, smoke machines, fire machines and a light-up dance floor.
- **Venue:** NPC staff that hand out cake, soda and drinks, animated doors (main door and vehicle gate) and bathroom doors with an occupancy counter.

---

## Places and models

| File | Contents |
|---|---|
| [`places/SoundSystem.rbxl`](places/SoundSystem.rbxl) | The sound system venue with every script, model and effect |
| [`models/CarSystem.rbxm`](models/CarSystem.rbxm) | Vehicle system modules |

---

## Other work (in my portfolio)

- **Rekordo Obby:** published competitive obby with ghost battles, live timer and placement, replays, tournaments, admin tools and 40+ languages.
- **Skywars:** round-based PvP on floating islands with mining, bridge building, bows and a tiered shop.
- **Building:** store interiors and atmospheric campaign maps.
