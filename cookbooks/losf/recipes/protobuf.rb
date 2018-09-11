# Copyright (c) 2018 SwiftStack, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_recipe "losf::gopath"

# dependencies for protobuf's make process
package("autoconf") { action :install }
package("automake") { action :install }
package("libtool") { action :install }
package("curl") { action :install }
package("make") { action :install }
package("g++") { action :install }
package("unzip") { action :install }


execute "install protobuf" do
  cwd "#{node['source_root']}"
  command "curl -L -o protoc.zip https://github.com/google/protobuf/releases/download/v3.6.0/protoc-3.6.0-linux-x86_64.zip &&" \
      "unzip -o protoc.zip &&" \
      "mv #{node['source_root']}/bin/protoc /usr/local/bin"
  creates "/usr/local/bin/protoc"
  action :run
end
