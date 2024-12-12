#!/usr/bin/env bash

# Colors for ROFI menu
declare -r FG_COLOR="#bbbbbb"
declare -r BG_COLOR="#111111"
declare -r HLFG_COLOR="#111111"
declare -r HLBG_COLOR="#bbbbbb"
declare -r BORDER_COLOR="#222222"

# ROFI options
declare -r ROFI_THEME="~/.config/rofi/power-profiles.rasi"

# List of available GPU power profiles
declare -A gpu_profiles=(
    ["Integrated"]="supergfxctl -m Integrated"
    ["Hybrid"]="supergfxctl -m Hybrid"
    ["AsusMuxDgpu"]="supergfxctl -m AsusMuxDgpu"
)

# Prepare ROFI launcher options
launcher_options=(
    -dmenu -i -lines "${#gpu_profiles[@]}"
    -p "Select GPU Profile:"
    -bc "${BORDER_COLOR}" -bg "${BG_COLOR}" -fg "${FG_COLOR}"
    -hlfg "${HLFG_COLOR}" -hlbg "${HLBG_COLOR}"
    -theme "${ROFI_THEME}"
)

# Display the ROFI menu and get user selection
selected_profile=$(printf '%s\n' "${!gpu_profiles[@]}" | sort | rofi "${launcher_options[@]}")

# Check if a selection was made and execute the corresponding command
if [[ -n "${selected_profile}" && -v gpu_profiles["${selected_profile}"] ]]; then
    # Confirmation prompt
    confirmation=$(echo -e "Yes\nNo" | rofi -dmenu -i -lines 2 -p "Confirm ${selected_profile}?" \
        -bc "${BORDER_COLOR}" -bg "${BG_COLOR}" -fg "${FG_COLOR}" \
        -hlfg "${HLFG_COLOR}" -hlbg "${HLBG_COLOR}" -theme "${ROFI_THEME}")

    if [[ "${confirmation}" == "Yes" ]]; then
        # Execute the selected GPU profile command
        ${gpu_profiles[${selected_profile}]}

        # Logout the user in bspwm
        bspc quit
    fi
fi

