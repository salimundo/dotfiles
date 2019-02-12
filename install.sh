#!/bin/bash

# Colors
escape="\\033"
red=${escape}"[31m"
cyan=${escape}"[36m"
green=${escape}"[32m"
reset=${escape}"[0m"

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

sync_vscode() {
  while true ; do
    echo -en "${cyan}Sync dotfiles? ${reset}"
    read -r sync
    case $sync in
      y|yes|Y|Yes)
	  echo -e "\\n${green}Syncing VSCode...${reset}"
	  ln -sf /home/"${user}"/github/dotfiles/vscode/User/snippets /home/"${user}"/.config/Code/User/snippets
	  ln -sf /home/"${user}"/github/dotfiles/vscode/User/settings.json /home/"${user}"/.config/Code/User/settings.json
	  ln -sf /home/"${user}"/github/dotfiles/vscode/User/keybindings.json /home/"${user}"/.config/Code/User/keybindings.json
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
}

# Run the scripts
get_username
sync_dotfiles
sync_vscode
