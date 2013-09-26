# install required packages/software/tools/...
	http://devel.iri.upc.edu/docs/roswiki/win_ros(2f)hydro(2f)Msvc(20)Compiled(20)SDK.html#Preparation
	

# extract rosdeps into C:\opt
	http://files.yujinrobot.com/win_ros/rosdeps/rosdeps-groovy-x86-vc10.zip
	--> make sure to use rosdeps-groovy-... for ros-groovy and rosdeps-hydro-... for ros-hydro

# create workspace and fetch sources

	C:\>mkdir work
	C:\>cd work
	C:\work>winros_init_workspace --track=groovy ws 						# use win_python_build_tools version 0.2.5
																			# ..this will fetch ros-groovy sources into specified workspace folder

# build ros "core"

	C:\work>cd ws
	C:\work\ws>setup
	C:\work\ws>winros_init_build --track=groovy
	C:\work\ws>winros_make													# ..this should start build-process and finish with 100%
	
# OPTIONAL: install

	C:\work\ws>winros_make --install


# create overlay-workspace

	C:\work\ws>cd C:\work
	C:\work>winros_init_workspace overlay
	C:\work>cd C:\work\overlay
	C:\work\overlay>setup.bat
	C:\work\overlay>winros_init_build --underlays="C:/opt/ros/groovy/x86"	# ..make sure to link to the correct directory,  ..\groovy\.. or ..\hydro\..

!winros_python_build_tools 0.2.5 does not generate correct config.cmake file!
	--> this will cause an error about "Boost not found"
	--> to fix this just edit config.cmake as described in the next step
	
!	# fix config.cmake in ..\work\overlay\
		==> change these lines:
set(ROSDEPS_ROOT "C:/opt/rosdeps/hydro/x86" CACHE STRING "System root for ros dependency.")
set(INSTALL_ROOT "C:/opt/overlay/hydro/x86" CACHE PATH "Install root.")
		to:
set(ROSDEPS_ROOT "C:/opt/rosdeps/groovy/x86" CACHE STRING "System root for ros dependency.")
set(INSTALL_ROOT "C:/opt/ros/groovy/x86" CACHE PATH "Install root.")

	C:\work\overlay>winros_make												# if this fails because of missing gtest, follow next step, otherwise skip that..
	
	# if gtest is missing, fetch sources
	
	C:\work\overlay>cd src
	C:\work\overlay\src>svn checkout http://googletest.googlecode.com/svn/tags/release-1.6.0 gtest
	
	# try to build again
	
	C:\work\overlay\src>cd ..
	C:\work\overlay>winros_make
	

# add source-package: common_tutorials
	
	cd C:\work\overlay\src				# if overlay is not working as it should (see above), use C:\work\ws ..
	wstool set common_tutorials --git https://github.com/ros/common_tutorials.git	# confirm with "y"
				# to choose version/branch try:
				#  ..wstool set rosconsole_bridge --git https://github.com/ros/rosconsole_bridge.git -v groovy
				
	wstool update common_tutorials			# if password needed, enter it "blind", it will not show on screen (or use git on shell manually), but it should work			# fetch sources for common_tutorials

# build new package

	cd C:/work/overlay					# if overlay is not working as it should (see above), use C:\work\ws ..	
	winros_make --pre-clean				#.. should finish build with 100%
	
	# on errors see Troubleshooting:
		--> nodelet_tutorial_math
		--> pluginlib_tutorials
		--> turtle_actionlib

# test actionlib_tutorials
	
	* open new terminal
	cd C:\work\ws\devel
	setup.bat
	roscore										# start ros-master
	
	* open new terminal
	cd C:\work\ws\devel
	setup.bat
	rostopic echo /fibonacci/result				# listen on topic

	* open new terminal
	cd C:\work\ws\devel
	setup.bat
	rosrun actionlib_tutorials fibonacci_server			# start fibonacci-server

	* open new terminal
	cd C:\work\ws\devel
	setup.bat
	rosrun actionlib_tutorials fibonacci_client			# start fibonacci-client
	

###########################################################################
# Troubleshooting
 
* Boost-Errors
	--> make sure you extracted the correct package for your ros-version. there are different downloads for groovy and hydro!
	--> forgot to extract rosdeps into c:\opt
* genaction.py gets opened in editor instead of being called to generate msg-files
	--> https://3c.gmx.net/mail/client/dereferrer?redirectUrl=http%3A%2F%2Fstackoverflow.com%2Fquestions%2F7690150%2Fpython-sys-argv-out-of-range-dont-understand-why
	--> SOLUTION: just right-click a .py file and choose python.exe as default programm for all .py files
* gtest not found
	--> solution is described in error-message:
		You can run 'svn checkout http://googletest.googlecode.com/svn/tags/release-1.6.0 gtest' in the root of your workspace
		--> root of workspace means c:\work\overlay\src
* error because of windows/unix line-endings in .cpp or other files
	--> use notepad++: edit -> line-endings conversion --> Unix-style
	
* nodelet - errors:
	--> remove folder "nodelet_tutorial_math" from ..\src\common_tutorials
* pluginlib - errors:
	--> remove folder "pluginlib_tutorials" from ..\src\common_tutorials
* turtle_actionlib - errors:
	--> remove folder "turtle_actionlib" from ..\src\common_tutorials
	

###########

# create custom message-package and simple c++ publisher for that custom message-type
  http://wiki.ros.org/win_ros/hydro/Msvc%20Overlays#Creating_Packages

  cd C:\work\overlay\src
  ..\devel\setup.bat
  winros_create_msg_pkg my_msg_pkg
  
--> Please edit package.xml, mainpage.dox, CMakeLists.txt, and add the package subdirectory.
  
# create custom msg- and config-files
  http://wiki.ros.org/ROS/Tutorials/DefiningCustomMessages
  
  cd my_msg_pkg\msg
  touch Num.msg
  notepad Num.msg
  --> insert: "int64 num"
  cd ..
  notepad package.xml
  --> insert: " <build_depend>message_generation</build_depend>
  		<run_depend>message_runtime</run_depend>"
  notepad CMakeLists.txt
  --> add "message_generation" to "find_package"-call
      [    find_package(catkin REQUIRED COMPONENTS roscpp rospy std_msgs message_generation)   ]
  --> add "message_runtime" to "catkin_package"-call (if not exists, create after "message_generation"-call)
      [    catkin_package(				]
      [		...					]
      [		CATKIN_DEPENDS message_runtime ...	]
      [ 	...)					]
  --> add "Num.msg" to "add_message_files"-call
      [	   add_message_files(			]
      [		FILES					]
      [		Num.msg					]
      [		)
      
  cd ..\..\..
  setup.bat
  winros_make --pre-clean
  
  --> error because of "depend"-tag in package.xml:
  	==> remove that tag (maybe replace with build_depend and/or run_depend)
  --> error because of unknown "CMake command 'catkin_project'"
  	==> when adding "message_runtime" to "catkin_package"-call, do NOT create "catkin_package"-call new,
  	    instead rename "catkin_project"-call to "catkin_package" and insert "CATKIN_DEPENDS message_runtime" there;
  	==> remove the entry: "  INCLUDE_DIRS include" from "catkin_package"
  --> error: "...Could not find a package configuration file provided by "ROS" ..."
  	==> in CMakeLists.txt change "find_package( ROS ... )" to
  	    "find_package( catkin ...)"
  --> error because of ".. catkin must be listed as a buildtool .."
  	==> add: "<buildtool_depend>catkin</buildtool_depend>" to package.xml
  --> error: "catkin_package() the catkin package 'std_msgs' has been find_package()-ed but is not listed as a build dependency in the package.xml"
  	==> add "std_msgs" as <build_depend> to package.xml
  	==> also add it as <run_depend>
  	
  then try again to run "winros_make" from workspace-root-folder (e.g. c:\work\overlay )
  	==> should finish with 100%, and msg-files should have been created

###########
	
	
	
	
###########################################################################
# Issues to take a look at:

* Boost not found if using overlay instead of "full"-workspace
	--> no idea yet, maybe dependencies are not correctly setup or some environment variable is missing?
		.. Boost does exist since "full"-workspace can find it..
	==> should be solved after fixing config.cmake; see above
		
* "nodelet_tutorial_math"
	--> why does it not build/install?
* "pluginlib_tutorials"
	--> why does it not build/install?
* "turtle_actionlib"
	--> why does it not build/install?

* not working tutorials:
	--> should update package.xml's and CMakeLists.txt and remove those packages from there, too!
