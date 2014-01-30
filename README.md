# Really need a way to automate getting to the point where this is feasible.

Right now, here are the steps to get a BP usable:
* Install SSH (if it isn't already on the appliance)
* Set up .ssh/config to provide access to this repo
* mkdir projects
* cd projects
* git clone ssh://whatever
* cd home
* bp.sh

It pretty desperately needs a way to install ssh (et al) onto the tarpon/spinnaker
instances to cut back on the time involved in configuring them. But that's a future
feature.

