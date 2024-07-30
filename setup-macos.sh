#!/bin/bash

# Define the scripts to be run
SCRIPTS=(
    "install-apps-macos.sh"
    "settings-macos.sh"
    "shell-setup.sh"
)

# Log file location
LOG_FILE="$HOME/setup-macos.log"

# Check if each script exists and is executable
for SCRIPT in "${SCRIPTS[@]}"; do
    if [ ! -f "$SCRIPT" ]; then
        echo "Error: Script $SCRIPT not found in the current directory." | tee -a "$LOG_FILE"
        exit 1
    fi

    if [ ! -x "$SCRIPT" ]; then
        echo "Warning: Script $SCRIPT is not executable. Attempting to set executable permission." | tee -a "$LOG_FILE"
        chmod +x "$SCRIPT"
        if [ ! -x "$SCRIPT" ]; then
            echo "Error: Failed to set executable permission for $SCRIPT." | tee -a "$LOG_FILE"
            exit 1
        fi
    fi
done

# Execute each script in sequence
for SCRIPT in "${SCRIPTS[@]}"; do
    echo "Running $SCRIPT..." | tee -a "$LOG_FILE"
    
    # Execute the script and capture the output
    if ! ./"$SCRIPT" >> "$LOG_FILE" 2>&1; then
        echo "Error: $SCRIPT encountered an error. See the log file $LOG_FILE for details." | tee -a "$LOG_FILE"
        exit 1
    fi

    echo "$SCRIPT completed successfully." | tee -a "$LOG_FILE"
    echo "-------------------------------------" | tee -a "$LOG_FILE"
done

echo "All scripts executed successfully." | tee -a "$LOG_FILE"
exit 0
