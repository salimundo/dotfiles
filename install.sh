#!/bin/bash

# Colors
escape="\\033"
red=${escape}"[31m"
cyan=${escape}"[36m"
green=${escape}"[32m"
reset=${escape}"[0m"

check_sudo() {
  if [[ "$EUID" -ne 0 ]] ; then
    echo "${red}Run with sudo!${reset}"
    exit
  fi
}

get_username() {
  echo -en "${cyan}Enter username: ${reset}"
  read -r user
}

sync_dotfiles() {
  while true ; do
    echo -en "${cyan}Sync dotfiles? ${reset}"
    read -r sync
    case $sync in
      y|yes|Y|Yes)
        ln -sf /home/"${user}"/github/dotfiles/dotfiles/.gitconfig /home/"${user}"/.gitconfig
        ln -sf /home/"${user}"/github/dotfiles/dotfiles/.hyper /home/"${user}"/.hyper
        ln -sf /home/"${user}"/github/dotfiles/dotfiles/.zshrc /home/"${user}"/.zshrc
        return
        ;;
      n|no|N|No)
        return
        ;;
      *)
        echo -e "Enter ${green}[y|yes|Y|Yes]${reset} or ${red}[n|no|N|No]${reset}!"
        continue
        ;;
    esac
  done
}

install_vscode() {
  echo -e "${green}Installing VSCode...${reset}"
  curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
  sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
  sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
  sudo apt-get install apt-transport-https
  sudo apt-get update
  sudo apt-get install code
}

sync_vscode() {
  echo -e "\\n${green}Syncing VSCode...${reset}"
  ln -sf /home/"${user}"/github/dotfiles/vscode/User/snippets /home/"${user}"/.config/Code/User/snippets
  ln -sf /home/"${user}"/github/dotfiles/vscode/User/settings.json /home/"${user}"/.config/Code/User/settings.json
  ln -sf /home/"${user}"/github/dotfiles/vscode/User/keybindings.json /home/"${user}"/.config/Code/User/keybindings.json
}

setup_vscode() {
  while true ; do
    echo -en "${cyan}Install VSCode? ${reset}"
    read -r install
    case $install in
      y|yes|Y|Yes)
        install_vscode
        sync_vscode
        return
        ;;
      n|no|N|No)
        while true ; do
          echo -en "${cyan}Sync VSCode? ${reset}"
          read -r sync
          case $sync in
            y|yes|Y|Yes)
              sync_vscode
              return
              ;;
            n|no|N|No)
              return
              ;;
            *)
              echo -e "Enter ${green}[y|yes|Y|Yes]${reset} or ${red}[n|no|N|No]${reset}!"
              continue
              ;;
          esac
        done
        ;;
      *)
        echo -e "Enter ${green}[y|yes|Y|Yes]${reset} or ${red}[n|no|N|No]${reset}!"
        continue
        ;;
    esac
  done
}

# Run the scripts
check_sudo
get_username
sync_dotfiles
setup_vscode
