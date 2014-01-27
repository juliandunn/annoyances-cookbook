#
# Cookbook Name:: annoyances
# Recipe:: windows
# Author:: Julian C. Dunn (<jdunn@getchef.com>)
# Author:: Alex Vinyar (<alexv@getchef.com>)
#
# Copyright 2014, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# turn off UAC
registry_key 'HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System' do
  values [
    {
    :name => 'EnableLUA',
    :type => :dword,
    :data => 0
  }]
end

registry_key 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' do
  values [{
    :name => 'ConsentPromptBehaviorAdmin',
    :type => :dword,
    :data => 00000000
  }]
end

# disable Server Manager on boot
registry_key 'HKLM\Software\Microsoft\ServerManager\Oobe' do
  values [
    {
    :name => 'DoNotOpenInitialConfigurationTasksAtLogon',
    :type => :dword,
    :data => 1
  }]
end

registry_key 'HKLM\Software\Microsoft\ServerManager' do
  values [
    {
    :name => 'DoNotOpenServerManagerAtLogon',
    :type => :dword,
    :data => 1
  }]
end

# disable Shutdown Tracker
registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Reliability' do
  values [
    {
      :name => 'ShutdownReasonUI',
      :type => :dword,
      :data => 0
    }
  ]
end

# disable IE Enhanced Security for admins
if node['annoyances']['windows']['disable_ie_for_admins']
  registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}' do
    values [{
      :name => 'IsInstalled',
      :type => :dword,
      :data => 0
    }]
    action :create
  end
end

# disable IE Enhanced Security for users
if node['annoyances']['windows']['disable_ie_for_users']
  registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}' do
    values [{
      :name => 'IsInstalled',
      :type => :dword,
      :data => 0
    }]
    action :create
  end
end
