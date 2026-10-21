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

## 3. Skywars — `Skywars/`

Round-based PvP on floating islands. Players mine, build bridges, buy gear between rounds and fight until one is left. Open `places/Skywars.rbxl` in Studio to try it; the scripts in `Skywars/src/` follow the Studio hierarchy.

**Features**

- **Round loop** (`ServerScriptService/Scritpts/Ronda/RondaScript`): waits for the minimum number of players, picks a random island layout from a pool and varies its block colors, teleports players to their spawns, hands out gear, runs the round timer and intermission, and declares the winner.
- **Rewards and progress:** coins and wins saved with DataStores, badges for wins and kills.
- **Building** (`ToolScript/PosicionamientoDeBloque`, `QuitarBloque`): server-validated block placement with a per-round block limit, and block breaking with pickaxes.
- **Weapons in 8 tiers** from Wood to Obsidian: swords with server-side damage, bows with server-side arrows and reload times, pickaxes and blocks. Every tier shares the same script and reads its stats from values.
- **Potions:** health, speed, jump and a temporary shield.
- **Shop** (`Store/BuyScript` + `StarterGui/Store/Manager`): purchases are checked on the server against the player's coins.
- **Spectate mode:** players who are out can cycle the camera through the players still alive.
- **Admin panel:** live tuning of weapon values and reload times.
- **Anti-cheat:** void and position checks during the round.
- **Song requests** in the lobby, with audio validation.
- **Tournament mode:** teleports the whole server to the tournament place.

Third-party pieces used in the place (ragdoll by DarielDev, shift-lock button, leaderboard and donation boards) are not included in `src/`.

---

## Places and models

| File | Contents |
|---|---|
| [`places/SoundSystem.rbxl`](places/SoundSystem.rbxl) | The sound system venue with every script, model and effect |
| [`places/Skywars.rbxl`](places/Skywars.rbxl) | The Skywars game: lobby, islands, shop and every system |
| [`models/CarSystem.rbxm`](models/CarSystem.rbxm) | Vehicle system modules |

---

## Other work (in my portfolio)

- **Rekordo Obby:** published competitive obby with ghost battles, live timer and placement, replays, tournaments, admin tools and 40+ languages.
- **Building:** store interiors and atmospheric campaign maps.
