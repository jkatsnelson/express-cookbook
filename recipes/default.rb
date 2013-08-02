#
# Cookbook Name:: express-cookbook
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "nodejs"

# Default yum package does not add node to the traditional loc on CentOS
link "/usr/bin/node" do
  to "/usr/local/bin/node"
end

# Install the NPM packages for the app
execute "npm_install" do
    command "cd #{node['app_root']} && /usr/local/bin/npm install"
end

# Copy over Node Upstart config
template "/etc/init/node.conf" do
    source "node.conf.erb"
    owner "root"
    group "root"
    mode 0644
end

# Start the Node service defined in the conf above
service "node" do
    provider Chef::Provider::Service::Upstart
    action :restart
end