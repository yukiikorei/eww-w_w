#!/bin/sh

# TODO: 添加ip地址的获取

close_wifi(){
    nmcli radio wifi off
}

open_wifi(){
    nmcli radio wifi on
}

toggle_wifi(){
    # 用nmcli判断wifi状态，如果打开就关闭，如果关闭就打开
    if nmcli radio wifi | grep -q "enabled"; then
        close_wifi
    else
        open_wifi
    fi
}

check_and_open_wifi(){
    if nmcli radio wifi | grep -q "disabled"; then
        open_wifi
    fi
}

get_wifi_ssid() {
    nmcli -f SSID dev wifi list | awk 'NR>1 && !/--/' 
}

get_status_color(){
    if nmcli radio wifi | grep -q "enabled"; then
        echo '#39c5bb'
    else
        echo '#666677'
    fi
}

get_current_wifi_ssid() {
    if nmcli radio wifi | grep -q "disabled"; then
        echo "wifi off"
        return
    fi
    cws=`nmcli -t -f TYPE,NAME connection show --active | grep 802-11-wireless | awk -F: '{print $2}'`
    if [ -n "$cws" ]; then
        echo $cws
    else
        echo "searching ..."
    fi
}

connect_wifi(){
    ssid="$1"
    password="$2"
    result=""
    if [ -n "$password" ]; then
        result=$(nmcli device wifi connect "$ssid" password "$password" 2>&1)
    else
        result=$(nmcli device wifi connect "$ssid" 2>&1)
    fi

    if echo $result | grep -q "successfully activated"; then
        echo 1
    elif echo $result | grep -q "Secrets were required"; then
        password=$(zenity --entry --title 'Secrets were required' --text "$ssid:" --hide-text)
        if [ -n "$password" ]; then
            connect_wifi "$ssid" "$password"
        fi
    #elif echo $result | grep -q "Secrets is invalid"; then
    #    echo 5
    else     
        zenity --error --title="Wifi Connecting failed" --text="$result"
    fi
}

#写一个函数，用nmcli 扫描wifi，获取他们的ssid和型号强度并返回
get_wifi_info(){
    check_and_open_wifi
    echo '(box 
            :class "wifi-list-box"
            :orientation "vertical"
            :spacing 0
            :halign "start"
            :valign "start"
            ;(button :onclick "eww -c ${configDir} close wifilist" "x")
            (button :halign "start" "SIG SSID")
            '
    ssid_list=$(nmcli -t -f SIGNAL,SSID,IN-USE dev wifi list | awk -F: 'NR>1 && !seen[$2]++ && $2!=""' )
    echo "$ssid_list" | while read line; do
        wifi_info=$(echo $line | awk '{ gsub(":","\t"); print }')
        ssid=$(echo $line | awk -F: '{print $2}')
        echo "(button :halign \"start\"
                      :class \"wifiselect\"  
                      :onclick \"~/Projects/eww-dev/script/wifi.sh \\\"connect_wifi\\\"  \\\"$ssid\\\" & ~/Projects/eww-dev/wincontrol.sh close_window wifilist \"
            \"$wifi_info\"
        )"
    done
    echo ")"
}

${1} "${2}"
