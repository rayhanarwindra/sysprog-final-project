# !/bin/bash
# conf.sh
# FOR: configuring linux device driver psmouse

PASSWORD=sysprog2019

changeres() {
    read -p 'New Resolution (in dpi): ' res
    echo $PASSWORD | sudo -S modprobe -r psmouse
    echo $PASSWORD | sudo -S modprobe psmouse resolution=$res
    echo The resolution of the mouse is now: $(cat /sys/module/psmouse/parameters/resolution)
    read -p 'Press [Enter] key to continue...'
    mainmenu
}

changecb() {
	read -p 'New Copybreak value: ' cb
	echo $PASSWORD | sudo -S modprobe -r e1000
    	echo $PASSWORD | sudo -S modprobe e1000 copybreak=$cb
    	echo The ethernet copybreak is now: $(cat /sys/module/e1000/parameters/copybreak)
    	read -p 'Press [Enter] key to continue...'

}

mainmenu() {
    echo '================================================='
    echo '                    MAIN MENU                    '
    echo '================================================='
    echo CURRENT MOUSE RESOLUTION
    echo resolution: $(cat /sys/module/psmouse/parameters/resolution)
    echo '================================================='
    echo CURRENT NETWORK COPYBREAK
    echo copybreak: $(cat /sys/module/e1000/parameters/copybreak)

    COLUMNS=12
    PS3='choose driver to configure 1-2: '
    options=("Change Resolution" "Change CopyBreak" "Exit Script")
    select opt in "${options[@]}"
    do
        case $opt in
            "Change Resolution")
                changeres
                ;;
	    "Change CopyBreak")
		changecb
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
