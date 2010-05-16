#!/bin/bash

emacs_path () {
	local tool="`basename -- "$0"`"
	case "$tool" in
	emacs)
		local sub_path="Contents/MacOS/Emacs"
		;;
	*)
		local sub_path="Contents/MacOS/bin/$tool"
		;;
	esac
	local def_path="/Applications/Emacs.app"
	local app_path="`launch -n -a Emacs 2>/dev/null`"
	if [[ -z "$app_path" ]]; then
		app_path="$def_path"
	fi
	local bin_path="$app_path/$sub_path"
	if ! [[ -e "$bin_path" ]]; then
		bin_path="`/usr/bin/which -a "$tool" 2>/dev/null | grep -v "$0" | head -1`"
	fi
	echo "$bin_path"
}

echo "`emacs_path`" "$@"
