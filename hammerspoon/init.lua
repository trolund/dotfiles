-- Load and configure the AI Spoon 
hs.settings.set("AiHelper.apiKey", "<API_KEY>") -- Set your OpenAI or Cohere API key here
hs.loadSpoon("AiHelper")
spoon.AiHelper:init({
    provider = "openai", -- or "cohere"
    model = "gpt-4o" -- or "command-r-plus"
})
spoon.AiHelper:bindHotkeys({
    rewrite = {{"cmd", "alt", "ctrl"}, "R"}
})

-- Load and configure the Window Manager Spoon
hs.loadSpoon("WindowManager")
spoon.WindowManager:bindHotkeys({})

function reloadConfig(files)
    hs.reload()
end

-- Watch for changes in the Hammerspoon config directory
function reloadConfig(files)
    doReload = false
    for _, file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end

myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")
