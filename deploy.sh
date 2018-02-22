
#!/bin/sh

# Deployer - Sahil Chaddha

workDirectories=('cd ~/Sahil/Projects/AstroGo/astrogo-ios/' 'cd ~/Sahil/Projects/AstroGo_Dev/astrogo-ios')
workDirectoriesName=('AstroGo 0' 'AstroGo_Dev 1')


# change_directory Declaration: Changes Current Directory to New Directory
# param: directoryName: String 
# usage: change_directory ~
change_directory()
{
	alias changeDirectoryAlias=${workDirectories[$1]}
	changeDirectoryAlias
}


# git_flow Declaration: Does basic Git Update & Switches to New Branch
# param: branchName: String 
# usage: git_flow ticket/0.1
git_flow()
{
	git status
	git fetch
	git checkout $1
	git pull
}

# pod_flow Declaration: Install Pods
# usage: pod_flow
pod_flow()
{
	pod install
}


# send_notification Declaration: Does basic Git Update & Switches to New Branch
# param: message: String 
# usage: send_notification Done
send_notification()
{
	notifyme AstroGo_Checkout_Complete
}

# open_xcode Declaration: Opens Xcode WorkSpace
# usage: open_xcode
open_xcode()
{
	open AstroGo.xcworkspace
}

# kill_deployment Declaration: Kills Current Command
# usage: kill_deployment
kill_deployment()
{
	zsh
	exec bash
}

# print_init_stuff Declaration: Prints Stuff
# usage: print_init_stuff
print_init_stuff()
{
	echo '********************************************************'
	echo '********************************************************'
	echo '***************** Sahil Work Deployer ******************'
	echo '********************************************************'
	echo '********************************************************'
	echo '********* Deployng Branch - '.$2.' - at -'${workDirectoriesName[$1]}.' ********'
	echo '********************************************************'
	echo '********************************************************'
}

# usage Declaration: Prints Usage
# usage: usage
usage()
{
	echo '********************************************************'
	echo 'Usage : astroc/aca/acb branchName -dnd -np'
	echo 'Parameters :'
	echo '-dnd : Does not Send Notification & Prevent Opening Xcode'
	echo '-np : Does Not Install Pods'
	echo '********************************************************'
	echo 'Other Commands : '
	echo 'astrogo/ag: Changes Directory to Primary Directory'
	echo 'astropod/ap: Changes Directory && Install Pods'
	echo 'notifyme/n: Sends Notification : n hi'
	echo '********************************************************'
}

##### Main
print_init_stuff $1 $2

if [ "$2" == '-h' ]; then
	usage
	exit
fi

alias changeDirectoryAlias=${workDirectories[$1]}
changeDirectoryAlias

git_flow $2

shouldInstallPods=true
dnd=false

while [ "$3" != "" ]; do
    case $3 in
        -dnd | --doNotDisturb )         dnd=true
                                ;;
        -np | --noPods )    shouldInstallPods=false
    esac
    shift
done

if [ "$shouldInstallPods" == true ]; then
	pod_flow
else
	echo "****************** Ignoring Pod Install *****************"
fi

if [ "$dnd" == false ]; then
	send_notification
	open_xcode
else
	echo "********************* DND Mode : ON **********************"
fi

echo "***************************** End *****************************"
kill_deployment










