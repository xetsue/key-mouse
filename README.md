# Key-Mouse

This script was written in AutoHotkey - it allows you to simulate your mouse / cursor control by using your keyboard. It's designed to be a replacement for accessibility usage and for QoL purposes.


# Getting Started
Please note that the script may get false positives from your anti-virus due to its nature of simulating mouse control. If this happens, please isolate the script in a folder and whitelist either the script alone or the folder itself from getting blocked. If you are worried of the credibility of the script itself do take your time to check the raw code and manually compile them with AHK dashboard.

### Alpha / Legacy Prerequisites

* **V1 AutoHotkey**
> Used in Alpha version

### 2026's version Prerequisites

* **V2 AutoHotkey:** 
> Post Alpha version, the script was updated to use v2 AHK to be more compact and lightweight.

# Installation

#### Portable File
Download from [Releases](https://github.com/xetsue/key-mouse/releases/) section, place anywhere on your drive and start the program. 
It will be minimized to `system hidden tray` by default. For usage manual refer to [Usage](https://github.com/xetsue/key-mouse/?tab=readme-ov-file#usage) section below.

#### Manual Compiling
Refer to `Code` folder.
1.  Download desired `.ahk` version from ./main/Code/ or Save the code as any intended filename such as  `example.ahk`.
2.  Run Auto Hotkey > Compile .exe > select the downloaded file > Use 64bit binary > customize other settings such as name or icon accordingly > Compile.

---

## Usage

### Activation

* Run the script.
* Press **Win + Capslock** to toggle the script on and off.
* Activate Capslock to start using its functionality.
> If capslock is not active at this state, the script will not affect any key input. I added this as a safety switch to avoid accidental runs.


## `v2026` Key Bindings
Changelog: 
Added keybind `Profile 1` and `Progile 2`.
On startup, `Profile 1` is used by default, to switch between profiles, use keyboard button `1` and `2` while Capslock is active after turning the script on with `Win + Capslock`.

### `Profile 1` Key Bindings

| Action | Key(s) |
| :--- | :--- |
| **Toggle Script** | **Win + CapsLock** |
| Move Cursor Up | **W** |
| Move Cursor Down | **S** |
| Move Cursor Left | **A** |
| Move Cursor Right | **D** |
| Slow Cursor Speed | **Shift + W / A / S / D** |
| Left Click | **E** or **Space** |
| Right Click | **Q** or **Shift + Space** |
| Continuous Scroll Up | **Arrow Up** |
| Continuous Scroll Down | **Arrow Down** |


### `Profile 2` Key Bindings

| Action | Key(s) |
| :--- | :--- |
| **Toggle Script** | **Win + CapsLock** |
| Move Cursor Up | **P** |
| Move Cursor Down | **;** |
| Move Cursor Left | **L** |
| Move Cursor Right | **'** |
| Slow Cursor Speed | **Shift + P / L / ; / '** |
| Left Click | **O** or **Space** |
| Right Click | **[** or **Shift + Space** |
| Continuous Scroll Up | **W** |
| Continuous Scroll Down | **S** |
| Mouse Button 4 (Back) | **A** |
| Mouse Button 5 (Forward) | **D** |
| Continuous Scroll Down (Mouse Button 4) | **A** (acts as a toggle)|
| Continuous Scroll Up (Mouse Button 5) | **D** (acts as a toggle)|


---

## Archived Legacy Manual
```
## `Alpha` Key Bindings

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
