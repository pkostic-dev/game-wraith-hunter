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

The game is currently still in the development stage.

## Running/exporting for Android

:warning: These steps were made for Godot 4.0.2

First and foremost, follow the steps at [Exporting for Android](https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_android.html) in order to install the required software so that your computer can export for Android devices.

1. Open the project in 'Godot 4.0.2'
2. In the File Menu Bar click on 'Project > Export...'
3. Click on 'Add..' to add a new export preset, then click on 'Android'
4. Click on the new preset
5. Enable the 'Runnable' toggle on the right-hand side if it is disabled
6. At the bottom of the popup window click on 'Manage Export Templates'
7. Click on 'Download and Install'
8. Wait for the export templates to download
9. Close the 'Export Template Manager' window
10. You can now export the project for Android in two ways
11. USB debugging :
  a. Enable developer mode and USB debugging on your device
  b. Plug the device into your computer
  c. Allow USB debugging once prompted on the device
  d. In Godot, at the top right, click on the icon of a monitor with the play symbol in the middle
12. Exporting to an APK file :
  a. In the File Menu Bar click on 'Project > Export...'
  b. Click on the Android preset
  c. Click on 'Export Project...'
  d. Choose the location
  e. Click on 'Save' to export
  
To enable the vibration feature in the game :
1. In the File Menu Bar click on 'Project > Export...'
2. Click on the Android preset
3. On the right-hand side, in the 'Options' tab, scroll all the way down and enable the 'Vibrate' permission

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
