#!/bin/bash

#a

file="$1"

if [[ "$2" == "--info" ]]; then
    echo "Summary of $file"

    highest_usage=$(tail -n +2 "$file" | sort -t, -k2 -nr | head -1)
    highest_usage_pokemon=$(echo "$highest_usage" | cut -d, -f1)
    highest_usage_value=$(echo "$highest_usage" | cut -d, -f2)

    highest_raw=$(tail -n +2 "$file" | sort -t, -k3 -nr | head -1)
    highest_raw_pokemon=$(echo "$highest_raw" | cut -d, -f1)
    highest_raw_value=$(echo "$highest_raw" | cut -d, -f3)

    echo "Highest Adjusted Usage:  $highest_usage_pokemon with $highest_usage_value%"
    echo "Highest Raw Usage:       $highest_raw_pokemon with $highest_raw_value uses"
fi

#b

if [[ "$2" == "--sort" ]]; then
    column="$3"
    
    case "$column" in
        "usage") sort_col=2 ;;
        "raw") sort_col=3 ;;
        "name") sort_col=1 ;;
        "hp") sort_col=6 ;;
        "atk") sort_col=7 ;;
        "def") sort_col=8 ;;
        "spatk") sort_col=9 ;;
        "spdef") sort_col=10 ;;
        "speed") sort_col=11 ;;
        *) echo "Invalid column!"; exit 1 ;;
    esac

    if [[ "$column" == "name" ]]; then
        sort -t, -k"$sort_col" "$file"
    else
        (head -n 1 "$file"; tail -n +2 "$file" | sort -t, -k"$sort_col" -nr)
    fi
fi

