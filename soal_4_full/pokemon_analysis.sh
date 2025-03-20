#!/bin/bash

# Seni ASCII untuk antarmuka
ASCII_ART="
────────▄███████████▄────────
─────▄███▓▓▓▓▓▓▓▓▓▓▓███▄─────
────███▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓███────
───██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██───
──██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██──
─██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██─
██▓▓▓▓▓▓▓▓▓███████▓▓▓▓▓▓▓▓▓██
██▓▓▓▓▓▓▓▓██░░░░░██▓▓▓▓▓▓▓▓██
██▓▓▓▓▓▓▓██░░███░░▓▓▓▓▓▓▓▓▓██
███████████░░███░░███████████
██░░░░░░░██░░███░░██░░░░░░░██
██░░░░░░░░██░░░░░██░░░░░░░░██
██░░░░░░░░░███████░░░░░░░░░██
─██░░░░░░░░░░░░░░░░░░░░░░░██─
──██░░░░░░░░░░░░░░░░░░░░░██──
───██░░░░░░░░░░░░░░░░░░░██───
────███░░░░░░░░░░░░░░░███────
─────▀███░░░░░░░░░░░███▀─────
────────▀███████████▀────────

P O K E M O N   A N A L Y S I S
"
show_help_menu() {
    echo "$ASCII_ART"
    echo "Usage: $0 <filename.csv> [options]"
    echo
    echo "Options:"
    echo "  --filter <type>      Filter Pokémon by type (e.g., Water, Fire, Grass)"
    echo "  --grep <name>        Search Pokémon by name (e.g., Rotom)"
    echo "  --stats              Show Pokémon usage statistics"
    echo "  --sort <column>      Sort Pokémon by specified column (usage, raw, name, hp, atk, def, spatk, spdef, speed)"
    echo "  --info               Show summary of the CSV file"
    echo "  --help           Show this help screen"
    echo "Note: Only one option should be used at a time."
}

if [ $# -eq 0 ]; then
    echo "Error: No arguments provided."
    show_help_menu
    exit 1
fi


if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    show_help_menu
    exit 0
fi


VALIDASI_CSV_FILE="$1"
if [ ! -f "$VALIDASI_CSV_FILE" ]; then
    echo "Error: File '$VALIDASI_CSV_FILE' not found."
    show_help_menu
    exit 1
fi

if [ "$2" = "-h" ] || [ "$2" = "--help" ]; then
    show_help_menu
    exit 0
fi

shift  # Pindah ke opsi berikutnya setelah nama file


if [ $# -eq 0 ]; then
    echo "Error: No option provided. Please use one of the following options:"
    show_help_menu
    exit 1
fi

case "$1" in
    --filter)
        if [ $# -lt 2 ]; then
            echo "Error: No filter option provided"
            show_help_menu
            exit 1
        fi
        FILTER_TYPE="$2"
        awk -F, -v type="$FILTER_TYPE" '
            NR==1 {print $0}  # Cetak header
            NR>1 && (tolower($4)==tolower(type) || tolower($5)==tolower(type)) {print $0}
        ' "$VALIDASI_CSV_FILE"
        shift 2
        ;;
    --grep)
        if [ $# -lt 2 ]; then
            echo "Error: No search term provided"
            show_help_menu
            exit 1
        fi
        SEARCH_TERM="$2"
        echo "Pokémon matching '$SEARCH_TERM':"
        echo "----------------------------------------"
        awk -F, -v term="$SEARCH_TERM" '
            BEGIN {
                printf "%-15s %-10s %-10s %-10s %-10s %-5s %-5s %-5s %-5s %-5s %-5s\n",
                "Pokemon", "Usage%", "RawUsage", "Type1", "Type2", "HP", "Atk", "Def", "SpAtk", "SpDef", "Speed"
                print "-------------------------------------------------------------"
            }
            NR==1 {next}  # Skip header
            tolower($1) ~ tolower(term) {
                printf "%-15s %-10s %-10s %-10s %-10s %-5s %-5s %-5s %-5s %-5s %-5s\n",
                $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11
            }
        ' "$VALIDASI_CSV_FILE"
        shift 2
        ;;
    --stats)
        echo "Displaying Pokémon usage statistics..."
        highest_usage=$(tail -n +2 "$VALIDASI_CSV_FILE" | sort -t, -k2 -nr | head -1)
        highest_usage_pokemon=$(echo "$highest_usage" | cut -d, -f1)
        highest_usage_value=$(echo "$highest_usage" | cut -d, -f2)
        highest_raw=$(tail -n +2 "$VALIDASI_CSV_FILE" | sort -t, -k3 -nr | head -1)
        highest_raw_pokemon=$(echo "$highest_raw" | cut -d, -f1)
        highest_raw_value=$(echo "$highest_raw" | cut -d, -f3)
        echo "Highest Adjusted Usage:  $highest_usage_pokemon with $highest_usage_value%"
        echo "Highest Raw Usage:       $highest_raw_pokemon with $highest_raw_value uses"
        shift
        ;;
    --info)
        echo "Summary of $VALIDASI_CSV_FILE"

        highest_usage=$(tail -n +2 "$VALIDASI_CSV_FILE" | sort -t, -k2 -nr | head -1)
        highest_usage_pokemon=$(echo "$highest_usage" | cut -d, -f1)
        highest_usage_value=$(echo "$highest_usage" | cut -d, -f2)
        highest_raw=$(tail -n +2 "$VALIDASI_CSV_FILE" | sort -t, -k3 -nr | head -1)
        highest_raw_pokemon=$(echo "$highest_raw" | cut -d, -f1)
        highest_raw_value=$(echo "$highest_raw" | cut -d, -f3)
        echo "Highest Adjusted Usage:  $highest_usage_pokemon with $highest_usage_value%"
        echo "Highest Raw Usage:       $highest_raw_pokemon with $highest_raw_value uses"
        shift
        ;;
    --sort)
        if [ $# -lt 2 ]; then
            echo "Error: No sort column provided"
            show_help_menu
            exit 1
        fi
        column="$2"
        case "$column" in
            "usage") sort_col=2; sort_type="numeric" ;;
            "raw") sort_col=3; sort_type="numeric" ;;
            "name") sort_col=1; sort_type="alpha" ;;
            "hp") sort_col=6; sort_type="numeric" ;;
            "atk") sort_col=7; sort_type="numeric" ;;
            "def") sort_col=8; sort_type="numeric" ;;
            "spatk") sort_col=9; sort_type="numeric" ;;
            "spdef") sort_col=10; sort_type="numeric" ;;
            "speed") sort_col=11; sort_type="numeric" ;;
            *)
                echo "Error: Invalid column '$column'"
                show_help_menu
                exit 1
                ;;
        esac
        
        if [ "$sort_type" == "alpha" ]; then
            (head -n 1 "$VALIDASI_CSV_FILE"; tail -n +2 "$VALIDASI_CSV_FILE" | sort -t, -k"$sort_col")
        else
            (head -n 1 "$VALIDASI_CSV_FILE"; tail -n +2 "$VALIDASI_CSV_FILE" | sort -t, -k"$sort_col" -n)
        fi
        shift 2
        ;;
    *)
        echo "Error: Unknown option '$1'"
        show_help_menu
        exit 1
        ;;
esac

if [ $# -gt 0 ]; then
    echo "Error: Too many options provided. Only one option should be used at a time."
    show_help_menu
    exit 1
fi
