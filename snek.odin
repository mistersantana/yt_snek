package snek

import rl "vendor:raylib"

// constants
// MAX_SNAKE_LEN :: GRID_SIZE * GRID_SIZE

// types
Snek :: struct {
	len:         int,
	MAX_LEN:     int,
	head:        rl.Texture,
	body:        rl.Texture,
	tail:        rl.Texture,
	death_sound: rl.Sound,
	direction:   []Vec2i,
}

// load snake sprites
head_sprite := rl.LoadTexture("assets/head.png")
body_sprite := rl.LoadTexture("assets/body.png")
tail_sprite := rl.LoadTexture("assets/tail.png")

// load death sound
death_sound := rl.LoadSound("assets/crash.wav")
