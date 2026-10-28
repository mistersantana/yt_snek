package snek

import rl "vendor:raylib"

// constants
MAX_SNAKE_LEN :: GRID_SIZE * GRID_SIZE

// variables
move_direction: Vec2i
snake_len: int

// load snake sprites
head_sprite := rl.LoadTexture("assets/head.png")
body_sprite := rl.LoadTexture("assets/body.png")
tail_sprite := rl.LoadTexture("assets/tail.png")

// load death sound
death_sound := rl.LoadSound("assets/crash.wav")

Snek :: struct {
	snek_head: rl.Texture,
	snek_body: rl.Texture,
	snek_tail: rl.Texture,
}
