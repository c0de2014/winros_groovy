## create ros environment (	using win python build tools 0.2.5  )

 # extract rosdeps into c:\opt
	from http://files.yujinrobot.com/win_ros/rosdeps/rosdeps-groovy-x86-vc10.zip

 # get sources
	cd c:\
	mkdir work
	cd work
	winros_init_workspace --track=groovy ws
		^^ this is for build-tools 0.2.5! can use --track=hydro to choose hydro sources; 0.2.2 uses different options, --sdk...
		(  fetching sources can take some time  )
	
 # build ros
	cd c:\work\ws
	setup.bat
	winros_init_build --track=groovy
	winros_make
		^^ MUST finish with: "... [100%] Built target winros_create_pkg_exe"
	winros_make --install
		^^ install built stuff into c:\opt\ros\groovy ...

####
		
 # create ros-groovy overlay
	cd C:/work
	winros_init_workspace overlay
	cd C:/work/overlay
	setup.bat
	winros_init_build --underlays="C:/opt/ros/groovy/x86"
		^^ use ..\ros\hydro\x86 for ros-hydro
 # download missing gtest package
	cd src
	svn checkout http://googletest.googlecode.com/svn/tags/release-1.6.0 gtest
	cd ..
	
 # build overlay workspace
	winros_make
	
 # create package learning_actionlib
	c:\work\overlay\devel\setup.bat
	cd c:\work\overlay\src
	winros_create_pkg learning_actionlib actionlib message_generation roscpp rospy std_msgs actionlib_msgs
	
 # create Action messages
	(  http://wiki.ros.org/actionlib_tutorials/Tutorials/SimpleActionServer%28ExecuteCallbackMethod%29#Creating_the_Action_Messages  )
 
	mkdir c:\work\overlay\src\learning_actionlib\action
	touch c:\work\overlay\src\learning_actionlib\action\Fibonacci.action
	### insert file content into .action file
		^^ make sure to use correct line-endings format!

	
?# configure C:\work\overlay\src\learning_actionlib\CMakeLists.txt for the action messages
	notepad++ C:\work\overlay\src\learning_actionlib\CMakeLists.txt
	
 # generate msg files
	python c:\opt\ros\groovy\x86\lib\actionlib_msgs\genaction.py -o c:\work\overlay\src\learning_actionlib\msg c:\work\overlay\src\learning_actionlib\action\Fibonacci.action
	
 # enter c++ source code into learning_actionlib/src/fibonacci_server.cpp
	http://wiki.ros.org/actionlib_tutorials/Tutorials/SimpleActionServer%28ExecuteCallbackMethod%29#The_Code

 # add fibonacci_server to CMakeLists.txt
	http://wiki.ros.org/actionlib_tutorials/Tutorials/SimpleActionServer%28ExecuteCallbackMethod%29#Compiling_and_Running_the_Action
 
	
 # compile

 # ...boost.. .dll error: missing file..
 # ... nmake seems to run "empty"
 # ...
 

###### -> 1st: try without overlay

 # WITHOUT overlay
 
 

###### -> 2nd: try with downloaded actionlib_tutorial package to avoid errors in catkin config etc.. 





	
#############################################################################################
Troubleshooting:
* Boost-Errors
	--> forgot to extract rosdeps into c:\opt
* genaction.py gets opened in editor instead of being called to generate msg-files
	--> https://3c.gmx.net/mail/client/dereferrer?redirectUrl=http%3A%2F%2Fstackoverflow.com%2Fquestions%2F7690150%2Fpython-sys-argv-out-of-range-dont-understand-why
	--> SOLUTION: just right-click a .py file and choose python.exe as default programm for all .py files
* gtest not found
	--> solution is described in error-message:
		You can run 'svn checkout http://googletest.googlecode.com/svn/tags/release-1.6.0 gtest' in the root of your workspace
		--> root of workspace means c:\work\overlay\src
* error because of windows/unix line-endings
	--> use notepad++: edit -> line-endings conversion --> Unix-style

