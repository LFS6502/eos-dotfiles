local KEYCODES = Enum.KeyCode
local USER_INPUT_TYPES = Enum.UserInputType
local HIGH_PRIORITY = Enum.ContextActionPriority.High.Value
-- local MEDIUM_PRIORITY = Enum.ContextActionPriority.Medium.Value
-- local LOW_PRIORITY = Enum.ContextActionPriority.Low.Value
local DEFAULT_PRIORITY = Enum.ContextActionPriority.Default.Value

local CONTEXT_ACTIONS = {
    ["Camera"] = {
        Enabled = true,
        Actions = {
            ["Cycle View"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = true,
                PriorityLevel = DEFAULT_PRIORITY,
                InputTypes = {KEYCODES.V},
                SecondaryInputTypes = {},
            },
            ["Free Look"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = true,
                PriorityLevel = DEFAULT_PRIORITY,
                InputTypes = {KEYCODES.C},
                SecondaryInputTypes = {},
            },
            ["Change Shoulder"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = true,
                PriorityLevel = DEFAULT_PRIORITY,
                InputTypes = {KEYCODES.T},
                SecondaryInputTypes = {},
            },
        },
    },
    ["Gun"] = {
        Enabled = false,
        Actions = {
            ["Fire"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = true,
                PriorityLevel = HIGH_PRIORITY,
                InputTypes = {USER_INPUT_TYPES.MouseButton1},
                SecondaryInputTypes = {},
            },
            ["Aim"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = true,
                PriorityLevel = DEFAULT_PRIORITY,
                InputTypes = {USER_INPUT_TYPES.MouseButton2},
                SecondaryInputTypes = {},
            },
            ["Reload"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = true,
                PriorityLevel = DEFAULT_PRIORITY,
                InputTypes = {KEYCODES.R},
                SecondaryInputTypes = {},
            },
            ["Unfold Stock"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = true,
                PriorityLevel = DEFAULT_PRIORITY,
                InputTypes = {KEYCODES.X},
                SecondaryInputTypes = {},
            },
            ["Fire mode"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = true,
                PriorityLevel = DEFAULT_PRIORITY,
                InputTypes = {KEYCODES.Q},
                SecondaryInputTypes = {},
            },
        },
    },
    ["Character"] = {
        Enabled = true,
        Actions = {
            ["Walk Forwards"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = false,
                PriorityLevel = HIGH_PRIORITY,
                InputTypes = {KEYCODES.W},
                SecondaryInputTypes = {},
            },
            ["Walk Left"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = false,
                PriorityLevel = HIGH_PRIORITY,
                InputTypes = {KEYCODES.A},
                SecondaryInputTypes = {},
            },
            ["Walk Right"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = false,
                PriorityLevel = HIGH_PRIORITY,
                InputTypes = {KEYCODES.D},
                SecondaryInputTypes = {},
            },
            ["Walk Backwards"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = false,
                PriorityLevel = HIGH_PRIORITY,
                InputTypes = {KEYCODES.S},
                SecondaryInputTypes = {},
            },
            ["Jump"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = true,
                PriorityLevel = HIGH_PRIORITY,
                InputTypes = {KEYCODES.Space},
                SecondaryInputTypes = {},
            },
            ["Sprint"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = false,
                PriorityLevel = HIGH_PRIORITY,
                InputTypes = {KEYCODES.LeftShift},
                SecondaryInputTypes = {},
            },
            ["Sprint Lock"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = false,
                PriorityLevel = HIGH_PRIORITY,
                InputTypes = {KEYCODES.RightShift},
                SecondaryInputTypes = {},
            },

            -- THIS IS A TEST ACTION
            ["Ragdoll"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = false,
                PriorityLevel = DEFAULT_PRIORITY,
                InputTypes = {KEYCODES.Minus},
                SecondaryInputTypes = {},
            },
        },
    },
    ["Chat"] = {
        Enabled = true,
        Actions = {
            ["Use"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = false,
                PriorityLevel = DEFAULT_PRIORITY,
                InputTypes = {KEYCODES.Slash},
                SecondaryInputTypes = {},
            },
            ["Commlink Channel"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = false,
                PriorityLevel = DEFAULT_PRIORITY,
                InputTypes = {KEYCODES.LeftBracket},
                SecondaryInputTypes = {},
            },
            ["Holocomm Channel"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = false,
                PriorityLevel = DEFAULT_PRIORITY,
                InputTypes = {KEYCODES.RightBracket},
                SecondaryInputTypes = {},
            },
            ["Local Channel"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = false,
                PriorityLevel = DEFAULT_PRIORITY,
                InputTypes = {KEYCODES.BackSlash},
                SecondaryInputTypes = {},
            },
        },
    },
    ["Gameplay"] = {
        Enabled = true,
        Actions = {
            ["Open Inventory"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = false,
                PriorityLevel = DEFAULT_PRIORITY,
                InputTypes = {KEYCODES.E},
                SecondaryInputTypes = {},
            },
            ["Interact"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = false,
                PriorityLevel = DEFAULT_PRIORITY,
                InputTypes = {KEYCODES.F},
                SecondaryInputTypes = {},
            },
        },
    },
    ["Ground Vehicle"] = {
        Enabled = false,
        Actions = {
            ["Forwards"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = true,
                PriorityLevel = HIGH_PRIORITY,
                InputTypes = {KEYCODES.W},
                SecondaryInputTypes = {},
            },
            ["Turn Left"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = true,
                PriorityLevel = HIGH_PRIORITY,
                InputTypes = {KEYCODES.A},
                SecondaryInputTypes = {},
            },
            ["Turn Right"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = true,
                PriorityLevel = HIGH_PRIORITY,
                InputTypes = {KEYCODES.D},
                SecondaryInputTypes = {},
            },
            ["Reverse"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = true,
                PriorityLevel = HIGH_PRIORITY,
                InputTypes = {KEYCODES.S},
                SecondaryInputTypes = {},
            },
            ["Brakes"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = true,
                PriorityLevel = HIGH_PRIORITY,
                InputTypes = {KEYCODES.Space},
                SecondaryInputTypes = {},
            },
            ["Exit"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = true,
                PriorityLevel = DEFAULT_PRIORITY,
                InputTypes = {KEYCODES.F},
                SecondaryInputTypes = {},
            },
        },
    },
    -- TODO: Implement mouse version of controls
    ["Air Vehicle"] = {
        Enabled = false,
        Actions = {
            ["Throttle Up"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = true,
                PriorityLevel = DEFAULT_PRIORITY,
                InputTypes = {KEYCODES.LeftShift},
                SecondaryInputTypes = {},
            },
            ["Throttle Down"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = true,
                PriorityLevel = DEFAULT_PRIORITY,
                InputTypes = {KEYCODES.LeftControl},
                SecondaryInputTypes = {},
            },
            ["Max Throttle"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = true,
                PriorityLevel = DEFAULT_PRIORITY,
                InputTypes = {KEYCODES.RightShift},
                SecondaryInputTypes = {},
            },
            ["Min Throttle"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = true,
                PriorityLevel = DEFAULT_PRIORITY,
                InputTypes = {KEYCODES.RightControl},
                SecondaryInputTypes = {},
            },
            ["Pitch Up"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = true,
                PriorityLevel = HIGH_PRIORITY,
                InputTypes = {KEYCODES.S, KEYCODES.KeypadFive},
                SecondaryInputTypes = {},
            },
            ["Pitch Down"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = true,
                PriorityLevel = HIGH_PRIORITY,
                InputTypes = {KEYCODES.W, KEYCODES.KeypadEight},
                SecondaryInputTypes = {},
            },
            ["Yaw Left"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = true,
                PriorityLevel = HIGH_PRIORITY,
                InputTypes = {KEYCODES.Q, KEYCODES.KeypadFour},
                SecondaryInputTypes = {},
            },
            ["Yaw Right"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = true,
                PriorityLevel = HIGH_PRIORITY,
                InputTypes = {KEYCODES.E, KEYCODES.KeypadSix},
                SecondaryInputTypes = {},
            },
            ["Roll Left"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = true,
                PriorityLevel = HIGH_PRIORITY,
                InputTypes = {KEYCODES.A, KEYCODES.KeypadSeven},
                SecondaryInputTypes = {},
            },
            ["Roll Right"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = true,
                PriorityLevel = HIGH_PRIORITY,
                InputTypes = {KEYCODES.D, KEYCODES.KeypadNine},
                SecondaryInputTypes = {},
            },
            ["Brakes"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = true,
                PriorityLevel = HIGH_PRIORITY,
                InputTypes = {KEYCODES.Space},
                SecondaryInputTypes = {},
            },
            ["Exit"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = true,
                PriorityLevel = DEFAULT_PRIORITY,
                InputTypes = {KEYCODES.F},
                SecondaryInputTypes = {},
            },
        },
    },
    ["Gunner"] = {
        Enabled = false,
        Actions = {
            ["Fire"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = true,
                PriorityLevel = HIGH_PRIORITY,
                InputTypes = {USER_INPUT_TYPES.MouseButton1},
                SecondaryInputTypes = {},
            },
            ["Aim"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = true,
                PriorityLevel = DEFAULT_PRIORITY,
                InputTypes = {USER_INPUT_TYPES.MouseButton2},
                SecondaryInputTypes = {},
            },
            ["Exit"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = true,
                PriorityLevel = DEFAULT_PRIORITY,
                InputTypes = {KEYCODES.F},
                SecondaryInputTypes = {},
            },
        },
    },
    ["Passenger"] = {
        Enabled = false,
        Actions = {
            ["Exit"] = {
                CreateTouchButton = false,
                CancelOnTextBoxFocus = true,
                PriorityLevel = DEFAULT_PRIORITY,
                InputTypes = {KEYCODES.F},
                SecondaryInputTypes = {},
            },
        },
    },
}

local ContextActionsHandler = {} do
    function ContextActionsHandler:Start(client)
        self.Client = client

        local Context = require(client.Libraries.Context)
        for contextName, contextProps in pairs(CONTEXT_ACTIONS) do
            local context = Context.new(contextName, contextProps.Actions)

            if not contextProps.Enabled then
                context:Disable()
            end
        end
    end
end

return ContextActionsHandler