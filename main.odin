package snek

import "core:thread"
import rl "vendor:raylib"

// constants
WINDOW_SIZE :: 1000
GRID_SIZE :: 750
CELL_SIZE :: 25
TICK_INTERVAL :: 0.13

// variables
tick_rate: f32 = TICK_INTERVAL

// types
Snake :: struct {
	pos:         [2]i32,
	head_sprite: rl.Texture,
	body_sprite: rl.Texture,
	tail_sprite: rl.Texture,
	eat:         rl.Sound,
}

// program entry
main :: proc() {
	// initialization
	rl.SetConfigFlags({.VSYNC_HINT})
	rl.InitWindow(WINDOW_SIZE, WINDOW_SIZE, "SNEK!")
	rl.InitAudioDevice()

	snek := Snake {
		head_sprite = rl.LoadTexture("assets/head.png"),
		body_sprite = rl.LoadTexture("assets/body.png"),
		tail_sprite = rl.LoadTexture("assets/head.png"),
		eat         = rl.LoadSound("assets/eat.wav"),
	}

	// main loop
	for !rl.WindowShouldClose() {
		if rl.IsKeyDown(.UP) {snek.pos += {0, -25}}
		if rl.IsKeyDown(.DOWN) {snek.pos += {0, 25}}
		if rl.IsKeyDown(.LEFT) {snek.pos += {-25, 0}}
		if rl.IsKeyDown(.RIGHT) {snek.pos += {25, 0}}

		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)

		rl.DrawTexture(snek.head_sprite, snek.pos.x, snek.pos.y, rl.WHITE)

		rl.EndDrawing()
	}

	rl.UnloadTexture(snek.head_sprite)
	rl.UnloadTexture(snek.body_sprite)
	rl.UnloadTexture(snek.tail_sprite)
	rl.UnloadSound(snek.eat)
	rl.CloseWindow()
}
