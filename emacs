#!/bin/bash

emacs_path () {
    local sub_path="Contents/MacOS/Emacs"
    local def_path="/Applications/Emacs.app"
    local app_path="$(launch -n -a Emacs 2>/dev/null)"
    if [[ -z "$app_path" ]]; then
        app_path="$def_path"
    fi
    echo "$app_path/$sub_path"
}

exec "$(emacs_path)" "$@"
