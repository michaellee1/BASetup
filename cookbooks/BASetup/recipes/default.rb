##  PIP, GIT, AWS CLI  ##
package 'git, awscli'

# ----------------------------------------------------------------
# Install Qt
# ----------------------------------------------------------------

unless FileTest.exists?(node[:bni][:software][:qt_install_dir])
  remote_file "#{Chef::Config[:file_cache_path]}/#{node[:bni][:software][:qt_installer]}" do
    source "#{node[:bni][:software][:qt_url]}/#{node[:bni][:software][:qt_installer]}"
  end
  execute 'mount Qt DMG' do
    command "open  #{Chef::Config[:file_cache_path]}/#{node[:bni][:software][:qt_installer]}"
  end
  execute 'Launch QT Installer' do
    command '`echo /Volumes/qt-opensource-mac-x64*/*/Contents/MacOS/*`'
  end
end

# FAN UTILITY + OS SPECIFICS
case node[:platform]
when 'mac_os_x'
  package 'hdf5' do
    action :install
    options '--c++11'
  end
when 'ubuntu', 'debian'
  package ['automake', 'libtool', 'libudev-dev', 'libhdf5-dev', 'macfanctrld']
end
# Boost
case node[:platform_family]
  when 'mac_os_x'
    package 'boost' do
      action :install
      version '1.5.7'
      options '--c++11'
    end
  when 'ubuntu', 'debian'
    package 'libboost-all-dev' do
      action :install
      version '1.5.7'
  end
end
# ----------------------------------------------------------------
# Setup S3
# ----------------------------------------------------------------

template "#{ENV['HOME']}/.aws/config" do
  source 'aws_config.erb'
end

template node[:bni][:software][:env_src] do
  source 'bni_software.env.erb'
end

execute 's3 sync' do
  command "aws s3 sync s3://3rdPartyLibs #{node[:bni][:software][:bni_libs_root]}; aws s3 sync s3://SoftwareData #{node[:bni][:software][:bni_software_data_root]}; "
end

# ----------------------------------------------------------------
# Setup Software Repository
# ----------------------------------------------------------------
git node[:bni][:software][:bni_dev_root] do
  repository 'git@github.com:ButterflyNetwork/qt3d.git'
  revision 'master'
  action :sync
end
git node[:bni][:software][:bni_dev_root] do
  repository "git@github.com:ButterflyNetwork/software.git"
  reference 'develop'
  action :checkout
  notifies :run, 'execute[git-submodules]'
end

execute 'git-submodules' do
  command 'git submodule update --init --recursive'
  cwd node[:bni][:software][:bni_dev_root]
  action :nothing
end
