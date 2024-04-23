#!/bin/sh

get_brightness(){
    brightnessctl get #| awk '{print int($1*100/255) }'
}

set_brightness(){
    brightnessctl set ${1}
}

${1} ${2}
