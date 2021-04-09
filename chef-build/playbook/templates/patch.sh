#!/usr/bin/env bash

export ORIGIN="https://github.com/chef/chef-server.git"
export REF="master"
export CHANNEL="unstable"
export CINC_PRODUCT="cinc-server"
export OMNIBUS_FIPS_MODE="true"
export GIT_CACHE="false"
export CINC_REF="unstable/cinc"

export REF="master"
export ORIGIN="https://github.com/chef/chef-server.git"
export CINC_REF="bugfix/17" # FIX ME !

cd ./server
echo "$(pwd)"

./patch.sh
