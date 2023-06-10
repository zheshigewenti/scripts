#!/bin/bash

get_battery_combined_percent() {

	# get charge of all batteries, combine them
	total_charge=$(expr $(acpi -b | awk '{print $4}' | grep -Eo "[0-9]+" | paste -sd+ | bc));

	# get amount of batteries in the device
	battery_number=$(acpi -b | wc -l);

	percent=$(expr $total_charge / $battery_number);

	if $(acpi -b | grep --quiet Discharging)
		then echo "$percent%";
		else echo "  "
	fi
}

get_battery_charging_status() {

	if $(acpi -b | grep --quiet Discharging)
	then
		echo "no charging";
	else # acpi can give Unknown or Charging if charging, https://unix.stackexchange.com/questions/203741/lenovo-t440s-battery-status-unknown-but-charging
		echo "charging";
	fi
}

print_bat(){
	echo "$(get_battery_charging_status), $(get_battery_combined_percent)";
}

print_date(){
	date '+%Y/%m/%d  %H:%M'
}

show_record(){
	test -f /tmp/r2d2 || return
	rp=$(cat /tmp/r2d2 | awk '{print $2}')
	size=$(du -h $rp | awk '{print $1}')
	echo " $size $(basename $rp)"
}


LOC=$(readlink -f "$0")
DIR=$(dirname "$LOC")
export IDENTIFIER="unicode"


dwm_alsa() {
    VOL=$(amixer get Master | tail -n1 | sed -r "s/.*\[(.*)%\].*/\1/")
    MUTE=$(amixer get Master | tail -n1 | sed -r "s/.*\[(on|off)\].*/\1/")
    if [ "$IDENTIFIER" = "unicode" ]; then
        if [ "$VOL" -eq 0 ] || [ "$MUTE" = "off" ]; then
            printf "    "
        else
            printf " %s%%" "$VOL"
        fi
    else
        if [ "$VOL" -eq 0 ]; then
            printf "MUTE"
        else
            printf "VOL %s%%" "$VOL"
        fi
    fi
}

xsetroot -name "    $(dwm_alsa)  [ $(print_bat) ] $(show_record) $(print_date)    "
exit 0
