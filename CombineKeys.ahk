; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; COMBINE KEYS - AutoHotKey 2.0 Macro for Pet Simulator 99
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; DIRECTIVES & CONFIGURATIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

#Requires AutoHotkey v2.0  ; Ensures the script runs only on AutoHotkey version 2.0, which supports the syntax and functions used in this script.
#SingleInstance Force  ; Forces the script to run only in a single instance. If this script is executed again, the new instance will replace the old one.
CoordMode "Mouse", "Client"  ; Sets the coordinate mode for mouse functions (like Click, MouseMove) to be relative to the active window's client area, ensuring consistent mouse positioning across different window states.
CoordMode "Pixel", "Client"  ; Sets the coordinate mode for pixel functions (like PixelSearch, PixelGetColor) to be relative to the active window's client area, improving accuracy in color detection and manipulation.
SetMouseDelay 10  ; Sets the delay between mouse events to 10 milliseconds, balancing speed and reliability of automated mouse actions.


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; GLOBAL VARIABLES
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; Titles and versioning for GUI elements.
global MACRO_TITLE := "Combine Keys"  ; The title displayed in main GUI elements.
global MACRO_VERSION := "1.0.0"  ; Script version, helpful for user support and debugging.


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; LIBRARIES
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; Macro Related Libraries:
#Include "%A_ScriptDir%\Modules"    
#Include "Inventory.ahk"  ; Include the Inventory.ahk script, which contains inventory-related functions and definitions.

; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; HOTKEYS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

F5::ExitApp
F8::pauseMacro()

; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; MACRO
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

runMacro()


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; FUNCTIONS & PROCEDURES
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; runMacro Function
; Description: Initializes and runs the macro by performing essential setup tasks.
; Operation:
;   - Calls the completeInitialisationTasks function to perform initial setup tasks.
;   - Displays the main GUI using the showMainGui function.
;   - Activates the Roblox window to ensure it is the current foreground application.
; Dependencies:
;   - completeInitialisationTasks: Function to complete initial setup tasks.
;   - showMainGui: Function to display the main GUI.
;   - activateRoblox: Function to activate the Roblox game window.
; Return: None; the function orchestrates the initialization and running of the macro.
; ---------------------------------------------------------------------------------
runMacro() {
    completeInitialisationTasks()  ; Perform initial setup tasks.
    showMainGui()  ; Display the main GUI.
    activateRoblox()  ; Ensure Roblox is the current foreground application.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; MACRO SETTINGS/FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

completeInitialisationTasks() {
    updateTrayIcon()  ; Set up the tray icon for the script.
    activateRoblox()  ; Ensure Roblox is the current foreground application.
    resizeRobloxWindow()
    closeLeaderboard()
    closeChatLog()
}

; ---------------------------------------------------------------------------------
; updateTrayIcon Function
; Description: Sets a custom icon for the application in the system tray.
; Operation:
;   - Composes the file path for the icon and sets it as the tray icon.
; Dependencies: None.
; Return: None; changes the tray icon appearance.
; ---------------------------------------------------------------------------------
updateTrayIcon() {
    iconFile := A_WorkingDir . "\Assets\Crystal_Key.ico"  ; Set the tray icon file path.
    TraySetIcon iconFile  ; Apply the new tray icon.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; ROBLOX CLIENT FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; activateRoblox Function
; Description: Activates the Roblox game window, ensuring it's the current foreground application.
; Operation:
;   - Attempts to activate the Roblox window using its executable name.
;   - If the window cannot be found, displays an error message and exits the application.
;   - Waits for a predefined delay after successful activation to stabilize the environment.
; Dependencies:
;   - WinActivate: AHK command to focus a window based on given criteria.
;   - MsgBox ExitApp: Functions to handle errors and exit.
;   - Wait: Function to pause the script, ensuring timing consistency.
; Return: None; the function directly interacts with the system's window management.
; ---------------------------------------------------------------------------------
activateRoblox() {
    try {
        WinActivate "ahk_exe RobloxPlayerBeta.exe"  ; Try to focus on Roblox window.
    } catch {
        MsgBox "Roblox window not found."  ; Error message if window is not found.
        ExitApp  ; Exit the script.
    }
    Sleep 200  ; Delay for stabilization after activation.
}

; ----------------------------------------------------------------------------------------
; resizeRobloxWindow Function
; Description: Resizes the Roblox window to specific dimensions to fix any scaling issues with the Supercomputer.
; Operation:
;   - Activates the Roblox window.
;   - Restores the Roblox window if it is minimized.
;   - Resizes the window twice to ensure any scaling issues are fixed.
; Dependencies:
;   - WinActivate: Activates the specified window.
;   - WinRestore: Restores the specified window if it is minimized.
;   - WinMove: Resizes and moves the specified window.
; Parameters: None
; Return: None
; ----------------------------------------------------------------------------------------
resizeRobloxWindow() {
    try {
        windowHandle := WinGetID("ahk_exe RobloxPlayerBeta.exe")
    } catch {
        MsgBox "Roblox window not found."  ; Error message if window is not found.
        ExitApp  ; Exit the script.
    }

    WinActivate windowHandle ; Activate the Roblox window.
    WinRestore windowHandle   ; Restore the Roblox window if it is minimized.
    ; Resize the window twice to fix any scaling issues with the Supercomputer.
    WinMove , , A_ScreenWidth, 600, windowHandle  ; Resize the window to screen width by 600 pixels height.
    WinMove , , 800, 600, windowHandle  ; Resize the window to 800x600 pixels dimensions.    
}

; ----------------------------------------------------------------------------------------
; closeLeaderboard Function
; Description: Searches for the leaderboard rank star icon on the screen and closes the leaderboard if found.
; Operation:
;   - Uses PixelSearch to find the leaderboard rank star icon within specified coordinates and color.
;   - If the leaderboard rank star icon is found, sends the Tab key to close the leaderboard.
; Dependencies: None
; Parameters: None
; Return: None; performs the search and send key operations to close the leaderboard.
; ----------------------------------------------------------------------------------------
closeLeaderboard() {
    leaderboardRankStar := Map("Start", [652, 43], "End", [678, 59], "Colour", "0xB98335", "Tolerance", 50)    
    ; Perform pixel search within specified coordinates and color.
    if PixelSearch(&foundX, &foundY,
        leaderboardRankStar["Start"][1], leaderboardRankStar["Start"][2], 
        leaderboardRankStar["End"][1], leaderboardRankStar["End"][2],  
        leaderboardRankStar["Colour"], leaderboardRankStar["Tolerance"]) 
        SendEvent "{Tab}"  ; Send the Tab key to close the leaderboard.
}

; ----------------------------------------------------------------------------------------
; closeChatLog Function
; Description: Searches for the chat log icon on the screen and closes the chat log if found.
; Operation:
;   - Uses PixelSearch to find the chat log icon within specified coordinates and color.
;   - If the chat log icon is found, clicks on it to close the chat log.
; Dependencies:
;   - leftClickMouse: Function to simulate mouse click at given coordinates.
; Parameters: None
; Return: None; performs the search and click operations to close the chat log.
; ----------------------------------------------------------------------------------------
closeChatLog() {
    chatIconWhite := Map("Start", [81, 24], "End", [81, 24], "Colour", "0xFFFFFF", "Tolerance", 2)
    ; Perform pixel search within specified coordinates and color.
    if PixelSearch(&foundX, &foundY,  
        chatIconWhite["Start"][1], chatIconWhite["Start"][2], 
        chatIconWhite["End"][1], chatIconWhite["End"][2],  
        chatIconWhite["Colour"], chatIconWhite["Tolerance"])
        SendEvent "{Click, " foundX ", " foundY ", 1}"
}

; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; GUI INITIALISATION
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; showMainGui Function
; Description: Initializes and displays the main GUI for the macro, providing interactive controls.
; Operation:
;   - Sets up the main GUI with an "AlwaysOnTop" property to keep it in the foreground.
;   - Sets the GUI title with the macro's name and version.
;   - Configures the font for the GUI text to "Segoe UI" for a modern look.
;   - Adds a ListView to display the current action.
;   - Adds interactive buttons for combining keys, pausing, accessing help, and exiting the macro.
;   - Displays the GUI and positions it at the top-right corner of the screen.
;   - Attaches event handlers to the buttons to connect them with their respective functions.
; Dependencies:
;   - combineKeys: Function to handle the action for the "Combine Keys" button.
;   - pauseMacro: Function to pause the macro.
;   - openWiki: Function to display help information.
;   - exitMacro: Function to exit the macro.
; Return: None; the function creates and manages the main GUI.
; ---------------------------------------------------------------------------------
showMainGui() {
    ; Initialize the main GUI with "AlwaysOnTop" property to ensure it stays in the foreground.
    global guiMain := Gui("+AlwaysOnTop")
    guiMain.Title := MACRO_TITLE " v" MACRO_VERSION  ; Set the GUI title, incorporating version information.
    guiMain.SetFont(, "Segoe UI")  ; Set a modern-looking font for the GUI text.

    global lvCurrent := guiMain.AddListView("r1 w350 NoSortHdr", ["Action"])
    lvCurrent.Add(, "-")  ; Initialize with a default row.
    lvCurrent.ModifyCol(1, 325)    

    ; Add buttons for interactive controls such as pausing or accessing help and about sections.
    btnStart := guiMain.AddButton("Section", "▶ Combine Keys")  ; Adds a button to combine keys.
    btnPause := guiMain.AddButton("yp", "⏸ &Pause (F8)")  ; Adds a pause button with a shortcut key.
    btnHelp := guiMain.AddButton("yp", "🛈 &Help")  ; Adds a help button.
    btnExit := guiMain.AddButton("yp", "✖ E&xit (F5)")  ; Adds an exit button with a shortcut key.

    ; Display the GUI on the screen.
    guiMain.Show()

    ; Position the GUI at the top right of the screen by calculating its width and screen dimensions.
    guiMain.GetPos(,, &Width,)  ; Get the current width of the GUI.
    guiMain.Move(A_ScreenWidth - Width + 8, 0)  ; Move the GUI to just inside the top-right corner.

    ; Attach event handlers to the buttons for defined functionalities.
    btnStart.OnEvent("Click", combineKeys)  ; Connects the Combine Keys button to its function.
    btnPause.OnEvent("Click", pauseMacro)  ; Connects the Pause button to its function.
    btnHelp.OnEvent("Click", openWiki)  ; Connects the Help button to its function.
    btnExit.OnEvent("Click", exitMacro)  ; Connects the Exit button to its function.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; GUI FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; combineKeys Function
; Description: Activates the Roblox window and continuously uses the specified item "Key: Upper Half".
; Operation:
;   - Activates the Roblox game window to ensure it is the current foreground application.
;   - Enters a loop that repeatedly calls the useItem function to use the "Key: Upper Half".
;   - Closes the inventory menu after finishing the loop.
; Dependencies:
;   - activateRoblox: Function to activate the Roblox game window.
;   - useItem: Function to use a specified item within the game.
;   - closeInventoryMenu: Function to close the inventory menu.
; Return: None; the function directly interacts with the game's window and controls.
; ---------------------------------------------------------------------------------
combineKeys(*) {
    Sleep 2000
    activateRoblox()  ; Ensure Roblox is the current foreground application.
    
    keys := ["Tech Key: Upper Half", "Crystal Key: Upper Half"]
    for key in keys {
        Loop {
            hasItem := useItem(key)  ; Use the specified item repeatedly.
            if !hasItem
                break
        }
    }
    
    closeInventoryMenu()  ; Close the inventory menu after finishing.
}

; ---------------------------------------------------------------------------------
; openWiki Function
; Description: Opens the CombineKeys wiki page in the default web browser.
; Operation:
;   - Uses the Run command to open the specified URL, which points to the CombineKeys wiki.
; Dependencies:
;   - None; this function only relies on the AHK Run command to open a web page.
; Return: None; the function directly interacts with the system to open a web browser.
; ---------------------------------------------------------------------------------
openWiki(*) {
    Run "https://github.com/waktool/CombineKeys/wiki"  ; Open the CombineKeys wiki page URL.
}

; ---------------------------------------------------------------------------------
; exitMacro Function
; Description: Exits the macro application completely.
; Operation:
;   - Terminates the application.
; Dependencies:
;   - ExitApp: Command to exit the application.
; Parameters:
;   - None
; Return: None; closes the application.
; ---------------------------------------------------------------------------------
exitMacro(*) {
    ExitApp  ; Exit the macro application.
}

; ---------------------------------------------------------------------------------
; pauseMacro Function
; Description: Toggles the screen state and pauses or unpauses the macro accordingly.
; Operation:
;   - Sends the F11 key to either maximize or unmaximize the screen.
;   - Pauses the script execution if the screen is unmaximized, or resumes if maximized.
; Dependencies:
;   - None; this function directly uses AHK commands to interact with the system.
; Return: None; the function directly interacts with the system and controls the macro's state.
; ---------------------------------------------------------------------------------
pauseMacro(*) {
    Pause -1  ; Pause the macro indefinitely if the screen is unmaximized; otherwise, resume.
}

; ---------------------------------------------------------------------------------
; setCurrentAction Function
; Description: Updates the current action displayed in the ListView.
; Operation:
;   - Modifies the first row of the ListView to display the specified current action.
; Dependencies:
;   - lvCurrent: A global variable representing the ListView control to be updated.
; Return: None; the function directly updates the ListView display.
; ---------------------------------------------------------------------------------
setCurrentAction(currentAction) {
    lvCurrent.Modify(1, , currentAction)  ; Modify the first row to display the new action.
}