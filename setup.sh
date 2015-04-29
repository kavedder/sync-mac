#!/bin/sh

# first, make sure we can run make
if [[ "$(which make)x" == "x" ]] ; then
    echo "We can't go about installing this stuff until you download the developer tools"
    echo "from Xcode."
    echo
    echo "Open up Xcode, go to Preferences -> Downloads -> Components -> Command Line Tools"
    echo "and download them all. Then try re-running this script"
    exit 2
else
    echo "Good! It seems you have the developer tools installed, so we can run make!"
fi

# get homebrew if not installed
echo
echo "##################################################"
echo
if [[ "$(which brew)x" == "x" ]] ; then
    echo "Installing Homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" > /dev/null
else
    hbrew=`which brew`
    echo "Homebrew already installed at $hbrew" 
fi

# /usr/local/bin isn't in the default OSX path, but it's where fswatch and sshpass are installed
# by default; also add them to the ~/.bash_profile so these things will run in future
export PATH=$PATH:/usr/local/bin
echo "export PATH=$PATH:/usr/local/bin" >> ~/.bash_profile

# install fswatch
echo
echo "##################################################"
echo
if [[ "$(which fswatch)x" == "x" ]] ; then
    echo "Installing fswatch..."
    brew install fswatch
else
    hbrew=`which fswatch`
    echo "fswatch already installed at $fswatch" 
fi
   

# install sshpass
echo
echo "##################################################"
echo
if [[ "$(which sshpass)x" == "x" ]] ; then
    echo "Installing sshpass..."
    wget http://sourceforge.net/projects/sshpass/files/latest/download -O sshpass.tar.gz > /dev/null
    tar xzf sshpass.tar.gz
    cd sshpass-1.05
    ./configure
    make
    sudo make install
    cd ..
    rm -rf sshpass*
else
    sshpass=`which sshpass`
    echo "sshpass already installed at $sshpass" 
fi

# grab the username and pw info for ssh
echo
echo "##################################################"
echo
echo "Now we need to set up your UW username and password"
echo "for syncing files"
uwrc=~/.uwrc
echo
read -p "Enter your UW NetID username: " username 
echo
read -s -p "Enter your UW NetID password: " password

echo "user=$username" > $uwrc
echo "password=$password" >> $uwrc

chmod 700 $uwrc

echo "Your UW NetID information is at $uwrc. It user-only rwx"

cat <<EOF 
Your autosync setup is almost complete!

--> NOTE! READ ME READ ME!
You need to have your UW webservice set up
See this page for details: http://www.washington.edu/itconnect/connect/web-publishing/shared-hosting/activating-shared-web-hosting/

##################################################

--> NOTE NUMBER TWO! After that, if you have not already,
you first need to log into the vergil server manually to
add the server to your list of allowed fingerprints

Run:
ssh $username@vergil.u.washington.edu
and log in as usual.

##################################################

--> AFTER ALL THAT!
To run automatic syncing, simply
run the following to start watching:

sh watch.sh &
EOF
