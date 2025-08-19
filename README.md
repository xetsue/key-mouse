# Keyboard & Mouse Control Script

This script, written in AutoHotkey, allows you to control your cursor, mouse buttons, and scrolling with your keyboard. It's designed to be a replacement for mouse usage in certain situations (I personally made this because I can.)

---

## Getting Started

### Prerequisites

* **AutoHotkey:** You need to have AutoHotkey installed on your system to run this script. You can download it from the official website.

### Installation

#### Portable File
Download from [Releases](https://github.com/xetsue/key-mouse/) section, place anywhere on your drive and start the program. 
It will be minimized to `system hidden tray` by default. For usage manual refer to [Usage](https://github.com/xetsue/key-mouse/edit/main/README.md#usage) section below.

#### Manual Creation
Refer to `Code` folder.
1.  Save the code as a file named `Script.ahk`.
2.  Run the script by double-clicking the file.

---

## Usage

### Activation

* Press **Win + CapsLock** to toggle the script on and off.
* A variable named `Toggle` is used to track the script's state, and it is set to `True` when active.

### Default Key Bindings

| Action | Key(s) |
| :--- | :--- |
| **Toggle Script** | **Win + CapsLock** |
| Move Cursor Up | **O** |
| Move Cursor Down | **L** |
| Move Cursor Left | **K** |
| Move Cursor Right | **;** |
| Slow Cursor Speed | **Shift + O, L, K, or ;** |
| Left Click | **I** or **Space** |
| Right Click | **P** |
| Continuous Scroll Up | **W** |
| Continuous Scroll Down | **S** |
| Zoom In | **Q + W** or **Q + O** |
| Zoom Out | **Q + S** or **Q + L** |
| Mouse Button 4 (Back) | **A** |
| Mouse Button 5 (Forward) | **D** |
| Continuous Scroll Down (Mouse Button 4) | **A** (acts as a toggle)|
| Continuous Scroll Up (Mouse Button 5) | **D** (acts as a toggle)|
| Page Up | **\` + Left Arrow** |
| Page Down | **\` + Right Arrow** |

---

## Configuration [ALPHA]

This script uses an `ini` file named `Settings.ini` to save and load custom settings. -- Currently there's two version one with this settings menu and one without. It is reccommended to use the one without for stability as this is an experimental feature.

### Adjusting Speeds

To Open Up The Settings Panel:

1.  Press and hold the **Escape** key for 3 seconds.
2.  A graphical user interface (GUI) will appear.
3.  Use the sliders to adjust the following settings:
    * **Scroll Speed for Keyboard:** Adjusts the speed for continuous scrolling with the keyboard.
    * **Scroll Speed for Mouse Side Buttons:** Adjusts the speed for continuous scrolling with mouse buttons 4 and 5.
    * **Cursor Speed (Normal):** Adjusts the default speed for cursor movement.
    * **Cursor Speed (Shift Held):** Adjusts the speed when the **Shift** key is pressed.
4.  Click **Save** to save your changes to `Settings.ini` and close the GUI.

### Resetting to Default

Each slider has a **Reset** button that will revert its specific value back to the default setting. The default values are as follows:

* **Scroll Speed:** 10
* **Mouse Scroll Speed:** 10
* **Normal Cursor Speed:** 75
* **Slow Cursor Speed:** 15
