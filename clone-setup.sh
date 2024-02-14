#!/bin/bash

set -e

function getCurrentDir() {
    local current_dir="${BASH_SOURCE%/*}"
    if [[ ! -d "${current_dir}" ]]; then current_dir="$PWD"; fi
    echo "${current_dir}"
}

function includeDependencies() {
    # shellcheck source=./setupLibrary.sh
    source "${current_dir}/setupLibrary.sh"
}

function setupNewHostname() {
    echo -ne "Enter the new hostname (Currently $(hostname)):\n"
    read -r newName
    changeHostname "${newName}"

    echo "Hostname is set to ${newName}. Requires reboot to take effect." 
}

current_dir=$(getCurrentDir)
includeDependencies
output_file="output.log"

disableCloudInit

changeSSHServerKeys

setupNewHostname