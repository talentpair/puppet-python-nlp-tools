# DevOps: Making an Impact with Python NLP Tools

We've provided a usb stick that contains all files needed for setup as well as the data needed for the tutorial.

The code in this repo was used to generate the virtualbox image on the usb stick and can be used to install the complete dev environment
 on any Ubuntu 14 box, virtual or otherwise. It's not needed for the tutorial unless you're having problems with Vagrant. The instructions should work
 for a fresh Ubuntu 14 box on amazon/DO/whatever (instructions below)

## For the tutorial:

1. Install VirtualBox from //usbstick/python-nlp-tools/install/yourOS
1. Install Vagrant from //usbstick/python-nlp-tools/install/yourOS
1. Bring up the provided vagrant image


```
# grab this repo
git clone https://github.com/talentpair/puppet-python-nlp-tools.git
cd puppet-python-nlp-tools

# Bring up the vagrant box
vagrant box add trusty64-python-nlp-tools //usbstick/python-nlp-tools/install/trusty64-python-nlp-tools.box
vagrant up --provision

# SSH to your fancy new machine
vagrant ssh
```


## Example: Use Puppet to install the environment on a vanilla Ubuntu 14 box

```bash
# First, SSH to the machine

# Install the tools you need to bootstrap
sudo apt-get install git puppet

# Uuse this repo to install it all
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
 