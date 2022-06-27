#!/bin/bash
# Colors
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"
COL_BLUE=$ESC_SEQ"34;01m"
COL_MAGENTA=$ESC_SEQ"35;01m"
COL_CYAN=$ESC_SEQ"36;01m"

#   pl
#   eng
lang="pl"

greeting()
{
    echo
    echo -e "$COL_MAGENTA           ____    ____            ____    ____   ______"
    echo -e "          / __ \  / __ \          / __ )  / __ \ /_  __/"
    echo -e "         / /_/ / / / / / ______  / __  | / / / /  / /  "
    echo -e "        / _, _/ / /_/ / /_____/ / /_/ / / /_/ /  / /  "
    echo -e "       /_/ |_|  \____/         /_____/  \____/  /_/ $COL_RESET"
    echo
    echo -e "$COL_CYAN      CEO & Founder: Tymoteusz \`RazorMeister\` Bartnik "
    echo -e "vCEO: Robert \`MrRobson\` Kaminski & Mateusz \`DShimen\` Gwadrdys $COL_RESET"
    echo -e "$COL_GREEN             RO-BOT Premium Installer$COL_RESET"
}

installing()
{
    echo
   	echo -e "$COL_CYAN ****************************************$COL_RESET"
   	echo -e "$COL_GREEN   	INSTALLING: $1 $COL_RESET"
   	echo -e "$COL_CYAN ****************************************$COL_RESET"
   	echo
}

write()
{
	echo
   	echo -e "$COL_CYAN **************************************** $COL_RESET"
   	echo -e "$2  $1 $COL_RESET"
   	echo -e "$COL_CYAN **************************************** $COL_RESET"
   	echo
}

checkInstalledPackets()
{
    if [ -z `which sudo` ]; then
		installing "sudo"
		apt-get install sudo -y
	fi

	if [ -z `which unzip` ]; then
		installing "unzip"
		apt-get install unzip -y
	fi

	if [ -z `which zip` ]; then
		installing "zip"
		apt-get install zip -y
	fi

	if [ -z `which wget` ]; then
		installing "wget"
		apt-get install wget -y
	fi

	if [ -z `which screen` ]; then
		installing "screen"
		apt-get install screen -y
	fi

	if [ -z `which curl` ]; then
		installing "curl"
		apt-get install curl -y
	fi
}

#Greeting is always shown
greeting;
checkInstalledPackets

curl "http://51.75.37.170:8089/checkUpdate?productName=RO-BOT&version=1.0" --output package.zip
sleep 3
status="$(cat package.zip 2>/dev/null | tr -d '\0')"

if [ ${#status} -le 40 ]; then
	if [ "$status" == "1" ]; then
		write "	  Bledna licencja!" "$COL_RED"
	elif [ "$status" == "2" ]; then
		write "Posiadasz juz najnowsza wersje!" "$COL_GREEN"
	else
		write "Error | Skontaktuj sie z tworca bota!" "$COL_RED"
	fi

	rm package.zip
else
	write "Instalowanie najnowszej wersji!" "$COL_GREEN"
	write "  Nacisnij zaraz \`A\` aby kontynuowac" "$COL_GREEN"
	sleep 1

	unzip package.zip
	rm package.zip

	chmod 777 starter.sh
	write "  RO-BOT zostal zainstalowany!" "$COL_GREEN"
fi