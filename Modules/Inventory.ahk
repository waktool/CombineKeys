#Requires AutoHotkey v2.0

; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; INVENTORY FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; openInventoryMenu Function
; Description: Opens the inventory menu in the game.
; Operation:
;   - Checks if the inventory menu is already open.
;   - If the inventory button is centered, sends the key event to open the inventory.
;   - Waits for the inventory menu to open, checking at regular intervals.
; Dependencies:
;   - isInventoryOpen: Function to check if the inventory menu is open.
;   - isInventoryButtonCentered: Function to check if the inventory button is centered.
;   - setCurrentAction: Function to update the current action status.
; Parameters: None
; Return: Boolean - True if the inventory menu is successfully opened, False otherwise.
; ----------------------------------------------------------------------------------------
openInventoryMenu() {
    
    ; Sleep 200  ; Optional delay before proceeding.
    
    ; Check if the inventory menu is already open.
    if isInventoryOpen()
        return true  ; Return true if the inventory menu is already open.

    setCurrentAction("Opening inventory")  ; Update the current action to "Opening inventory".

    ; If the inventory button is centered, send the key event to open the inventory menu.
    if isInventoryButtonCentered() {
        SendEvent "{f}"  ; Send the key event to open the inventory menu.
        Sleep 100  ; Wait 100 milliseconds before checking.
    }

    ; Loop to check if the inventory menu is open.
    Loop 5 {
        setCurrentAction("Waiting for inventory to open: " A_Index)  ; Update the current action to "Waiting for inventory to open".
        if isInventoryOpen()  ; Check if the inventory menu is open.
            return true  ; Return true and exit the function if the inventory menu is open.
        Sleep 10  ; Wait 10 milliseconds before the next check.
    }

    setCurrentAction("Failed: Waiting for inventory to open")  ; Update the current action if the inventory menu did not open.
    return false  ; Return false if the inventory menu did not open after all attempts.
}

; ----------------------------------------------------------------------------------------
; openItemsTab Function
; Description: Opens the items tab within the inventory menu.
; Operation:
;   - Waits for the inventory menu to open.
;   - Checks if the items tab is already open and returns if true.
;   - Simulates clicks on the items tab coordinates to open it.
;   - Updates the current action based on success or failure.
; Dependencies:
;   - isInventoryOpen: Function to check if the inventory menu is open.
;   - isItemsTabOpen: Function to check if the items tab is open.
;   - setCurrentAction: Function to update the current action status.
; Parameters: None
; Return: Boolean - True if the items tab is successfully opened, False otherwise.
; ----------------------------------------------------------------------------------------
openItemsTab() {

    ; Wait until the inventory menu is open.
    Loop 50 {
        setCurrentAction("Waiting for inventory to open: " A_Index)
        if isInventoryOpen()
            break
        Sleep 10
    }

    ; Check if the items tab is already open.
    if isItemsTabOpen()
        return true  ; Return true if the items tab is already open.

    itemsTab := [26, 205]  ; Coordinates for the items tab.

    setCurrentAction("Opening items tab")  ; Update the current action to "Opening items tab".

    ; Attempt to click the items tab up to 10 times.
    Loop 10 {
        setCurrentAction("Clicking items tab button: " A_Index)
        SendEvent "{Click, " itemsTab[1] ", " itemsTab[2] ", 1}"  ; Simulate a mouse click on the items tab coordinates.
        Sleep 10  ; Wait 10 milliseconds before the next check.

        ; Wait for the items tab to open after each click.
        Loop 25 {
            setCurrentAction("Waiting for items tab to open: " A_Index)
            if isItemsTabOpen()  ; Check if the items tab is open.
                return true  ; Return true and exit the function if the items tab is open.
            Sleep 10
        }
    }

    setCurrentAction("Failed: Waiting for items tab to open")  ; Update the current action if the items tab did not open.
    return false  ; Return false if the items tab did not open.
}

; ----------------------------------------------------------------------------------------
; clickInventorySearchBox Function
; Description: Attempts to select the inventory search box by clicking on it.
; Operation:
;   - Checks if the search box is already selected.
;   - If not, attempts to click on the search box until it is selected or the maximum number of attempts is reached.
;   - Waits for the search box to be selected, checking periodically.
; Dependencies:
;   - isInventorySearchBoxSelected: Function that checks if the inventory search box is selected.
;   - setCurrentAction: Function that sets the current action status.
; Parameters: None
; Return: True if the search box is successfully selected, otherwise False.
; ----------------------------------------------------------------------------------------
clickInventorySearchBox() {
    if isInventorySearchBoxSelected()
        return true  ; Return true if the search box is already selected.

    searchBox := [540, 107]
    inventoryIcon := [49, 95]
    
    Loop 10 {
        if isSearchTermEntered() {
            setCurrentAction("Selecting inventory icon: " A_Index)  ; Update the current action.
            SendEvent "{Click, " inventoryIcon[1] ", " inventoryIcon[2] ", 1}"  ; Click directly on the search box.
            Sleep 10  ; Wait 10 milliseconds before checking.
        }
        Loop 25 {
            setCurrentAction("Selecting search box: " A_Index)  ; Update the current action.
            SendEvent "{Click, " searchBox[1] ", " searchBox[2] ", 1}"  ; Click directly on the search box.
            Sleep 10  ; Wait 10 milliseconds before checking.
            if isInventorySearchBoxSelected()  ; Check if the search box is selected.
                return true  ; Return true and exit the function if the search box is selected.            
        }
    }
    setCurrentAction("Failed: Selecting search box")
    return false  ; Return false if the search box did not get selected after all attempts.
}

; ----------------------------------------------------------------------------------------
; enterSearchTerm Function
; Description: Attempts to enter a search term in the inventory search box.
; Operation:
;   - Checks if the search term is already entered.
;   - If not, attempts to send the search term text to the search box until it is entered or the maximum number of attempts is reached.
;   - Waits for the search term to be entered, checking periodically.
; Dependencies:
;   - isSearchTermEntered: Function that checks if the search term is entered.
;   - setCurrentAction: Function that sets the current action status.
; Parameters:
;   - Item: The search term text to be entered.
; Return: True if the search term is successfully entered, otherwise False.
; ----------------------------------------------------------------------------------------
enterSearchTerm(Item) {

    if isSearchTermEntered()
        return true  ; Return true if the search term is already entered.

    Loop 10 {  ; Loop to attempt entering the search term.
        setCurrentAction("Entering search term: " A_Index)  ; Update the current action.
        SendText Item  ; Send the search term text to the search box.

        Loop 25 {  ; Check if the search term is entered.
            setCurrentAction("Waiting for search term to be entered: " A_Index)  ; Update the current action.
            Sleep 10  ; Wait 10 milliseconds before the next check.
            if isSearchTermEntered()  ; Check if the search term is entered.
                return true  ; Return true and exit the function if the search term is entered.          
        }
    }
    
    setCurrentAction("Failed: Waiting for search term to be entered")  ; Update the current action if failed.
    return false  ; Return false if the search term fails to be entered after all attempts.
}

; ----------------------------------------------------------------------------------------
; closeOopsWindow Function
; Description: Attempts to close the "Oops" window by sending a left-click event to its coordinates.
; Operation:
;   - Pauses briefly before proceeding.
;   - Checks if the "Oops" window is open and attempts to close it up to 25 times.
;   - Updates the current action during the process and checks if the window is closed.
; Dependencies:
;   - isOopsWindowOpen, setCurrentAction
; Parameters: None
; Return: Boolean - True if the "Oops" window is successfully closed, False otherwise.
; ----------------------------------------------------------------------------------------
closeOopsWindow() {
    Sleep 200  ; Pause briefly before proceeding.

    if !isOopsWindowOpen()  ; Check if the "Oops" window is already closed.
        return true  ; Return true if the "Oops" window is already closed.

    closeButton := [622, 110]  ; Coordinates of the close button.

    Loop 25 {  ; Loop to attempt closing the "Oops" window.
        setCurrentAction("Closing oops window: " A_Index)  ; Update the current action with attempt count.
        SendEvent "{Click, " closeButton[1] ", " closeButton[2] ", 1}"  ; Click the close button.
        Sleep 10  ; Wait 10 milliseconds before the next check.
        
        if !isOopsWindowOpen()  ; Check if the "Oops" window is no longer open.
            return true  ; Return true if the window is successfully closed.
    }

    setCurrentAction("Failed: Closing oops window")  ; Update the current action if the window fails to close.
    return false  ; Return false if the "Oops" window fails to close after all attempts.
}

; ----------------------------------------------------------------------------------------
; leftClickUseItem Function
; Description: Attempts to use a specified item by sending a left-click event to its coordinates.
; Operation:
;   - Sends a left-click event to the item's coordinates up to 25 times.
;   - Checks if the item is a key and waits for the inventory window to close.
; Dependencies:
;   - isItemKey, isInventoryOpen, setCurrentAction
; Parameters: None
; Return: Boolean - True if the item is used and the inventory window closes, False otherwise.
; ----------------------------------------------------------------------------------------
leftClickUseItem() {
    item1 := [109, 235]  ; Coordinates of the item to use.

    Loop 25 {  ; Attempt to use the item up to 25 times.
        setCurrentAction("Using item: " A_Index)  ; Update the current action with attempt count.
        
        if isItemKey() {  ; Check if the item is a key.
            SendEvent "{Click, " item1[1] ", " item1[2] ", 1}"  ; Send left-click event to use the item.
        
            Loop 50 {  ; Check up to 50 times if the inventory is closed.
                Sleep 10  ; Wait 10 milliseconds before the next check.
                setCurrentAction("Waiting for inventory window to close after using item: " A_Index)  ; Update the current action.
                if !isInventoryOpen()  ; Check if the inventory is no longer open.
                    return true  ; Exit the function if the inventory is closed.
            }
        }
        else
            return false  ; Return false if the item is not a key.
    }

    setCurrentAction("Failed: Waiting for inventory window to close after using item")  ; Update the current action if the item was not used successfully.
    return false  ; Return false if the item was not used and the inventory window did not close.
}
; ----------------------------------------------------------------------------------------
; leftClickCombineOne Function
; Description: Attempts to combine items by clicking the "Combine One" button.
; Operation:
;   - Waits until the combine window is open.
;   - Sends a left-click event to the "Combine One" button.
;   - Loops to check if the combine window is no longer open, indicating the combine action was successful.
; Dependencies:
;   - isCombineWindowOpen: Function that checks if the combine window is open.
; Parameters: None
; Return: None
; ----------------------------------------------------------------------------------------
leftClickCombineOne() {
    ; Wait until the combine window is open.
    Loop 50 {
        setCurrentAction("Waiting for combine window: " A_Index)
        if isCombineWindowOpen()  ; Check if the combine window is open.
            break  ; Exit the loop if the combine window is open.
        Sleep 10  ; Wait 10 milliseconds before the next check.
    }

    combineOne := [287, 409]  ; Coordinates of the "Combine One" button.

    ; Attempt to click the "Combine One" button up to 100 times.
    Loop 50 {
        setCurrentAction("Combining one key: " A_Index)
        SendEvent "{Click, " combineOne[1] ", " combineOne[2] ", 1}"  ; Send left-click event to the "Combine One" button.
        Sleep 10  ; Wait 10 milliseconds before the next check.
        
        if !isCombineWindowOpen()  ; Check if the combine window is no longer open.
            break  ; Exit the loop if the combine window is closed.
    }
    setCurrentAction("-")
}

; ----------------------------------------------------------------------------------------
; leftClickCombineSuccess Function
; Description: Handles clicking the "Combine Success" button to confirm the success of combining items.
; Operation:
;   - Waits until the success window is open.
;   - Attempts to click the "Combine Success" button up to 50 times.
;   - Waits until the inventory window is open again.
; Dependencies:
;   - isSuccessWindowOpen, isInventoryOpen, setCurrentAction
; Parameters: None
; Return: None
; ----------------------------------------------------------------------------------------
leftClickCombineSuccess() {
    ; Wait until the success window is open.
    setCurrentAction("Waiting for combine success window")
    Loop 50 {
        if isSuccessWindowOpen()  ; Check if the success window is open.
            break  ; Exit the loop if the success window is open.
        Sleep 10  ; Wait 10 milliseconds before the next check.
    }

    combineSuccess := [397, 409]  ; Coordinates of the "Combine Success" button.

    ; Attempt to click the "Combine Success" button up to 50 times.
    Loop 50 {
        setCurrentAction("Clicking the success OK button: " A_Index)  ; Update the current action with attempt count.
        SendEvent "{Click, " combineSuccess[1] ", " combineSuccess[2] ", 1}"  ; Send left-click event to the "Combine Success" button.
        Sleep 10  ; Wait 10 milliseconds before the next check.

        if !isSuccessWindowOpen()  ; Check if the success window is no longer open.
            break  ; Exit the loop if the success window is closed.
    }

    ; Wait until the inventory window is open again.
    Loop 50 {
        Sleep 10  ; Wait 10 milliseconds before the next check.
        if isInventoryOpen()  ; Check if the inventory menu is open.
            break  ; Exit the loop if the inventory menu is open.
    }

    setCurrentAction("-")  ; Reset the current action.
}

; ----------------------------------------------------------------------------------------
; closeInventoryMenu Function
; Description: Attempts to close the inventory menu by clicking the close button.
; Operation:
;   - Checks if the inventory menu is open.
;   - If open, clicks the close button and waits for the menu to close.
; Dependencies:
;   - isInventoryOpen: Function that checks if the inventory menu is open.
; Parameters: None
; Return: None
; ----------------------------------------------------------------------------------------
closeInventoryMenu() {

    ; Check if the inventory menu is already closed.
    if !isInventoryOpen()
        return  ; Exit the function if the inventory menu is not open.

    closeButton := [746, 109]  ; Coordinates of the close button.

    ; Loop to attempt closing the inventory menu.
    Loop 25 {
        setCurrentAction("Closing the inventory menu: " A_Index)
        SendEvent "{Click, " closeButton[1] ", " closeButton[2] ", 1}"  ; Send left-click event to the close button.
        Sleep 10  ; Wait 10 milliseconds before the next check.

        if !isInventoryOpen()  ; Check if the inventory menu is no longer open.
            break  ; Exit the loop and function if the inventory menu is closed.
    }
    setCurrentAction("-")
}

; ----------------------------------------------------------------------------------------
; useItem Function
; Description: Uses a specified item by navigating through the inventory and combining it.
; Operation:
;   - Opens the inventory menu and navigates to the items tab.
;   - Searches for the specified item and attempts to use and combine it.
;   - Closes the inventory menu and handles any potential "Oops" window.
; Dependencies:
;   - openInventoryMenu: Function to open the inventory menu.
;   - openItemsTab: Function to open the items tab.
;   - clickInventorySearchBox: Function to click the inventory search box.
;   - enterSearchTerm: Function to enter the search term.
;   - hasItem: Function to check if the specified item is present.
;   - leftClickUseItem: Function to click and use the item.
;   - leftClickCombineOne: Function to click the combine button.
;   - leftClickCombineSuccess: Function to handle the success window after combining.
;   - closeOopsWindow: Function to close any "Oops" window.
; Parameters:
;   - itemToUse: The item to search for and use.
; Return: None
; ----------------------------------------------------------------------------------------
useItem(itemToUse) {
    ; Open the inventory menu.
    if !openInventoryMenu()
        return true

    ; Open the items tab.
    if !openItemsTab()
        return true

    ; Click the inventory search box.
    if !clickInventorySearchBox()
        return true
    
    ; Enter the search term.
    if !enterSearchTerm(itemToUse)
        return true

    ; Check if the item is found.
    if !hasItem()
        return false

    setCurrentAction("Combining key")  ; Update the current action.
    if leftClickUseItem()  {
        leftClickCombineOne()  ; Click the combine button.
        leftClickCombineSuccess()  ; Click the success window.
    }
    setCurrentAction("-")
    return true

}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; PIXEL CHECKS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; isInventoryOpen Function
; Description: Checks if the inventory is open by searching for the hoverboard color at defined coordinates.
; Operation:
;   - Defines the coordinates and color for the hoverboard icon.
;   - Uses PixelSearch to detect if the specified color is present at the defined coordinates.
; Dependencies:
;   - PixelSearch: Searches a rectangular area of the screen for a pixel of the specified color.
; Parameters: None
; Return: Boolean value indicating whether the inventory is open.
; ----------------------------------------------------------------------------------------
isInventoryOpen() {
    ; Define the properties for the hoverboard icon.
    hoverboard := Map("Start", [29, 372], "End", [29, 372], "Colour", "0xFF911A", "Tolerance", 2)

    ; Perform pixel search for the hoverboard color.
    return PixelSearch(&foundX, &foundY,
        hoverboard["Start"][1], hoverboard["Start"][2],  
        hoverboard["End"][1], hoverboard["End"][2],  
        hoverboard["Colour"], hoverboard["Tolerance"])
}

; ----------------------------------------------------------------------------------------
; isInventoryButtonCentered Function
; Description: Checks if the inventory button is centered by searching for the specific color at defined coordinates.
; Operation:
;   - Defines the coordinates and color for the inventory button.
;   - Uses PixelSearch to detect if the specified color is present at the defined coordinates.
; Dependencies:
;   - PixelSearch: Searches a rectangular area of the screen for a pixel of the specified color.
; Parameters: None
; Return: Boolean value indicating whether the inventory button is centered.
; ----------------------------------------------------------------------------------------
isInventoryButtonCentered() {
    ; Define the properties for the inventory button.
    inventoryButton := Map("Start", [390, 508], "End", [390, 508], "Colour", "0x15DCCE", "Tolerance", 2)

    ; Perform pixel search for the inventory button color.
    return PixelSearch(&foundX, &foundY,
        inventoryButton["Start"][1], inventoryButton["Start"][2],  
        inventoryButton["End"][1], inventoryButton["End"][2],  
        inventoryButton["Colour"], inventoryButton["Tolerance"])
}

; ----------------------------------------------------------------------------------------
; isItemsTabOpen Function
; Description: Checks if the "Items" tab is open by searching for a specific pixel color.
; Operation:
;   - Defines the coordinates and color of a specific pixel within the "Items" tab icon.
;   - Uses PixelSearch to check if that pixel is present on the screen.
; Dependencies:
;   - PixelSearch: Searches a rectangular area of the screen for a pixel of the specified color.
; Parameters: None
; Return: True if the "Items" tab is open (pixel is found), otherwise False.
; ----------------------------------------------------------------------------------------
isItemsTabOpen() {
    ; Define the coordinates, color, and tolerance for the "Items" tab icon pixel search.
    itemsBoostsLine := Map("Start", [301, 152], "End", [301, 152], "Colour", "0xE9E9E9", "Tolerance", 2)    

    ; Perform pixel search within specified coordinates and color.
    return PixelSearch(&foundX, &foundY,  
        itemsBoostsLine["Start"][1], itemsBoostsLine["Start"][2],  
        itemsBoostsLine["End"][1], itemsBoostsLine["End"][2],  
        itemsBoostsLine["Colour"], itemsBoostsLine["Tolerance"])    
}

; ----------------------------------------------------------------------------------------
; isInventorySearchBoxSelected Function
; Description: Checks if the inventory search box is selected by searching for a specific pixel color.
; Operation:
;   - Defines the coordinates and color of a specific pixel within the search cursor.
;   - Uses PixelSearch to check if that pixel is present on the screen.
; Dependencies:
;   - PixelSearch: Searches a rectangular area of the screen for a pixel of the specified color.
; Parameters: None
; Return: True if the search cursor is found (indicating the search box is selected), otherwise False.
; ----------------------------------------------------------------------------------------
isInventorySearchBoxSelected() {
    searchCursor := Map("Start", [620, 118], "End", [650, 118], "Colour", "0xAFAFAF", "Tolerance", 2)
    return PixelSearch(&foundX, &foundY,  ; Perform pixel search within specified coordinates and color.
        searchCursor["Start"][1], searchCursor["Start"][2], 
        searchCursor["End"][1], searchCursor["End"][2],  
        searchCursor["Colour"], searchCursor["Tolerance"])  
}

; ----------------------------------------------------------------------------------------
; isSearchTermEntered Function
; Description: Checks if a search term is entered in the inventory search box by searching for a specific pixel color.
; Operation:
;   - Defines the coordinates and color of a specific pixel within the search term.
;   - Uses PixelSearch to check if that pixel is present on the screen.
; Dependencies:
;   - PixelSearch: Searches a rectangular area of the screen for a pixel of the specified color.
; Parameters: None
; Return: True if the search term pixel is found (indicating a search term is entered), otherwise False.
; ----------------------------------------------------------------------------------------
isSearchTermEntered() {
    searchTerm := Map("Start", [693, 98], "End", [703, 114], "Colour", "0x1E1E1E", "Tolerance", 2)
    return PixelSearch(&foundX, &foundY,  ; Perform pixel search within specified coordinates and color.
        searchTerm["Start"][1], searchTerm["Start"][2],  
        searchTerm["End"][1], searchTerm["End"][2],  
        searchTerm["Colour"], searchTerm["Tolerance"])  
}

; ----------------------------------------------------------------------------------------
; isOopsWindowOpen Function
; Description: Checks if the "Oops" window is open by searching for a specific pixel color.
; Operation:
;   - Defines the coordinates and color of a specific pixel within the "Oops" window icon.
;   - Uses PixelSearch to check if that pixel is present on the screen.
; Dependencies:
;   - PixelSearch: Searches a rectangular area of the screen for a pixel of the specified color.
; Parameters: None
; Return: True if the "Oops" window icon pixel is found, otherwise False.
; ----------------------------------------------------------------------------------------
isOopsWindowOpen() {
    stupidCat := Map("Start", [301, 152], "End", [301, 152], "Colour", "0xFFB232", "Tolerance", 2)
    return PixelSearch(&foundX, &foundY,  ; Perform pixel search within specified coordinates and color.
        stupidCat["Start"][1], stupidCat["Start"][2], 
        stupidCat["End"][1], stupidCat["End"][2],  
        stupidCat["Colour"], stupidCat["Tolerance"])  
}

; ----------------------------------------------------------------------------------------
; isCombineWindowOpen Function
; Description: Checks if the combine window is open by searching for a specific pixel color.
; Operation:
;   - Defines the coordinates and color of a specific pixel within the left border of the combine window.
;   - Uses PixelSearch to check if that pixel is present on the screen.
; Dependencies:
;   - PixelSearch: Searches a rectangular area of the screen for a pixel of the specified color.
; Parameters: None
; Return: True if the combine window left border pixel is found, otherwise False.
; ----------------------------------------------------------------------------------------
isCombineWindowOpen() {
    leftBorder := Map("Start", [160, 366], "End", [160, 366], "Colour", "0x2A2B31", "Tolerance", 2)
    return PixelSearch(&foundX, &foundY,  ; Perform pixel search within specified coordinates and color.
        leftBorder["Start"][1], leftBorder["Start"][2], 
        leftBorder["End"][1], leftBorder["End"][2],  
        leftBorder["Colour"], leftBorder["Tolerance"])      
}

; ----------------------------------------------------------------------------------------
; isSuccessWindowOpen Function
; Description: Checks if the success window is open by searching for a specific pixel color.
; Operation:
;   - Defines the coordinates and color of a specific pixel within the left border of the success window.
;   - Uses PixelSearch to check if that pixel is present on the screen.
; Dependencies:
;   - PixelSearch: Searches a rectangular area of the screen for a pixel of the specified color.
; Parameters: None
; Return: True if the success window left border pixel is found, otherwise False.
; ----------------------------------------------------------------------------------------
isSuccessWindowOpen() {
    leftBorder := Map("Start", [169, 366], "End", [169, 366], "Colour", "0x2A2B31", "Tolerance", 2)
    return PixelSearch(&foundX, &foundY,  ; Perform pixel search within specified coordinates and color.
        leftBorder["Start"][1], leftBorder["Start"][2], 
        leftBorder["End"][1], leftBorder["End"][2],  
        leftBorder["Colour"], leftBorder["Tolerance"])      
}

; ----------------------------------------------------------------------------------------
; hasItem Function
; Description: Checks if an item is present by searching for a specific pixel color.
; Operation:
;   - Defines the coordinates and color of a specific pixel within the item icon.
;   - Uses PixelSearch to check if that pixel is present on the screen.
; Dependencies:
;   - PixelSearch: Searches a rectangular area of the screen for a pixel of the specified color.
; Parameters: None
; Return: True if the item icon pixel is found, otherwise False.
; ----------------------------------------------------------------------------------------
hasItem() { 
    item1 := Map("Start", [109, 235], "End", [109, 235], "Colour", "0xFCFDFD", "Tolerance", 2)
    return !PixelSearch(&foundX, &foundY,  ; Perform pixel search within specified coordinates and color.
        item1["Start"][1], item1["Start"][2], 
        item1["End"][1], item1["End"][2],  
        item1["Colour"], item1["Tolerance"])
}

; ----------------------------------------------------------------------------------------
; isItemKey Function
; Description: Checks if the item is a key by searching for specific key colors in defined coordinates.
; Operation:
;   - Defines the coordinates and colors for different keys.
;   - Uses PixelSearch to detect if the specified colors are present in the defined coordinates.
; Dependencies:
;   - PixelSearch: Searches a rectangular area of the screen for a pixel of the specified color.
; Parameters: None
; Return: Boolean value indicating whether the item is a key.
; ----------------------------------------------------------------------------------------
isItemKey() {
    ; Define the properties for Crystal Key
    crystalKey := Map("Start", [109, 235], "End", [109, 235], "Colour", "0x5EE2F6", "Tolerance", 2)

    ; Perform pixel search for Crystal Key
    if PixelSearch(&foundX, &foundY,
        crystalKey["Start"][1], crystalKey["Start"][2], 
        crystalKey["End"][1], crystalKey["End"][2],  
        crystalKey["Colour"], crystalKey["Tolerance"])
        return true  ; Return true if Crystal Key is found

    ; Define the properties for Tech Key
    techKey := Map("Start", [109, 235], "End", [109, 235], "Colour", "0x4A84AE", "Tolerance", 2)

    ; Perform pixel search for Tech Key
    if PixelSearch(&foundX, &foundY,
        techKey["Start"][1], techKey["Start"][2], 
        techKey["End"][1], techKey["End"][2],  
        techKey["Colour"], techKey["Tolerance"])
        return true  ; Return true if Tech Key is found

    return false  ; Return false if no key is found
}