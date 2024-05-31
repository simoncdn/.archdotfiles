#!/bin/sh

get_active_audio() {
	echo $(wpctl status | grep -A 2 'Audio' | grep '*' | awk '{print $3}' | sed 's/\.//')
}

get_volume() {
	volume=$(wpctl get-volume $1 | awk '{print $2}')
	echo "$volume * 100" | bc | xargs printf "%.0f"
}

device_id=$(get_active_audio)

if [[ $device_id ]]
then
	volume=$(get_volume $device_id)
	if [[ $volume == 0 ]]
	then
		echo "%{F#cb5760}  %{F#fff}${volume}%"
	elif [[ $volume < 25 ]]
	then
		echo "%{F#c59e68}  %{F#fff}${volume}%"
	elif [[ $volume < 50 ]]
	then
		echo "%{F#c59e68}  %{F#fff}${volume}%" 
	else
		echo "%{F#c59e68}  %{F#fff}${volume}%"
	fi
else 
	echo "%{F#cb5760}󰋐"
fi
