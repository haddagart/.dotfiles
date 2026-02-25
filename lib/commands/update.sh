#!/bin/bash
source "$(dirname "$0")/../console.sh"

log "Updating system ..."
sudo apt full-upgrade -y
log "Cleaning up ..."
sudo apt autoremove -y
log "Cleaning done."
