package snek

import rl "vendor:raylib"

restart :: proc() {
	start_head_pos := Vec2i{GRID_SIZE / 2, GRID_SIZE / 2}
	snake[0] = start_head_pos
	// snake[1] = start_head_pos - {0, 1}
	// snake[2] = start_head_pos - {0, 2}
	snake_len = 1
	// move_direction = {0, 1}
	game_over = false
	place_food()
}
