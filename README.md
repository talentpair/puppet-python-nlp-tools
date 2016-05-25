# DevOps: Making an Impact with Python NLP Tools

We've provided a usb stick that contains all files needed for setup.

The code in this repo was used to generate the virtualbox image on the usb stick and can be used to install the complete dev environment
 on any linux machine or virtual linux machine. It's not needed for the tutorial but check it out if you're interested! (instructions
 below)

## For the tutorial:

1) Install VirtualBox from //usbstick/python-nlp-tools/install/yourOS
2) Install Vagrant from //usbstick/python-nlp-tools/install/yourOS
3) Bring up the provided vagrant image


```
# grab this repo
git clone https://github.com/talentpair/puppet_example.git
cd puppet_example

# Bring up the vagrant box
vagrant box add trusty64-python-nlp-tools //usbstick/python-nlp-tools/install/trusty64-python-nlp-tools.box
vagrant up --provision

# SSH to your fancy new machine
vagrant ssh
```


## Example: Use Puppet to install on a vanilla Ubuntu box

```bash
# First, SSH to the machine

# Install the tools you need to bootstrap
sudo apt-get install git puppet

# Uuse this repo to install it all
mkdir dev
cd dev
git clone https://github.com/talentpair/puppet_example.git
cd puppet_example

# This just makes sure that we have an up-to-date version of Puppet before continuing
sudo puppet apply --detailed-exitcodes --parser=future --modulepath=modules manifests/puppet.pp || test $? -eq 2

# this will take a while so you might want to be in screen (or tmux if you like that sort of thing)
screen          # screen -rd will get you back

# Now do the full install including stuff from apt and pip
sudo puppet apply --detailed-exitcodes --parser=future --modulepath=modules manifests/tutorial.pp || test $? -eq 2
```
 