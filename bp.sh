#! /bin/sh

source ./build.sh

# Clone the webapp source
cd ~
mv webapp webapp.initial
mkdir projects
cd projects
git clone ssh://Tarpon/usr/local/share/bp.git
cd ..
ln -s projects/bp webapp
sudo supervisorctl restart all

# Clone the agent sources 

# Spinnaker first
cd agents/spinnaker/usr/
sudo chmod g+w local
sudo chgrp bp local

# TODO: This duplication should happen in a function
# For that matter, it should really be a symlink...it's
# really wasteful to have this sort of duplication.
# In all honesty, we should set up the base agent image
# then deploy the tarpon pieces we need individually.
cd local
sudo mv agent agent.original
git clone ssh://Tarpon/usr/local/share/agent.git

# Tarpon
cd /home/bp/agents/tarpon/usr/
sudo chmod g+w local
sudo chgrp bp local

cd local
sudo mv agent agent.original
git clone ssh://Tarpon/usr/local/share/agent.git

