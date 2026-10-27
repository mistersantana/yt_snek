package snek

import "core:fmt"
import "core:math"
import rl "vendor:raylib"

// constants
WINDOW_SIZE :: 1000
GRID_SIZE :: 20
CELL_SIZE :: 16
TICK_RATE :: 0.13
CANVAS_SIZE :: GRID_SIZE * CELL_SIZE
MAX_SNAKE_LEN :: GRID_SIZE * GRID_SIZE

// arrays
Vec2i :: [2]int
snake: [MAX_SNAKE_LEN]Vec2i

// variables
tick_timer: f32 = TICK_RATE
move_direction: Vec2i
food_pos: Vec2i
snake_len: int
game_over: bool

// procs
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

// entry point
main :: proc() {
	rl.SetConfigFlags({.VSYNC_HINT})
	rl.InitWindow(WINDOW_SIZE, WINDOW_SIZE, "SNEK")
	rl.InitAudioDevice()
	// rl.SetTargetFPS(60)

	restart()

	food_sprite := rl.LoadTexture("assets/food.png")
	head_sprite := rl.LoadTexture("assets/head.png")
	body_sprite := rl.LoadTexture("assets/body.png")
	tail_sprite := rl.LoadTexture("assets/tail.png")

	eat_sound := rl.LoadSound("assets/eat.wav")
	crash_sound := rl.LoadSound("assets/crash.wav")

	for !rl.WindowShouldClose() {
		if rl.IsKeyDown(.UP) {
			move_direction = {0, -1}
		}
		if rl.IsKeyDown(.DOWN) {
			move_direction = {0, 1}
		}
		if rl.IsKeyDown(.LEFT) {
			move_direction = {-1, 0}
		}
		if rl.IsKeyDown(.RIGHT) {
			move_direction = {1, 0}
		}

		if game_over {
			if rl.IsKeyPressed(.ENTER) {
				restart()
			}
		} else {
			tick_timer -= rl.GetFrameTime()
		}

		if tick_timer <= 0 {
			next_part_pos := snake[0]
			snake[0] += move_direction
			head_pos := snake[0]

			if head_pos.x < 0 ||
			   head_pos.y < 0 ||
			   head_pos.x >= GRID_SIZE ||
			   head_pos.y >= GRID_SIZE {
				game_over = true
				rl.PlaySound(crash_sound)
			}

			for i in 1 ..< snake_len {
				cur_pos := snake[i]

				if cur_pos == head_pos {
					game_over = true
					rl.PlaySound(crash_sound)
				}

				snake[i] = next_part_pos
				next_part_pos = cur_pos
			}

			if head_pos == food_pos {
				snake_len += 1
				snake[snake_len - 1] = next_part_pos
				place_food()
				rl.PlaySound(eat_sound)
			}

			tick_timer = TICK_RATE + tick_timer
		}

		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)

		camera := rl.Camera2D {
			zoom = f32(WINDOW_SIZE) / CANVAS_SIZE,
		}

		rl.BeginMode2D(camera)

		rl.DrawTextureV(food_sprite, {f32(food_pos.x), f32(food_pos.y)} * CELL_SIZE, rl.WHITE)

		for i in 0 ..< snake_len {
			part_sprite := body_sprite
			dir: Vec2i

			if i == 0 {
				part_sprite = head_sprite
				dir = snake[i] - snake[i + 1]
			} else if i == snake_len - 1 {
				part_sprite = tail_sprite
				dir = snake[i - 1] - snake[i]
			} else {
				dir = snake[i - 1] - snake[i]
			}

			rot := math.atan2(f32(dir.y), f32(dir.x)) * math.DEG_PER_RAD

			source := rl.Rectangle{0, 0, f32(part_sprite.width), f32(part_sprite.height)}

			dest := rl.Rectangle {
				f32(snake[i].x) * CELL_SIZE + 0.5 * CELL_SIZE,
				f32(snake[i].y) * CELL_SIZE + 0.5 * CELL_SIZE,
				CELL_SIZE,
				CELL_SIZE,
			}

			rl.DrawTexturePro(
				part_sprite,
				source,
				dest,
				{CELL_SIZE, CELL_SIZE} * 0.5,
				rot,
				rl.WHITE,
			)
		}

		if game_over {
			rl.DrawText("GAME OVER", 4, 4, 25, rl.RED)
			rl.DrawText("Press Enter to play again", 4, 30, 15, rl.WHITE)
		}

		score := snake_len - 3
		score_str := fmt.ctprintf("score: %v", score)
		rl.DrawText(score_str, 4, CANVAS_SIZE - 14, 10, rl.GRAY)

		rl.EndMode2D()
		rl.EndDrawing()

		free_all(context.temp_allocator)
	}

	rl.UnloadTexture(head_sprite)
	rl.UnloadTexture(food_sprite)
	rl.UnloadTexture(body_sprite)
	rl.UnloadTexture(tail_sprite)

	rl.CloseAudioDevice()
	rl.CloseWindow()
}
