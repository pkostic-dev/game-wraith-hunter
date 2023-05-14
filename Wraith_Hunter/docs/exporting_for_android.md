# Running/exporting for Android

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
  - Enable developer mode and USB debugging on your device
  - Plug the device into your computer
  - Allow USB debugging once prompted on the device
  - In Godot, at the top right, click on the icon of a monitor with the play symbol in the middle
12. Exporting to an APK file :
  - In the File Menu Bar click on 'Project > Export...'
  - Click on the Android preset
  - Click on 'Export Project...'
  - Choose the location
  - Click on 'Save' to export
  
To enable the vibration feature in the game :
1. In the File Menu Bar click on 'Project > Export...'
2. Click on the Android preset
3. On the right-hand side, in the 'Options' tab, scroll all the way down and enable the 'Vibrate' permission
