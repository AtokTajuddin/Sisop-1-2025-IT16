#!/bin/bash

#!/bin/bash

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

