# ODIN + RAYLIB TUT: SNAKE

### Followed a YT tut to create a snake game :shrug:

- [x] Open a window
- [x] Draw snake head on a grid
- [x] ~~Zoom using camera~~
- [ ] Make head move
- [ ] Input
- [ ] Multiple body parts
- [ ] "Game over" on wall hit
- [ ] Food that grows snake
- [ ] "Game over" on self hit
- [ ] Add snake and food graphics
- [ ] Score counter
- [ ] Add sounds

### Add improvements to the game
- Add highscore counter: a separate counter that doesn't reset after a game over [easy]
- Make snake movement smooth: you can still be on a grid but move each snake part smoothly to the next cell. [hard]
- Add controller support: see rl.IsGamepadButtonPressed [easy]
- Add music: see rl.PlayMusicStream [medium]
- Add screen shake when you crash / eat food: you can use target on rl.Camera2D. A timer will probably be needed to track for how long to shake screen [medium]
