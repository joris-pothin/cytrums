#!/bin/bash

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
RESET="\033[0m"
UNAME=$(uname)

function print_success {
    echo -e "\n${GREEN}$1${RESET}"
}

function print_error {
    echo -e "\n${RED}$1${RESET}"
}

function print_info {
    echo -e "\n${BLUE}$1${RESET}"
}

function print_debug {
    echo -e "\n${YELLOW}$1${RESET}"
}

function print_default {
    echo -e "\n${RESET}$1"
}

# print_info 'Requirements'
# print_debug ' * Create your SSH key'
# print_default '   ssh-keygen -t ed25519'
# print_default '   eval `ssh-agent`'
# print_default '   ssh-add path-to-ssh-key'
# print_debug '   Add ssh key to your github profile'
# print_debug '   Add your aws credentials in .env.local (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`)'

if [ "$UNAME" == "Linux" ] ; then
  print_debug ' * Install Docker'
  print_info '   https://docs.docker.com/install/linux/docker-ce/ubuntu/'
elif [ "$UNAME" == "Darwin" ] ; then
  print_debug ' * Install Docker for Mac'
  print_info '   https://www.docker.com/products/docker-desktop'
fi

print_debug '   Launch docker application\n'

read -p 'Do you have all requirements (y/n)?' response

if [[ $response != 'y' ]]; then
    exit
fi

print_info 'Installing dependencies'

if ! command -v git; then
    print_error 'Git is not installed.'
    exit;
fi

if [ "$UNAME" == "Darwin" ] ; then
  if ! command -v brew; then
    print_info 'Installing Homebrew...'
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
fi

if ! grep -q "cytrums.local" "/etc/hosts"; then
  print_info 'Adding application hosts to /etc/hosts'
  sudo tee -a /etc/hosts << EOF
# Cytrums
127.0.0.1 cytrums.local api.cytrums.local ob.cytrums.local
EOF
fi

print_success 'All good!'
print_debug 'You may now edit the .env.local file to add your secret keys.'
