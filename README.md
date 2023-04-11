<p align="center">
<img src="https://raw.githubusercontent.com/pkostic-dev/game-wraith-hunter/main/Wraith_Hunter/icon.png" style="display:block; margin:auto; width:256px">
</p>
<h1 align="center">Wraith Hunter</h1>
<p align="center">An audio-only ghost hunting game targetting Android smartphones</p>

## About

Made in [Godot 4](https://www.godotengine.org) using GDScript. This game uses 
binaural audio, haptic feedback, and the gyroscope sensor for gameplay. It also 
uses the touchscreen for controls. Debug controls allow to test the game on a 
desktop PC by simulating touch controls and the gyroscope using the mouse and 
keyboard.

The game is currently still in development stages.

## Running/exporting for Android

:warning: The steps to correctly run on or export the game for Android might 
have changed since Godot RC 1.

- Install Android Export
- Install Android Build Template
- Create a new Android Export
- Toggle Runnable
- Enable the Vibrate permission
- Enable Gradle build
- Change the Min SDK to 24

Target Android SDK version has changed to 33 as of Godot 4.0.2.

## Documentation

[Style guide](Wraith_Hunter/docs/style_guide.md)  
[Project Architecture](Wraith_Hunter/docs/project_architecture.md)  
[Credits](Wraith_Hunter/docs/credits.md)

## Licensing

If you make use of the code or any of the assets, please respect this license, 
thank you.

```markdown
MIT License

Copyright (c) 2022 pkostic-dev

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
