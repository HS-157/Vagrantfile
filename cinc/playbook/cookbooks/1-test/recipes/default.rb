#
# Cookbook:: 1-test
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.


package = [
  'htop',
  'python',
  'python3',
  'git',
  'tmux'
]

package.each do |p|
  apt_package p do
    action :install
  end
end
