##  PIP, GIT, AWS CLI  ##
package 'git, awscli'

#FAN UTILITY + OS SPECIFICS
package "OS Specific Miscs., HDF5" do
	case node[:platform_family]
	when "mac_os_x"
		package ['hdf5']
    options '--c++11'
  end
	when "ubuntu", "debian"
		package ['automake', 'libtool', 'libudev-dev', 'libhdf5-dev', 'macfanctrld']
	end
end
package "Boost" do
	case node[:platform_family]
	when "mac_os_x"
		package 'boost'
		version '1.5.7'
		options '--c++11'
  end
	when "ubuntu", "debian"
		package 'libboost-all-dev'
		version '1.5.7'
	end
end

git "~/Code" do
	repository "git@github.com:ButterflyNetwork/qt3d.git"
	revision "master"
	action :sync
end
