package snek

import rl "vendor:raylib"

WINDOW_SIZE :: 800


main :: proc() {
	rl.InitWindow(WINDOW_SIZE, WINDOW_SIZE, "SNEK!")
	rl.SetTargetFPS(60)

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)

		rl.EndDrawing()
	}

	rl.CloseWindow()
}
