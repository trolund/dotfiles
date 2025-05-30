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

# Move the Spoon folders into Hammerspoon's Spoon directory
echo "📦 Moving Spoon files to Hammerspoon's Spoons directory..."
mv window-manager-spoon/WindowManager.spoon ~/.hammerspoon/Spoons/
mv llm-spoon/AiHelper.spoon ~/.hammerspoon/Spoons/
echo "📦 Spoon files moved."

# copy the init.lua to the .hammerspoon directory
echo "📄 Copying hammerspoon/init.lua to ~/.hammerspoon/init.lua..."
cp hammerspoon/init.lua ~/.hammerspoon/init.lua
echo "📄 hammerspoon/init.lua copied."
