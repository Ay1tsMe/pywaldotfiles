#!/bin/sh

. "${HOME}/.cache/wal/swaylock-colors"

conffile="${HOME}/.config/swaylock/config"

# Associative array, color name -> color code.
declare -A colors
colors=(
    ["color"]=$background"80"  # Assuming you want the background color with some transparency
    ["text-color"]=$foreground
    ["line-color"]=$color13
    ["ring-color"]=$color13
    ["inside-color"]=$background
    ["key-hl-color"]=$color1
    ["ring-ver-color"]=$color2
    ["inside-ver-color"]=$color3
    ["line-ver-color"]=$color13
    ["ring-wrong-color"]=$color13
    ["text-wrong-color"]=$foreground
    ["inside-wrong-color"]=$background
    ["inside-clear-color"]=$background
    ["text-clear-color"]=$foreground
    ["ring-clear-color"]=$color13
    ["line-clear-color"]=$color13
    ["bs-hl-color"]=$color9
)

for color_name in "${!colors[@]}"; do
  # replace first occurance of each color in config file
    sed -i "0,/^$color_name.*/{s//$color_name=${colors[$color_name]}/}" $conffile
done
