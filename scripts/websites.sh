#!/bin/bash

urls=/opt/profiles/sites/urls
config_sites_dir=~/.config/profiles_sites
config_sites=$config_sites_dir/sites_url.list
WEBSITE_BROWSER='firefox'

dialog &> /dev/null || {
    [[ $(uname -s) == "Darwin" ]] && \
       echo -e "\nInstall dialog\nbrew install -y dialog"
    if [[ -x /usr/bin/apt-get ]]; then
       echo -e "\nInstall dialog\nsudo apt-get install -y dialog"
    fi
    if [[ -x /usr/bin/pacman ]]; then
       echo -e "\nInstall dialog\nsudo pacman -S dialog"
    fi
    exit 1
}

edit() {
    if [ -z $EDITOR ]; then
        nano "$config_sites"
    else   
        $EDITOR "$config_sites"
    fi
    run_dialog
}

refresh() {
    if [ ! -d "$config_sites_dir" ]; then
        mkdir -p "$config_sites_dir"
    fi
    if [ ! -r "$config_sites" ]; then
        cp "$urls" "$config_sites"
        echo "Local,file:/home/$USER/.config/profiles_sites/index.html,Links" >> "$config_sites"
    fi
    if [ ! -r "$config_sites_dir/index.html" ]; then
        cp /opt/profiles/sites/index.html "$config_sites_dir/index.html"
    fi
   cmdlist=()
   IFSOLD=$IFS
   IFS=',';
   while read -r label mycommand desc;
   do
    [[ $label =~ ^#.* ]] && continue
        cmdlist+=("$label" "$desc")
   done < "$config_sites"
   IFS=$IFSOLD
}

quit() { clear; exit 0; }

run_site() {
   IFSOLD=$IFS
   IFS=',';
   while read -r label mycommand desc;
   do
    [[ "$label" = "$command" ]] && {
        $WEBSITE_BROWSER "$mycommand" &
        clear
        exit 0
    }
   done < "$config_sites"
   IFS=$IFSOLD
}

run_dialog() {
    refresh
    command=$(dialog --ok-label "View Site" --cancel-label "EXIT" --output-fd 1 \
                    --extra-button    --extra-label "Edit" --colors \
                    --menu "Select web site:" 0 0 0 "${cmdlist[@]}")
        case $command:$? in
         *:0) run_site;;
         *:3) edit;;
         *:*) quit;;
        esac
}

what=$(/opt/profiles/scripts/display_check.sh)
[[ $what == "" ]] && clear || { echo $what; exit 1; }

run_dialog
clear
