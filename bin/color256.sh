#!/bin/bash
# http://en.wikipedia.org/wiki/ANSI_escape_code

ESC='\033'
COLOR_DEFAULT="$ESC[0m"
USE_ECHO=1

function output_decoration()
{
    USE_ECHO=0
    MESSAGE="Decoration characters:"
    OUT="echo -e"
    #OUT="printf"

    echo
    echo $MESSAGE
    echo "======================================================================="
    $OUT " 0:  Normal             ${ESC}[0m   Normal         ${COLOR_DEFAULT} "
    $OUT " 1:  Bold               ${ESC}[1m   Bold           ${COLOR_DEFAULT} "
    $OUT " 2:  Faint              ${ESC}[2m   Faint          ${COLOR_DEFAULT} "
    $OUT " 3:  Italic             ${ESC}[3m   Italic         ${COLOR_DEFAULT} "
    $OUT " 4:  Underline          ${ESC}[4m   Underline      ${COLOR_DEFAULT} "
    $OUT " 5:  Blink slow         ${ESC}[5m   Blink slow     ${COLOR_DEFAULT} "
    $OUT " 6:  Blink rapid        ${ESC}[6m   Blink rapid    ${COLOR_DEFAULT} "
    $OUT " 7:  Inverse            ${ESC}[7m   Inverse        ${COLOR_DEFAULT} "
    $OUT " 8:  Conceal            ${ESC}[8m   Conceal        ${COLOR_DEFAULT} "
    $OUT " 9:  Crossed-out        ${ESC}[9m   Crossed-out    ${COLOR_DEFAULT} "
    $OUT " 10: Default font       ${ESC}[10m   Default font   ${COLOR_DEFAULT} "
    $OUT " 11-19: Alternate fonts ${ESC}[11m   Alternate font ${COLOR_DEFAULT} "
    $OUT " 20-39: Inverse effect again code, 0-9 "
    echo

}

function output_color()
{
    COLOR_BASE=$1
    COLOR_MAX=$2
    USE_ECHO=$3
    MESSAGE=$4
    DECORATION=$5

    echo
    echo $MESSAGE
    echo "======================================================================="

    for ((value=$COLOR_BASE ; value<$COLOR_MAX ; value++ )); do
        if [ $USE_ECHO -eq 1 ];then
            echo -ne " ${ESC}[${DECORATION}${value}m  ${value}  ${COLOR_DEFAULT} "
        else
            printf " ${ESC}[${DECORATION}${value}m  %3d  ${COLOR_DEFAULT} " ${value}
        fi
    done
    echo

}

function output_256color()
{
    USE_ECHO=$1
    MESSAGE=$2
    DECORATION=$3

    echo
    echo $MESSAGE
    echo "======================================================================="

    COLOR_BASE=0
    COLOR_MAX=16
    echo "Base color:"
    for ((value=$COLOR_BASE ; value<$COLOR_MAX ; value++ )); do
        if [ $USE_ECHO -eq 1 ];then
            echo -ne " ${ESC}[${DECORATION}${value}m  ${value}  ${COLOR_DEFAULT} "
        else
            printf " ${ESC}[${DECORATION}${value}m  %3d  ${COLOR_DEFAULT} " ${value}
        fi
        if [ $(($value % 8)) -eq 7 ]; then
            echo
        fi
    done
    echo

    COLOR_BASE=16
    COLOR_MAX=232
    echo "6x6 color cube:"
    for ((value=$COLOR_BASE ; value<$COLOR_MAX ; value++ )); do
        if [ $USE_ECHO -eq 1 ];then
            echo -ne " ${ESC}[${DECORATION}${value}m  ${value}  ${COLOR_DEFAULT} "
        else
            printf " ${ESC}[${DECORATION}${value}m  %3d  ${COLOR_DEFAULT} " ${value}
        fi
        if [ $(($value % 6)) -eq 3 ]; then
            echo
        fi
        if [ $(($value % 36)) -eq 15 ]; then
            echo
        fi
    done
    echo

    COLOR_BASE=232
    COLOR_MAX=256
    echo "Grey color cube:"
    for ((value=$COLOR_BASE ; value<$COLOR_MAX ; value++ )); do
        if [ $USE_ECHO -eq 1 ];then
            echo -ne " ${ESC}[${DECORATION}${value}m  ${value}  ${COLOR_DEFAULT} "
        else
            printf " ${ESC}[${DECORATION}${value}m  %3d  ${COLOR_DEFAULT} " ${value}
        fi
        if [ $(($value % 8)) -eq 7 ]; then
            echo
        fi
    done
    echo


}

output_decoration
output_color 30 38 0 "Text 16 color:" "7;"
output_color 30 38 0 "Text 16 bright color:" "1;7;"
output_color 40 48 0 "Background 16 color:"
output_color 40 48 0 "Background 16 bright color:" "1;"
output_256color 0 "Color 256:" "48;5;"

