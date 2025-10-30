#!/bin/bash
# https://github.com/tm4Bit/fzf-zellij/blob/master/fzj.sh

layout_dir="$HOME/.local/share/zellij/layouts"

EXCLUDE_DIRS=(
    "node_modules"
    "cmake"
    "build"
)

EXCLUDE_FILES=(
    ".git"
    ".next"
    "build"
    "node_modules"
)

DEPENDENCIES=(
    fzf
    zellij
)

for dep in "${DEPENDENCIES[@]}"; do
    if ! command -v "$dep" &>/dev/null; then
        echo "󱧖 -> $dep not found (run: yay -S $dep)"
        exit 1
    fi
done

if [[ $1 == "--help" ]]; then
    echo "  fzj is a shell script that gives extra power to zellij using fzf

  USAGE:
    fzj [option]

  OPTIONS:
    -s    list sessions
    -a    create new session
    -l    list layouts
    -y    save current layout

    --help  show this message"
    exit 0
fi

if [ $# == 1 ]; then
    if [ $1 == "-s" ]; then
        if [ $(zellij ls | wc -l) == 0 ]; then
            zellij --session default
        else
            # Extract session names, stripping ANSI color codes
            session_list_cmd="zellij ls | cut -c 8- | cut -d ' ' -f1 | sed -r 's/\x1B\[[0-9;]*[mK]//g'"

            # rename session is only possible from withing the session
            # https://zellij.dev/documentation/plugin-api-commands.html?highlight=rename%20sessio#rename_session
            fzf_opts=(
                --bind 'alt-a:accept'
                --bind "alt-d:execute(zellij delete-session --force {})+reload($session_list_cmd)"
                --header '[A-a] attach | [A-d] delete'
            )

            session=$(eval "$session_list_cmd" | fzf "${fzf_opts[@]}")

            if [[ $session ]]; then
                zellij a "$session"
            else
                echo "done"
            fi
        fi
    elif [ $1 == "-a" ]; then
        read -p "Enter new ses name: " sesName
        if [[ -z "$sesName" ]]; then
            echo "Error: No input provided." >&2
            exit 1
        fi
        zellij --session $sesName
    elif [ $1 == "-y" ]; then
        # set -x
        read -p "Enter layout name (without .kdl extension): " layout_name

        # Construct full file path
        layout_file="${layout_dir}/${layout_name}.kdl"

        # Ensure target directory exists
        mkdir -p "$layout_dir"

        # Check if file already exists
        if [ -e "$layout_file" ]; then
            read -p "File '$layout_file' already exists. Overwrite? (y/n): " answer
            case "$answer" in
            [Yy]*)
                zellij action dump-layout >"$layout_file"
                echo "Layout saved to $layout_file"
                ;;
            *)
                echo "Operation cancelled."
                ;;
            esac
        else
            zellij action dump-layout >"$layout_file"
            echo "Layout saved to $layout_file"
        fi
    elif [ $1 == "-l" ]; then
        if [[ ! -d "$layout_dir" ]]; then
            echo "Error: Directory '$layout_dir' does not exist." >&2
            exit 1
        fi

        # Use find to get all .kdl files, safely handle no matches
        mapfile -t files < <(find "$layout_dir" -type f -name "*.kdl")
        if [[ ${#files[@]} -eq 0 ]]; then
            echo "No .kdl files found in '$layout_dir'." >&2
            exit 1
        fi

        # Create an associative array to map filenames to full paths
        declare -A file_map
        for path in "${files[@]}"; do
            filename=$(basename "$path")
            file_map["$filename"]="$path"
        done

        # Configure fzf with keybinds for layout management
        layout_fzf_opts=(
            --bind "alt-l:execute(zellij -l ${layout_dir}/{})+abort"
            --bind "alt-d:execute(rm ${layout_dir}/{})+reload(find $layout_dir -type f -name '*.kdl' -printf '%f\n' 2>/dev/null || echo '')"
            --header '[A-l] load layout | [A-d] delete layout'
        )

        # Show only filenames in fzf with keybinds
        selected_filename=$(printf '%s\n' "${!file_map[@]}" | fzf "${layout_fzf_opts[@]}")

        # Check if selection was made (only matters for default behavior)
        if [[ -z "$selected_filename" ]]; then
            echo "No action taken." >&2
            exit 0
        fi
    else
        echo "ERROR: invalid command: fzj $1 [value]"
    fi
else
    echo "ERROR: no params given mfka"
fi
