#!/bin/sh

#config_dir="$HOME/.config/eww"
config_dir="$HOME/Projects/eww-dev"

open_window(){
    eww -c $config_dir open "$1"
}

close_window(){
    eww -c $config_dir close "$1"
}

close_all_windows(){
    eww -c $config_dir close-all
}

toggle_window(){
    if eww -c $config_dir windows | grep -q "\*$1"; then
        close_window "$1"
    else
        open_window "$1"
    fi
}

toggle_main(){
    if eww -c $config_dir windows | grep -q "\*"; then
        close_all_windows
    else
        eww -c $config_dir open-many "wifi_win" "music_win" "bt_state_win" "volume_win" "brightness_win"  "system_win" 
    fi
}

${1} ${2}
