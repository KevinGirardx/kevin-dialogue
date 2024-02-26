# Exports
```lua
    /**
        * Sends a dialogue to an entity using the Kevin Dialogue system.
        *
        * @param {number} entity - The entity to send the dialogue to.
        * @param {object} options - The options for the dialogue.
        * @param {string} options.pedName - (OPTIONAL BUT DEFAULTS TO UNKNOWN IF NOT SPECIFIED) The name of the ped speaking the dialogue.
        * @param {string} options.dialogueName - (OPTIONAL) The name of the dialogue.
        * @param {string} options.reputation - (OPTIONAL) The reputation required to trigger the dialogue.
        * @param {string} options.dialogue - The dialogue text.
        * @param {Array<object>} options.buttons - The buttons to display with the dialogue.
        * @param {string} options.buttons.icon - (OPTIONAL BUT DEFAULTS TO CIRCLE ICON IF NOT SPECIFIED) The icon for the button.
        * @param {string} options.buttons.label - The label for the button.
        * @param {string} options.buttons.actionType - The type of action the button performs.
        * @param {string} options.buttons.event - The event triggered by the button.
        * @param {string} options.buttons.type - The type of button (client or server).
        * @param {boolean} options.buttons.shouldClose - Whether the dialogue should close after the button is clicked.
    */
    exports['kevin-dialogue'].SendDialogue(data)

    /**
        * Updates the buttons for the Kevin Dialogue.
        *
        * @param {Object} options - The options for updating the buttons.
        * @param {Array} options.buttons - The array of buttons to update.
        * @param {string} options.buttons.icon - The icon for the button.
        * @param {string} options.buttons.label - The label for the button.
        * @param {string} options.buttons.event - The event triggered when the button is clicked.
        * @param {string} options.buttons.type - The type of the button (e.g., 'server', 'client').
        * @param {boolean} options.buttons.shouldClose - Whether the dialogue should close after the button is clicked.
     */
    exports['kevin-dialogue'].UpdateButtons(data)

    exports['kevin-dialogue'].CloseDialogue()
```


# Example Useage:
```lua
    exports['kevin-dialogue'].SendDialogue(entity, {
        pedName = 'kevin',
        dialogueName = 'script creator',
        reputation = '250',
        dialogue = 'hello, how can i help you today?',
        buttons = {
            {
                icon = 'fas fa-store',
                label = 'open shop',
                actionType = 'server'
                event = 'kevin-scripts:openshop',
                type = 'client',
                shouldClose = true,
            },
        },
    })
```

```lua
    exports['kevin-dialogue'].UpdateButtons({
        buttons = {
            {
                icon = 'fas fa-store',
                label = 'close shop',
                event = 'kevin-scripts:closeshop',
                type = 'client',
                shouldClose = true,
            },
        },
    })
```

```lua
    RegisterNetEvent('kevin-scripts:closeshop', function()
        print('closed shop successfully')
        exports['kevin-dialogue'].CloseDialogue()
    end)
```