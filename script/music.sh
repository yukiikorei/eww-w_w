#!/bin/sh

# TODO: Add support for mutil player
# TODO: Add support for color follow

get_player(){
    palyerctl -l | while read line; do
        echo "TODO!!! lol"
    done
}

toggle_play_music(){
    playerctl play-pause
}

play_pre_song(){
    playerctl previous
}

play_next_song(){
    playerctl next
}

get_play_position(){
    playerctl position
}

get_play_status(){
    playerctl status
}

get_play_status_icon(){
    status=$(playerctl status)
    if [[ $status == "Playing" ]]; then
        echo ""
    else
        echo ""
    fi
}

fet_paly_application(){
    playerctl metadata mpris:trackid | tr -d "'" | awk -F'/' '{ print $(NF) }'
}

get_play_title(){
    playerctl metadata xesam:title
}

get_paly_album(){
    playerctl metadata xesam:album
}

get_play_artist(){
    playerctl metadata xesam:artist
}

get_album_cover(){
    cover_path=$(playerctl metadata mpris:artUrl)
    if [[ $cover_path == file://* ]]; then
        cover_path=${cover_path#file://}
    elif [[ $cover_path == http://* || $cover_path == https://* ]]; then
        filename=$(basename "$cover_path" | sed 's/\?.*//')
        if [[ ! -f /tmp/ewwmusiccover/${filename} ]]; then
            if [[ ! -d /tmp/ewwmusiccover ]]; then
                mkdir /tmp/ewwmusiccover
            fi
            wget -O /tmp/ewwmusiccover/${filename} $cover_path
        fi
        cover_path=/tmp/ewwmusiccover/${filename}
    else
        cover_path="" # 返回空时，图片不会刷新
    fi
    echo $cover_path
}

${1} "${2}"
