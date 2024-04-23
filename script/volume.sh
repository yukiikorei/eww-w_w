#!/bin/sh


# 写一个函数，通过pavucontrol获取音量的百分比
get_volume(){
    echo $(pactl list sinks | grep '^[[:space:]]Volume:' | awk -F'/' '{print $2}' | cut -d% -f1)
}

# 写一个函数，通过pactl设置音量的百分比
set_volume(){
    pactl set-sink-volume $(pactl info | grep 'Default Sink' | awk '{print $3}') ${1}%
}

#echo "${1}" "${2}" >> ~/Projects/eww-dev/log
${1} ${2}
