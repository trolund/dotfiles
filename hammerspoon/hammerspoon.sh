# Clone both repositories
git clone https://github.com/trolund/window-manager-spoon.git
git clone https://github.com/trolund/llm-spoon.git

# Ensure target Spoon directory exists
mkdir -p ~/.hammerspoon/Spoons

# Copy the Spoon folders into Hammerspoon's Spoon directory
cp -r window-manager-spoon/Spoons/WindowManager.spoon ~/.hammerspoon/Spoons/
cp -r llm-spoon/Spoons/LLM.spoon ~/.hammerspoon/Spoons/

# copy the init.lua to the .hammerspoon directory
cp init.lua ~/.hammerspoon/init.lua
