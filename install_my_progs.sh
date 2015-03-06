#/bin/bash


########################################################################

### install_my_progs.sh ###
### installs my needed programs on my debian server on initial login ###
### 06.03.2015 ###

########################################################################

# Define your needed/wanted repositories here:
#------------------------------------------------------------------------#
repos="

deb http://ftp.de.debian.org/debian stable main contrib non-free
deb-src http://ftp.de.debian.org/debian stable main contrib non-free

deb http://ftp.debian.org/debian/ wheezy-updates main contrib non-free
deb-src http://ftp.debian.org/debian/ wheezy-updates main contrib non-free

deb http://security.debian.org/ wheezy/updates main contrib non-free
deb-src http://security.debian.org/ wheezy/updates main contrib non-free

"
#------------------------------------------------------------------------#

# Define your wanted programs:
#------------------------------------------------------------------------#
# Standard programs which make the work easier:
progs="sudo vim less tar zip git"

# Security programs:
security_progs="# fail2ban logwatch apticron"

# Webserver, database server and other stuff:
web_db_progs="apache2 libapache2-mod-proxy-html libapache2-mod-php5 mysql-server mysql-client mysql-common php5 php5-mysql php5-gd freetype*"

# Mailserver:
mail_serv="postfix"

# Other programs (need to uncomment lines 91-93:
other_progs=" "
#------------------------------------------------------------------------#


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
echo -e "Clearing /etc/apt/sources.list.."
:>/etc/apt/sources.list

echo ""
echo -e "Filling in official repositories.."
echo "$repos" >> /etc/apt/sources.list

# perform an update to insert and use the new repos
echo "" 
echo -e "Performing an update to use the new repositories.."
apt-get update -y

# install the needed programs, you may define less or more here:
echo ""
echo -e "Installing my needed programs.."
apt-get install -y $progs

# install security programs, you can also define more:
echo ""
echo -e "Installing security programs Fail2Ban, Logwatch and Apticron.."
apt-get install -y $security_progs

# install webserver, database server and much more
echo ""
echo -e "Installing Apache2, PHP and MySQL.."
apt-get install -y $web_db_progs

# install mailserver
echo ""
echo -e "Installing mailserver Postfix.."
apt-get install -y $mail_serv

# install other programs
# echo ""
# echo -e "Installing other programs.."
# apt-get install -y $other_progs

# Finishing..
echo -e "All done. You can start the real work now.."
exit
