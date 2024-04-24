#!/bin/sh

get_bt_status(){
    if bluetoothctl show | grep -q "Powered: yes";then
        echo on
    else
        echo off
    fi
}

get_bt_status_color(){
    if bluetoothctl show | grep -q "Powered: yes";then
        echo '#2985bb'
    else
        echo '#666677'
    fi
}

get_bt_state(){
    local state=""
    local color="" 
    if bluetoothctl show | grep -q "Powered: yes";then
        state="on"
        color='#2985bb'
    else
        color='#666677'
        #color='rgba(102,102,119,0.8)'
        state="off"
    fi
    #以json的格式输出state和color
    echo "{\"state\":\"$state\",\"color\":\"$color\"}"
}

toggle_bt(){
    if bluetoothctl show | grep -q "Powered: yes";then
        bluetoothctl power off
    else
        bluetoothctl power on
    fi
}

${1}
