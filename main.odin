package snek

import "core:thread"
import rl "vendor:raylib"

// constants
CELL_SIZE :: 10
GRID_WIDTH :: 40
GRID_HEIGHT :: 30
MOVE_INTERVAL :: 0.50

// variables
move_timer: f32 = 0

// types
Game_State :: enum {
	Main_Menu,
	Playing,
	Paused,
	Game_Over,
}

Direction :: enum {
	Up,
	Down,
	Left,
	Right,
}

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
	rl.InitWindow(GRID_WIDTH * CELL_SIZE, GRID_HEIGHT * CELL_SIZE, "SNEK!")
	rl.InitAudioDevice()

	snek := Snake {
		pos         = {GRID_WIDTH / 2, GRID_HEIGHT / 2},
		head_sprite = rl.LoadTexture("assets/head.png"),
		body_sprite = rl.LoadTexture("assets/body.png"),
		tail_sprite = rl.LoadTexture("assets/head.png"),
		eat         = rl.LoadSound("assets/eat.wav"),
	}

	direction: Direction = .Right
	next_direction := direction

	game_state: Game_State = .Paused

	// main loop
	// input
	for !rl.WindowShouldClose() {
		if rl.IsKeyDown(.UP) && direction != .Down {next_direction = .Up}
		if rl.IsKeyDown(.DOWN) && direction != .Up {next_direction = .Down}
		if rl.IsKeyDown(.LEFT) && direction != .Right {next_direction = .Left}
		if rl.IsKeyDown(.RIGHT) && direction != .Left {next_direction = .Right}

		// update
		move_timer += rl.GetFrameTime()

		for move_timer >= MOVE_INTERVAL && game_state != .Game_Over {
			move_timer -= MOVE_INTERVAL
			direction = next_direction

			switch direction {
			case .Up:
				snek.pos.y -= 1
			case .Down:
				snek.pos.y += 1
			case .Left:
				snek.pos.x -= 1
			case .Right:
				snek.pos.x += 1
			}

			if snek.pos.x < 0 ||
			   snek.pos.x >= GRID_WIDTH ||
			   snek.pos.y < 0 ||
			   snek.pos.y >= GRID_HEIGHT {
				game_state = .Game_Over
			}
		}

		// draw
		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)

		if game_state == .Game_Over {
			rl.DrawText("GAME OVER", 20, 20, 24, rl.RED)
		}

		rl.DrawTexture(snek.head_sprite, snek.pos.x, snek.pos.y, rl.WHITE)

		rl.EndDrawing()
	}

	// de-initialization
	rl.UnloadTexture(snek.head_sprite)
	rl.UnloadTexture(snek.body_sprite)
	rl.UnloadTexture(snek.tail_sprite)
	rl.UnloadSound(snek.eat)
	rl.CloseWindow()
}
