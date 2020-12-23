# !/bin/bash
# conf.sh
# FOR: configuring linux device driver psmouse

PASSWORD=sysprog2019

changeres() {
    read -p 'Resolution (in dpi): ' res
    echo $PASSWORD | sudo -S modprobe -r psmouse
    echo $PASSWORD | sudo -S modprobe psmouse resolution=$res
    echo The resolution of the mouse is now: $(cat /sys/module/psmouse/parameters/resolution)
    read -p 'Press [Enter] key to continue...'
    mainmenu
}

mainmenu() {
    echo '================================================='
    echo '                    MAIN MENU                    '
    echo '================================================='
    echo CURRENT MOUSE RESOLUTION (IN DPI)
    echo resolution: $(cat /sys/module/psmouse/parameters/resolution)

    COLUMNS=12
    PS3='choose driver to configure 1-2: '
    options=("Change Resolution" "Exit Script")
    select opt in "${options[@]}"
    do
        case $opt in
            "Change Resolution")
                changeres
                ;;
            "Exit Script")
                echo 'Exiting Script'
                read -p 'Press [Enter] key to continue...'
                exit
                ;;
            *)
        esac
    done
}

mainmenu