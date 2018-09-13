include_recipe "losf::gopath"
include_recipe "losf::statsd"
include_recipe "losf::leveldb"

execute "symlink go code" do
    command "mkdir -p #{node['source_root']}/go/src/github.com/openstack &&" \
        "ln -s #{node['source_root']}/swift/go/swift-rpc-losf #{node['source_root']}/go/src/github.com/openstack/"
        creates "#{node['source_root']}/go/src/github.com/openstack/swift-rpc-losf"
end

execute "go get swift-rpc-losf" do
  command "go get github.com/openstack/swift-rpc-losf"
  environment("GOPATH" => "/vagrant/go")
  if not node['full_reprovision']
    creates "#{node['source_root']}/go/bin/swift-rpc-losf"
  end
end

execute "start swift-rpc-losf" do
  command "swift-init object-rpcmanager start"
  user node['username']
  group node["username"]
end
