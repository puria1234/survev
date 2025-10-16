#!/bin/bash

# survev Auto-Launcher - Starts client and server in separate terminal tabs
# This requires iTerm2 or Terminal.app on macOS

echo "🚀 Launching survev services..."

# Get the project directory
PROJECT_DIR="$PWD"

# Detect terminal type
if [ "$TERM_PROGRAM" = "iTerm.app" ]; then
    # iTerm2
    osascript <<EOF
tell application "iTerm"
    # Create a new window
    set newWindow to (create window with default profile)
    
    tell current session of newWindow
        write text "cd '$PROJECT_DIR' && pnpm dev:client"
        set name to "Client Dev Server"
    end tell
    
    tell newWindow
        create tab with default profile
        tell current session
            write text "cd '$PROJECT_DIR' && pnpm dev:server"
            set name to "Game + API Server"
        end tell
    end tell
end tell
EOF
else
    # Terminal.app
    osascript <<EOF
tell application "Terminal"
    # Client Dev Server
    do script "cd '$PROJECT_DIR' && echo '⚛️  Starting Client Dev Server...' && pnpm dev:client"
    
    # Game + API Server
    do script "cd '$PROJECT_DIR' && echo '🎮 Starting Game + API Server...' && pnpm dev:server"
    
    activate
end tell
EOF
fi

echo "✅ All services launched in separate terminal windows!"
echo ""
echo "📝 Access your server at:"
echo "   Local:   http://localhost:3000"
echo "   Network: http://YOUR_LOCAL_IP:3000"
echo ""
echo "To find your local IP: ifconfig | grep 'inet ' | grep -v 127.0.0.1"
