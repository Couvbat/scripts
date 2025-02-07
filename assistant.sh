#!/bin/bash
# filepath: /home/couv/Documents/Dev/Scripts/assistant

# Requires rofi to be installed
# Requires ollama to be installed and configured
# Requires glow to be installed
# Requires wl-clipboard to be installed

# Define functions for each action

# Analyze the text in the clipboard
function clipboard_analysis {
  # The clipboard analysis is executed in a new Alacritty terminal:
  alacritty -e zsh -ic "clear; \
echo 'Clipboard analysis'; \
echo 'Analyzing clipboard with model llava'; \
{ wl-paste | ollama run llava 'Résume en francais le contenu mon presse papier :' | glow -; }; \
read -n1 -s -r -p 'Press any key to exit...' < /dev/tty; \
exec zsh -f"
}

# Analyze an image file 
function visual_analysis {
  clear
  echo "Please choose the image you want to analyze"
  image_path=$(find . -type f -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" | rofi -dmenu -p "Choose an image:")
  alacritty -e zsh -ic "clear; \
echo 'Analyzing image \"$image_path\" with model llava'; \
{ ollama run llava \"Décris moi en francais cette image '$image_path'\" | glow -; }; \
read -n1 -s -r -p 'Press any key to exit...' < /dev/tty; \
exec zsh -f"
}

# Analyze a text file
function file_analysis {
  clear
  echo "Please choose the file you want to analyze"
  file_path=$(find . -type f | rofi -dmenu -p "Choose a file:")
  alacritty -e zsh -ic "clear; \
echo 'Analyzing file \"$file_path\" with model llama3.2'; \
{ cat '$file_path' | ollama run llama3.2 'Analyse le contenu de ce fichier et fais en moi un résumé en francais :' | glow -; }; \
read -n1 -s -r -p 'Press any key to exit...' < /dev/tty; \
exec zsh -f"
}

function chat {
  # For the chat, open a new Alacritty terminal with an interactive session:
  alacritty -e zsh -c "clear; \
echo 'Opening a chat with the model llama3.2'; \
ollama run llama3.2; \
read -n1 -s -r -p 'Press any key to exit...'"
}

while true; do
    # Define options in a newline separated list
    OPTIONS="Clipboard analysis
Visual analysis
File analysis
Chat"

    CHOICE=$(echo "$OPTIONS" | rofi -dmenu -p "Choose an action:" -config ~/Documents/Dev/Scripts/assistant.rasi)

    if [ -z "$CHOICE" ]; then
        break
    fi

    case "$CHOICE" in
        "Clipboard analysis")
            clipboard_analysis
            ;;
        "Visual analysis")
            visual_analysis
            ;;
        "File analysis")
            file_analysis
            ;;
        "Chat")
            chat
            ;;
        *)
            echo "Invalid option"
            ;;
    esac

    # Pause before returning to the menu
    read -p "Press any key to continue..." -n1 -s
    clear
done

clear