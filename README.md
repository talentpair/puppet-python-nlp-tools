# DevOps: Making an Impact with Python NLP Tools

We've provided a usb stick that contains all files needed for setup as well as the data needed for the tutorial.

The code in this repo was used to generate the virtualbox image on the usb stick and can be used to install the complete dev environment
 from scratch on any Ubuntu 14 box, virtual or otherwise.

## For the tutorial:

Everyone should install an X11 provider:

* Available by default on linux
* [XQuartz](https://www.xquartz.org/) is a good one for mac
* Included with [Cygwin](http://cygwin.com/) on PC
    * Whether or not you already have Cygwin installed, you can add Cygwin/X to your installation by downloading the latest 
    setup-x86.exe (32-bit installation) or setup-x86_64.exe (64-bit installation) 
    * Install Net --> openssh
    * Install X11 --> 'xinit' and 'xlaunch'
    
Everyone should also have git.

## Windows

The vagrant setup is unreliable so we'll just use an amazon server.  Ask the instructor for an IP address.

Download [hobsontutorial.pem](https://raw.githubusercontent.com/talentpair/puppet-python-nlp-tools/master/hobsontutorial.pem) and ssh to the machine from cygwin

```bash
# wherever the pem file is from inside cygwin
cp /cygdrive/c/Users/username/hobsontutorial.pm .
chmod 400 hobsontutorial.pm

# launch xlaunch and config it to ssh to the machine
# 1) select multiple windows
# 2) start a program
# 3) start a program on a remote computer
# connect using: ssh
# remote program: xterm
# connect to computer: x.x.x.x
# login as user: ubuntu
# uncheck the boxes
# Additional parameters for ssh: '-i ~/hobsontutorial.pem' 
xlaunch.exe

# In ~ on the remote machine you should now see a data directory, this repo and the main tutorial repo
$ ls
data  puppet-python-nlp-tools  twip

# git pull in data and puppet-python-nlp-tools to make sure you're up to date

# provision with puppet to make sure the machine is up to date
cd ~/puppet-python-nlp-tools
sudo puppet apply --detailed-exitcodes --parser=future --modulepath=modules manifests/tutorial.pp || test $? -eq 2

# verify your setup by running the plottest.py script, you should get a simple plot
python plottest.py 
```

## Mac / Linux

First get this repo on your host machine

```bash
# grab this repo
git clone https://github.com/talentpair/puppet-python-nlp-tools.git
cd puppet-python-nlp-tools
```

1. Install VirtualBox from //usbstick/python-nlp-tools/install/yourOS
1. Install Vagrant from //usbstick/python-nlp-tools/install/yourOS
1. Bring up the provided vagrant image

```bash
# copy the box off the usb stick to use it
cp //usbstick/python-nlp-tools/install/trusty64-python-nlp-tools.box /tmp/trusty64-python-nlp-tools.box
vagrant box add trusty64-python-nlp-tools /tmp/trusty64-python-nlp-tools.box
vagrant up --provision

# verify your setup by running the plottest.py script, you should get a simple plot
# his should be done from XQuartz on a mac, the normal terminal will not have X11 enabled
vagrant ssh
python /vagrant/puppet-python-nlp-tools/plottest.py 
```

## Lets get to the data science!

Instructions are at [github.com/totalgood/twip](https://github.com/totalgood/twip/), they should be run inside your vagrant box 

```bash
# SSH to your fancy new machine
vagrant ssh

# refresh the tutorial repo proper
cd /home/vagrant/twip
git pull

# data is on the usb stick at //usbstick/python-nlp-tools/data and also baked into the vagrant box
ls /home/vagrant/data/all_tweets.csv
```


## Example: Use Puppet to install the environment on a vanilla Ubuntu 14 box

```bash
# First, SSH to the machine

# Install the tools you need to bootstrap
sudo apt-get install git puppet

# Use this repo to install it all
mkdir dev
cd dev
git clone https://github.com/talentpair/puppet-python-nlp-tools.git
cd puppet-python-nlp-tools

# Make sure that we have an up-to-date version of Puppet before continuing
sudo puppet apply --detailed-exitcodes --parser=future --modulepath=modules manifests/puppet.pp || test $? -eq 2

# The install will take a while so you might want to be in screen (or tmux if you like that sort of thing)
screen          # screen -rd will get you back

# Do the full install including stuff from apt and pip
sudo puppet apply --detailed-exitcodes --parser=future --modulepath=modules manifests/tutorial.pp || test $? -eq 2
```
