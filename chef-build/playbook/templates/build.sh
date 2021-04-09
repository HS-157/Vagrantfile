#!/usr/bin/env bash

wget https://github.com/chef/chef-server/archive/refs/tags/14.2.2.tar.gz

tar xvf ./14.2.2.tar.gz

TOP_DIR="$(pwd)"
export CI_PROJECT_DIR=${CI_PROJECT_DIR:-${TOP_DIR}}
source /home/omnibus/load-omnibus-toolchain.sh
set -ex
cd ./chef-server-14.2.2/omnibus
# bundle install --without development --path ${CI_PROJECT_DIR}/bundle/vendor --binstubs
bundle install
# bundle exec omnibus build chef-server --override append_timestamp:false
bundle exec omnibus build chef-server
