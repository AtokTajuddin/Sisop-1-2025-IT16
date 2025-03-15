#!/bin/bash

clear

#a.
speak_to_me() {
    while true; do  
        aff=$(curl -s https://www.affirmations.dev | jq -r '.affirmation')
	echo -e "\e[5m$aff\e[0m"
        sleep 1
    done
}

#b
on_the_run() {
    cols=$(tput cols)
    let "track_length = cols - 10"
    
    spinball=("◐" "◓" "◑" "◒")
    track=""

    for ((i = 0; i <= track_length; i++)); do
        index=$((i % 4))
        spinballs=${spinball[$index]}
        track+="_"

        progress=$(( (i * 100) / track_length ))

        echo -ne "\r$track$spinballs [$progress%]"

        sleep $(awk -v min=0.1 -v max=1 'BEGIN{srand(); print min+rand()*(max-min)}')
    done

    echo ""
}

#c
time_display() {
    while true; do
        clear
        hour=$(date +%H)
        date_time="📆 $(date '+%Y-%m-%d') ⏰ $(date '+%H:%M:%S')"

        if ((hour >= 6 && hour < 12)); then
            creature="🌞 Pagi: 😀"
        elif ((hour >= 12 && hour < 15)); then
            creature="🌤️ Siang: 🙂"
        elif ((hour >= 15 && hour < 18)); then
            creature="🌅 Sore: 😕"
        elif ((hour >= 18 && hour < 19)); then
            creature="🌆 Maghrib: 😴"
        else
            creature="🌙 Malam: 😪"
        fi

        echo "$date_time"
        echo "$creature"
        sleep 1
    done
}


#d
money_matrix() {
    symbols=("$" "€" "£" "¥" "¢" "₹" "₩" "₿" "₣")
    colors=(31 32 33 34 35 36 37) 
    cols=$(tput cols)
    lines=$(tput lines)
    while true; do
        clear
        for ((i=0; i<lines; i++)); do
            for ((j=0; j<cols; j++)); do
                if (( RANDOM % 5 == 0 )); then
                    color=${colors[RANDOM % ${#colors[@]}]}
                    printf "\033[%sm%s" "$color" "${symbols[RANDOM % ${#symbols[@]}]}"
                else
                    printf " "
                fi
            done
            echo ""
        done
        sleep 0.1
    done
}



#e
brain_damage() {
    while true; do
        clear
        printf "\033[1;37m%-8s %-10s %-6s %-6s %-15s\033[0m\n" "PID" "USER" "%CPU" "%MEM" "COMMAND"
        echo -e "\033[1;37m--------------------------------------------------------\033[0m"
        ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | head -n 15 | awk 'NR>1 {if (NR%3==1) color="\033[1;32m"; else if (NR%3==2) color="\033[1;35m"; else color="\033[1;33m"; 
        printf "%s%-8s %-10s %-6s %-6s %-15s\033[0m\n", color, $1, $2, $3, $4, $5}'
        sleep 1
    done
}




case "$1" in
    --play="Speak to Me")
        speak_to_me
        ;;
    --play="On the Run")
        on_the_run
        ;;
    --play="Time")
        time_display
        ;;
    --play="Money")
        money_matrix
        ;;
    --play="Brain Damage")
        brain_damage
        ;;
    *)
        exit 1
        ;;
esac

