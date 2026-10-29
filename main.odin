package snek

import rl "vendor:raylib"

WINDOW_SIZE :: 1000

Snake :: struct {}

main :: proc() {
	rl.InitWindow(WINDOW_SIZE, WINDOW_SIZE, "SNEK!")
	rl.SetTargetFPS(60)

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)

		rl.DrawRectangle(
			WINDOW_SIZE / 2,
			WINDOW_SIZE / 2,
			WINDOW_SIZE / 15,
			WINDOW_SIZE / 15,
			rl.WHITE,
		)

		rl.EndDrawing()
	}

	rl.CloseWindow()
}
