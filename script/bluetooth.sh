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

toggle_bt(){
    if bluetoothctl show | grep -q "Powered: yes";then
        bluetoothctl power off
    else
        bluetoothctl power on
    fi
}

${1}
