# !/bin/bash
# conf.sh
# FOR: Changing psmouse resolution and e1000 copybreak

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
	mainmenu
}

mainmenu() {

    echo '================================================='
    echo Current Mouse Resolution: $(cat /sys/module/psmouse/parameters/resolution)
    echo '================================================='
    echo Current Ethernet Copybreak: $(cat /sys/module/e1000/parameters/copybreak)
    echo '================================================='

    COLUMNS=12
    PS3='Choose which parameter you wish to reconfigure: '
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
