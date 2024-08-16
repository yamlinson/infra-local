#!/usr/bin/env bash

# EXAMPLE #
# Just a quick script to sync this project from your dev machine to an infrastructure management machine 

user="username"
host="hostname"
project="project-name"
dest="$user@$host:~/$project/"

rsync ./env.sh "$dest"
rsync -rP ./ansible --delete "$dest"
rsync -rP ./misc --delete "$dest"
rsync -rP ./packer --delete "$dest"
rsync -rP ./terraform --delete "$dest"
