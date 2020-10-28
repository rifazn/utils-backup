#!/bin/sh

change_status() {
    display=$1
    mode=$2
    swaymsg "output $display $mode"
}

selection=""
display_status=$(swaymsg -t get_outputs)
len=$(echo $display_status | jq 'length')

for (( i=0; i<$len; i++ ))
do
    selection=$(echo $display_status | jq -r ".["$i"] | .name")
    test $1 = $selection && break
done

is_active=$(echo $display_status | jq -r ".["$i"] | .active")

test $is_active = "true" && change_status $1 "disable" \
    || change_status $1 "enable"
