package snek

import rl "vendor:raylib"

WINDOW_SIZE :: 1000

Snake :: struct {
	head_sprite: rl.Texture,
	body_sprite: rl.Texture,
	tail_sprite: rl.Texture,
}

main :: proc() {
	rl.InitWindow(WINDOW_SIZE, WINDOW_SIZE, "SNEK!")
	rl.InitAudioDevice()
	rl.SetTargetFPS(60)

	snek := Snake{}

	for !rl.WindowShouldClose() {

		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)


		rl.EndDrawing()
	}

	rl.CloseWindow()
}
