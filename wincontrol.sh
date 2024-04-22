#!/bin/sh

#config_dir="$HOME/.config/eww"
config_dir="$HOME/Projects/eww-dev"

open_window(){
    eww -c $config_dir open "$1"
}

close_window(){
    eww -c $config_dir close "$1"
}

close_all_window(){
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
        close_all_window
    else
        open_window "wifi_state_win" &
        open_window "wifi_show_list_win" &
        open_window "music_win" &
        open_window "bt_state_win" &
        open_window "volume_win" &
        open_window "brightness_win" & 
        open_window "system_win" 
    fi
}

${1} ${2}
