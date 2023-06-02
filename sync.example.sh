#!/usr/bin/env bash

# EXAMPLE #
# Just a quick script to sync this project from your dev machine to an infrastructure management machine 
# Run this from VSCode with WSL

rsync ./env.sh user@1.2.3.4:~/project-directory
rsync -rP --delete ./ansible user@1.2.3.4:~/project-directory
rsync -rP --delete ./packer user@1.2.3.4:~/project-directory
rsync -rP --delete ./terraform user@1.2.3.4:~/project-directory