# ODIN + RAYLIB TUT: SNAKE

### followed a YT tut to create a snake game :shrug:

1. Open a window
2. Draw snake head on a grid
3. Zoom using camera
4. Make head move
5. Input
6. Multiple body parts
7. "Game over" on wall hit
8. Food that grows snake
9. "Game over" on self hit
10. Add snake and food graphics
11. Score counter
12. Add sounds

### Add improvements to the game
- Add highscore counter: a separate counter that doesn't reset after a game over [easy]
- Make snake movement smooth: you can still be on a grid but move each snake part smoothly to the next cell. [hard]
- Add controller support: see rl.IsGamepadButtonPressed [easy]
- Add music: see rl.PlayMusicStream [medium]
- Add screen shake when you crash / eat food: you can use target on rl.Camera2D. A timer will probably be needed to track for how long to shake screen [medium]
