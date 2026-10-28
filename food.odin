package snek

import rl "vendor:raylib"

// load food sprite
food_sprite := rl.LoadTexture("assets/food.png")

// load food eat sound
eat_sound := rl.LoadSound("assets/eat.wav")

place_food :: proc() {
	occupied: [GRID_SIZE][GRID_SIZE]bool

	for i in 0 ..< snake_len {
		occupied[snake[i].x][snake[i].y] = true
	}

	free_cells := make([dynamic]Vec2i, context.temp_allocator)

	for x in 0 ..< GRID_SIZE {
		for y in 0 ..< GRID_SIZE {
			if !occupied[x][y] {
				append(&free_cells, Vec2i{x, y})
			}
		}
	}

	if len(free_cells) > 0 {
		random_cell_index := rl.GetRandomValue(0, i32(len(free_cells)) - 1)
		food_pos = free_cells[random_cell_index]
	}

	// delete(free_cells)
}
