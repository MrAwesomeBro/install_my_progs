#/bin/bash


### installs my needed programs on my debian server ###
### 06.03.2015 ###
### Modified 22.04.2015 ###

# Define your needed/wanted repositories here:
repos=`cat repos.txt`
# Define your wanted programs:

helpers="sudo vim less tar zip git"
security_progs="fail2ban logwatch apticron"
web_and_db="apache2 libapache2-mod-proxy-html libapache2-mod-php5 mysql-server mysql-client mysql-common php5 php5-mysql php5-gd freetype*"

# Uncomment if you want to install a mailserver as well:
# mail="postfix dovecot"

# Uncomment if you want to install other programs
# other="nginx"

# Define programs which you want to be removed
crap=nano

### FUNCTIONS ###

little_helpers () {
	echo "installing little helpers"
		apt-get install $helpers;
	echo "removing crap"
		apt-get remove --purge $crap;
}

security () {
	echo "installing security programs"
		apt-get install $security_progs;
}

webserver () {
	echo "installing webserver and database with php and modules"
		apt-get install $web_and_db;
}

mailserver () {
	echo "installing mail server"
		apt-get install $mail;
}

others () {
	echo "installing other programs"
		apt-get install $other;

}
### END OF FUNCTIONS ###

# check if the script is run by "root"
if (( $EUID != 0 )); then
		echo ""
		echo -e "Looks like you are not logged in as Root. 
			Please run as root or the script cannot be used!"
		echo ""
	exit
fi

# clearing the sources.list && adding the official repos
echo ""
echo -e "Clearing /etc/apt/sources.list and filling in my repos"
:>/etc/apt/sources.list && echo "$repos" >> /etc/apt/sources.list

# perform an update to insert and use the new repos
echo "" 
echo -e "Performing an update to use the new repositories.."
apt-get update -y

# Installing the Programs now

little_helpers
security
webserver
mailserver
others

# Finished_
echo "Done. My needed programs have been installed successfully."
