#!/bin/bash
echo "Updating system ..."
sudo apt full-upgrade -y
echo "Cleaning up ..."
sudo apt autoremove -y
echo "Cleaning done."
