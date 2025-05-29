#!/bin/bash

# Clone both repositories
echo "🔄 Cloning Hammerspoon Spoon repositories..."
git clone https://github.com/trolund/window-manager-spoon.git
git clone https://github.com/trolund/llm-spoon.git
echo "🔄 Repositories cloned."

# Ensure target Spoon directory exists
echo "📂 Ensuring Hammerspoon's Spoons directory exists..."
mkdir -p ~/.hammerspoon/Spoons
echo "📂 Spoons directory is ready."

# Copy the Spoon folders into Hammerspoon's Spoon directory
echo "📦 Copying Spoon files to Hammerspoon's Spoons directory..."
cp -r window-manager-spoon/WindowManager.spoon ~/.hammerspoon/Spoons/
cp -r llm-spoon/AiHelper.spoon ~/.hammerspoon/Spoons/
echo "📦 Spoon files copied."

# copy the init.lua to the .hammerspoon directory
echo "📄 Copying hammerspoon/init.lua to ~/.hammerspoon/init.lua..."
cp hammerspoon/init.lua ~/.hammerspoon/init.lua
echo "📄 hammerspoon/init.lua copied."
