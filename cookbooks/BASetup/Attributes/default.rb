
# ----------------------------------------------------------------
# Software
# ----------------------------------------------------------------

default[:bni][:software][:bni_dev_root] = "#{ENV['HOME']}/Code/GitHub/software"
default[:bni][:software][:bni_libs_root] = "#{ENV['HOME']}/Code/software-libs"
default[:bni][:software][:bni_software_data_root] = "#{ENV['HOME']}/Code/software-data"
default[:bni][:software][:bni_root] = "#{ENV['HOME']}/Code/software-release"
default[:bni][:software][:bni_build] = "#{node[:bni][:software][:bni_dev_root]}/Build"

# --------------------------------
# Qt

default[:bni][:software][:qt_installer] = 'qt-opensource-mac-x64-online.dmg'
default[:bni][:software][:qt_url] = 'http://download.qt-project.org/official_releases/online_installers'
default[:bni][:software][:qt_install_dir] = "#{ENV['HOME']}/Qt"
