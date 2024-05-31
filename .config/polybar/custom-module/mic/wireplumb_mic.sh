#!/bin/sh

get_active_mic() {
	echo $(wpctl status | grep '\*' | sed -n '2p' | awk '{print $3}' | sed 's/\.//')
}

get_volume() {
	volume=$(wpctl get-volume $1 | awk '{print $2}')
	echo "$volume * 100" | bc | xargs printf "%.0f"
}

device_id=$(get_active_mic)

if [[ $device_id ]]
then
	volume=$(get_volume $device_id)
	if [[ $volume == 0 ]]
	then
		echo "%{F#cb5760}  %{F#fff}${volume}%"
	else
		echo "%{F#c59e68} %{F#fff}${volume}%"
	fi
else 
	echo "%{F#cb5760}"
fi
