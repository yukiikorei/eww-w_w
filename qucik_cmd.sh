#!/bin/sh

star_eww(){
    eww -c . daemon
}

kill_daemon(){
    # kill掉名字中含有eww的进程
    ps -A | grep '.eww-wrapped' | awk '{print $1}' | xargs kill -9
}

reload_config(){
    eww -c . reload
}

openw(){
    eww -c . open "example"
}

close(){
    eww -c . close "example"
}
