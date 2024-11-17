#!/bin/bash

set -o errexit
set -o nounset
exec 1>/dev/null

declare -gr\
	INC="1.375"\
	DEC="1.7"\
	MUTE="4.0"\
	UNMUTE="2.5"

ppVol() { printf '%d' "$(pamixer --get-volume)"; }

decVol() {
	declare -i i=1;
	while (( "${i}" < 8 )); do
		pactl set-sink-volume @DEFAULT_SINK@ -"${DEC}"%;
		sleep 0.026;
		((i++));
	done
}

incVol() {
	pactl set-sink-mute @DEFAULT_SINK@ 0;
	declare -i i=1;
	while (( "${i}" <= 8 )); do
		pactl set-sink-volume @DEFAULT_SINK@ +"${INC}"%;
		sleep 0.026;
		((i++));
	done
}

muteUnmute() {
	declare -i preVol;
	preVol=$(<"${XDG_RUNTIME_DIR}/preVol") || preVol=30;

	if (( $(ppVol) > 0 )); then
		ppVol >"${XDG_RUNTIME_DIR}/preVol";
		while (( $(ppVol) > 0 )); do
			pactl set-sink-volume @DEFAULT_SINK@ -"${MUTE}"%;
		done
		pactl set-sink-mute @DEFAULT_SINK@ 1;
	else
		pactl set-sink-mute @DEFAULT_SINK@ 0;
		until (( $(ppVol) >= "${preVol}" )); do
			pactl set-sink-volume @DEFAULT_SINK@ +"${UNMUTE}"%;
		done
	fi
}

usage() {
	cat << EOF >&2
Usage: $(basename "${0}") <operation>

Change volume levels with smooth fade transitions.

Operations:
	-d	decrease volume in diminuendo
	-i	increase volume in crescendo
	-m	al niente/dal niente
		(fade out and mute/unmute and fade in)
Options:
	-h	show this help and exit

Operations are mutually exclusive, e.g. the volume levels
can't be increased and decreased at the same time
EOF
}

errorMsg() {
	declare i;
	for i in "${@}"; do
		printf '%s\n\n' "${i}" >&2;
	done
	usage;
	exit 1;
}

if (( "${#}" == 0 )); then
	errorMsg "Error! no operation specified";
elif (( "${#}" > 1 )); then
	errorMsg "Error! only one operation at a time is allowed";
fi

while getopts ":hdim" opt; do case "${opt}" in
		h)
			usage;
			break;;
		d)
			decVol;
			break;;
		i)
			incVol;
			break;;
		m)
			muteUnmute;
			break;;
		*)
			errorMsg "Error! Invalid parameter: -${OPTARG}";
			break;;
esac done

# vim: ft=sh ts=4 sw=4 ai
