# install winros-groovy

	https://github.com/ipa-fxm-db/windows_ros-groovy
	
	- make sure to use rosdeps for groovy, when extracting rosdeps into c:\opt! (ros-wiki hydro tutorials link to rosdeps-hydro...)
	  http://files.yujinrobot.com/win_ros/rosdeps/rosdeps-groovy-x86-vc10.zip
	- use WinRos_Python_Build_Tools version 0.2.5
	  http://files.yujinrobot.com/repositories/windows/python/2.7/winros-python-build-tools-0.2.5.win32.msi
	  

'# optional: setup a "normal" workspace
'
'	## create workspace
'	
'	mkdir c:\work
'	cd c:\work
'	winros_init_workspace --track=groovy					# this option is not available if using winros_python_build_tools v 0.2.2
'
'	## init workspace
'	
'	...
	
# create overlay workspace

	## create folder
	
	cd C:\work
	winros_init_workspace overlay
	cd C:\work\overlay
	
	## setup environment
	
	setup.bat
	
	## create workspace overlay
	
	winros_init_build --underlays="C:/opt/ros/groovy/x86"	# ..make sure to link to the correct directory!! ..\groovy\.. or ..\hydro\..
	
!	## fix errors from winros_init_build script				# winros_python_build_tools 0.2.5 does not generate correct config.cmake file!
															  --> this will cause an error about "Boost not found"
															  --> to fix this just edit config.cmake as described in the next step
	notepad c:\work\overlay\config.cmake
		- change the following lines:
----------------------------------------------------------------------------------------------------------
	set(ROSDEPS_ROOT "C:/opt/rosdeps/hydro/x86" CACHE STRING "System root for ros dependency.")
	set(INSTALL_ROOT "C:/opt/overlay/hydro/x86" CACHE PATH "Install root.")
----------------------------------------------------------------------------------------------------------
		... into:
----------------------------------------------------------------------------------------------------------
	set(ROSDEPS_ROOT "C:/opt/rosdeps/groovy/x86" CACHE STRING "System root for ros dependency.")
	set(INSTALL_ROOT "C:/opt/ros/groovy/x86" CACHE PATH "Install root.")
----------------------------------------------------------------------------------------------------------

	## try to build the overlay-workspace
	
	cd c:\work\overlay
	setup.bat
	winros_make									# if this fails because of missing "gtest", get it via svn
	
	## download gtest via svn (if needed because winros_make failed..)
	
	cd c:\work\overlay\src
	svn checkout http://googletest.googlecode.com/svn/tags/release-1.6.0 gtest
	cd c:\work\overlay
	setup.bat
	winros_make											# should not return any errors..
	
'# optional: test overlay workspace with ros: common_tutorials (- simple publisher and subscriber)
'
'	## add package-sources			# make sure to use parameter -v with correct option for your system (groovy/hydro)
'									  ..choose the git-branch that fits your ros-enviroment (currently: master or hydro-devel)
'	
'	wstool set common_tutorials --git https://github.com/ros/common_tutorials.git -v master
'	
'	## fetch source-files
'	
'	wstool update common_tutorials	# if password needed, enter it "blind",
'									  ..it will just not show on screen, but it should work
'									  ..(or simply use git on shell manually to checkout the source code)
'
'	## remove packages from common_tutorials (because dependencies are not yet ported to winros):
'	 .. just goto c:\work\overlay\src\common_tutorials and remove following package folders
'	 .. (should also remove those packages from package.xml etc. ..but removing the folders works good enough)
'	 - pluginlib
'	 - nodelet_tutorial_math
'	 - turtle_actionlib
'	
'	## build common_tutorials package
'	
'	cd C:/work/overlay
'	winros_make --pre-clean			# build should finish with 100%
'	
'	## test simple publisher and subscriber from common_tutorials
'	
'	--> open 4 new terminals
'		.. for each terminal: run c:\work\overlay\devel\setup.bat
'	cd c:\work\overlay
'	devel\setup.bat
'	
'	--> then start: roscore, rostopic, publisher, and subscriber
'	1) roscore											# start ros-master
'	2) rostopic echo /fibonacci/result					# listen on ros-topic
'	3) rosrun learning_actionlib fibonacci_server		# start fibonacci-server
'	4) rosrun learning_actionlib fibonacci_client		# start fibonacci-client
'	
'	--> start of scripts, etc. might take some time, but should work.
	
# create custom message-package and simple c++ publisher and subscriber using that message-type
	http://wiki.ros.org/win_ros/hydro/Msvc%20Overlays#Creating_Packages
	
	## create the package folder
	
	cd C:\work\overlay
	devel\setup.bat
	cd src
	winros_create_msg_pkg my_msg_pkg
	
	## create custom-msg files
		http://wiki.ros.org/ROS/Tutorials/DefiningCustomMessages
	
	cd my_msg_pkg\msg
	touch Num.msg
	notepad Num.msg
		--> insert into first line; (without quotes):
				"int64 num"
	
	## update: package.xml
	
	cd c:\work\overlay
	notepad package.xml
----------------------------------------------------------------------------------------------------------
<package>
  <name>my_msg_pkg</name>
  <version>0.1.0</version>
  <description>

     my_msg_pkg

  </description>
  <maintainer email="Admin@gmail.com">Admin</maintainer>
  <author>Admin</author>
  <license>BSD</license>

  <buildtool_depend>catkin</buildtool_depend>  
  
  <build_depend>message_generation</build_depend>
  <run_depend>message_runtime</run_depend>
  <build_depend>std_msgs</build_depend>
  <run_depend>std_msgs</run_depend>

</package>
----------------------------------------------------------------------------------------------------------
				  
	## update: CMakeLists.txt
	
	notepad CMake_Lists.txt
----------------------------------------------------------------------------------------------------------		
##############################################################################
# CMake
##############################################################################

# set(CMAKE_VERBOSE_MAKEFILE TRUE)

##############################################################################
# Catkin
##############################################################################

project(my_msg_pkg)

# Include actionlib_msgs as a dependency if adding actions
# Move this call to stack.xml if you are calling find_package on a particular
# component alot.
find_package( catkin REQUIRED COMPONENTS genmsg std_msgs message_generation)

include_directories(include)

##############################################################################
# Sources
##############################################################################

add_message_files(
  DIRECTORY msg
  FILES
  Num.msg
)

add_service_files(
  DIRECTORY srv
  FILES HelloDude.srv
)

#add_action_files(
#  DIRECTORY action
#  FILES FooBar.action
#)

# Include actionlib_msgs as a dependency if adding actions
generate_messages(DEPENDENCIES std_msgs )

catkin_package(
  DEPENDS std_msgs
  CATKIN_DEPENDS message_runtime
  )

##############################################################################
# Install
##############################################################################

install(DIRECTORY include/
        DESTINATION include
        FILES_MATCHING PATTERN "*.h"
        PATTERN ".svn" EXCLUDE
        PATTERN ".git" EXCLUDE)

----------------------------------------------------------------------------------------------------------
	
	## build my_msg_pkg:
	
	cd c:\work\overlay
	devel\setup.bat
	winros_make -pre--clean				# should finish with 100%
	
# create simple publisher and subscriber that use a custom defined message-type (the one we created above..)
	
	## get ros_tutorials from github
	
	cd c:\work\overlay\src
	wstool set ros_tutorials --git https://github.com/ros/ros_tutorials.git -v groovy-devel
	wstool update ros_tutorials
	
	## create folders and files for talker and listener (those will make use of the custom-message Num.msg)
	
		--> copy folders "talker" and "listener from: C:\work\overlay\src\ros_tutorials\roscpp_tutorials
				to: C:\work\overlay\src\
		--> remove C:\work\overlay\src\ros_tutorials
			to avoid dependency problems with tutorials that don't run with winros yet

	## create package.xml for both packages (talker and listener)
	
	notepad c:\work\overlay\src\talker\package.xml
	--> if file does not exist, create it..
	--> replace content with:
----------------------------------------------------------------------------------------------------------
	<package>
		<name>talker</name>
		<version>0.0.1</version>
		<description>talker</description>
		<maintainer email="un@known.com">Un Known</maintainer>

		<license>BSD</license>

		<url type="website">http://www.google.com</url>
		<author email="un@known.com">Un Known</author>

		<buildtool_depend>catkin</buildtool_depend>

		<build_depend>roscpp</build_depend>
		<build_depend>std_msgs</build_depend>
	
		<run_depend>roscpp</run_depend>
		<run_depend>std_msgs</run_depend>
		<run_depend>message_runtime</run_depend>

	</package>
----------------------------------------------------------------------------------------------------------	

	notepad c:\work\overlay\src\listener\package.xml
	--> if file does not exist, create it..
	--> replace content with:			
----------------------------------------------------------------------------------------------------------
  	<package>
	  <name>listener</name>
	  <version>0.0.1</version>
	  <description>listener</description>
	  <maintainer email="un@known.com">Un Known</maintainer>
	
	  <license>BSD</license>
	
	  <url type="website">http://www.google.com</url>

	  <author email="un@known.com">Un Known</author>
	
	  <buildtool_depend>catkin</buildtool_depend>
	
	  <build_depend>roscpp</build_depend>
	  <build_depend>std_msgs</build_depend>
	
	  <run_depend>roscpp</run_depend>
	  <run_depend>std_msgs</run_depend>
	  <run_depend>message_runtime</run_depend>
	
	</package>
----------------------------------------------------------------------------------------------------------			
			
	## fix CMakeLists.txt for both packages

	notepad c:\work\overlay\src\talker\CMakeLists.txt
	--> replace content with:
----------------------------------------------------------------------------------------------------------
	cmake_minimum_required(VERSION 2.8.3)
	project(talker)
	
	## Find catkin dependencies
	find_package(catkin REQUIRED COMPONENTS roscpp)
	
	include_directories(${catkin_INCLUDE_DIRS})
	
	add_executable(talker talker.cpp)
	target_link_libraries(talker ${catkin_LIBRARIES})
	
	catkin_package(CATKIN_DEPENDS message_runtime std_msgs)
	
	install(TARGETS talker RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION})
----------------------------------------------------------------------------------------------------------

	notepad c:\work\overlay\src\listener\CMakeLists.txt
	--> replace content with:
----------------------------------------------------------------------------------------------------------
	cmake_minimum_required(VERSION 2.8.3)
	project(listener)
	
	## Find catkin dependencies
	find_package(catkin REQUIRED COMPONENTS roscpp)
	
	include_directories(${catkin_INCLUDE_DIRS})
	
	add_executable(listener listener.cpp)
	target_link_libraries(listener ${catkin_LIBRARIES})
	
	catkin_package(CATKIN_DEPENDS message_runtime std_msgs)
	
	install(TARGETS listener RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION})
----------------------------------------------------------------------------------------------------------
	
'	## optional: test if packages build with std-msgs (talker and listener)
'	
'	cd c:\work\overlay
'	setup.bat
'	winros_make --pre-clean

'	## optional: test if packages run with std-msgs (talker and listener)
'	
'	--> open 3 new terminals
'		.. for each terminal: run c:\work\overlay\devel\setup.bat
'	cd c:\work\overlay
'	devel\setup.bat
'	
'	--> then start: roscore, talker, and listener
'	1) roscore											# start ros-master
'	2) c:\work\overlay\build\talker\talker.exe			# start talker
'	3) c:\work\overlay\build\listener\listener.exe		# start listener
'
'  	==> talker should send, and listener receive.. ( attribute "data" of type "std_msgs.String" )



	## modify talker and listener source-files to use the custom-message from my_msg_pkg
	
	notepad c:\work\overlay\src\talker\talker.cpp
	--> replace content with:
----------------------------------------------------------------------------------------------------------
/*
 * Copyright (C) 2008, Morgan Quigley and Willow Garage, Inc.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *   * Redistributions of source code must retain the above copyright notice,
 *     this list of conditions and the following disclaimer.
 *   * Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *   * Neither the names of Stanford University or Willow Garage, Inc. nor the names of its
 *     contributors may be used to endorse or promote products derived from
 *     this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */
// %Tag(FULLTEXT)%
// %Tag(ROS_HEADER)%
#include "ros/ros.h"
// %EndTag(ROS_HEADER)%
// %Tag(MSG_HEADER)%

//#include "std_msgs/String.h"
#include "my_msg_pkg/Num.h"


// %EndTag(MSG_HEADER)%

#include <sstream>

/**
 * This tutorial demonstrates simple sending of messages over the ROS system.
 */
int main(int argc, char **argv)
{
  /**
   * The ros::init() function needs to see argc and argv so that it can perform
   * any ROS arguments and name remapping that were provided at the command line. For programmatic
   * remappings you can use a different version of init() which takes remappings
   * directly, but for most command-line programs, passing argc and argv is the easiest
   * way to do it.  The third argument to init() is the name of the node.
   *
   * You must call one of the versions of ros::init() before using any other
   * part of the ROS system.
   */
// %Tag(INIT)%
  ros::init(argc, argv, "talker");
// %EndTag(INIT)%

  /**
   * NodeHandle is the main access point to communications with the ROS system.
   * The first NodeHandle constructed will fully initialize this node, and the last
   * NodeHandle destructed will close down the node.
   */
// %Tag(NODEHANDLE)%
  ros::NodeHandle n;
// %EndTag(NODEHANDLE)%

  /**
   * The advertise() function is how you tell ROS that you want to
   * publish on a given topic name. This invokes a call to the ROS
   * master node, which keeps a registry of who is publishing and who
   * is subscribing. After this advertise() call is made, the master
   * node will notify anyone who is trying to subscribe to this topic name,
   * and they will in turn negotiate a peer-to-peer connection with this
   * node.  advertise() returns a Publisher object which allows you to
   * publish messages on that topic through a call to publish().  Once
   * all copies of the returned Publisher object are destroyed, the topic
   * will be automatically unadvertised.
   *
   * The second parameter to advertise() is the size of the message queue
   * used for publishing messages.  If messages are published more quickly
   * than we can send them, the number here specifies how many messages to
   * buffer up before throwing some away.
   */
// %Tag(PUBLISHER)%
  ros::Publisher chatter_pub = n.advertise<my_msg_pkg::Num>("chatter", 1000);
// %EndTag(PUBLISHER)%

// %Tag(LOOP_RATE)%
  ros::Rate loop_rate(10);
// %EndTag(LOOP_RATE)%

  /**
   * A count of how many messages we have sent. This is used to create
   * a unique string for each message.
   */
// %Tag(ROS_OK)%
  int count = 0;
  while (ros::ok())
  {
// %EndTag(ROS_OK)%
    /**
     * This is a message object. You stuff it with data, and then publish it.
     */
// %Tag(FILL_MESSAGE)%
    my_msg_pkg::Num msg;

    //std::stringstream ss;
    //ss << "hello world " << count;
    //msg.data = ss.str();
	msg.num = count;
// %EndTag(FILL_MESSAGE)%

// %Tag(ROSCONSOLE)%
    //ROS_INFO("%s", msg.data.c_str());
	ROS_INFO("%d", msg.num);
// %EndTag(ROSCONSOLE)%

    /**
     * The publish() function is how you send messages. The parameter
     * is the message object. The type of this object must agree with the type
     * given as a template parameter to the advertise<>() call, as was done
     * in the constructor above.
     */
// %Tag(PUBLISH)%
    chatter_pub.publish(msg);
// %EndTag(PUBLISH)%

// %Tag(SPINONCE)%
    ros::spinOnce();
// %EndTag(SPINONCE)%

// %Tag(RATE_SLEEP)%
    loop_rate.sleep();
// %EndTag(RATE_SLEEP)%
    ++count;
  }
  return 0;
}
// %EndTag(FULLTEXT)%
----------------------------------------------------------------------------------------------------------

	notepad c:\work\overlay\src\listener\listener.cpp
	--> replace content with:
----------------------------------------------------------------------------------------------------------
/*
 * Copyright (C) 2008, Morgan Quigley and Willow Garage, Inc.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *   * Redistributions of source code must retain the above copyright notice,
 *     this list of conditions and the following disclaimer.
 *   * Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *   * Neither the names of Stanford University or Willow Garage, Inc. nor the names of its
 *     contributors may be used to endorse or promote products derived from
 *     this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

// %Tag(FULLTEXT)%
#include "ros/ros.h"
//#include "std_msgs/String.h"
#include "my_msg_pkg/Num.h"

/**
 * This tutorial demonstrates simple receipt of messages over the ROS system.
 */
// %Tag(CALLBACK)%
void chatterCallback(const my_msg_pkg::Num::ConstPtr& msg)
{
  ROS_INFO("I heard: [%d]", msg->num);
}
// %EndTag(CALLBACK)%

int main(int argc, char **argv)
{
  /**
   * The ros::init() function needs to see argc and argv so that it can perform
   * any ROS arguments and name remapping that were provided at the command line. For programmatic
   * remappings you can use a different version of init() which takes remappings
   * directly, but for most command-line programs, passing argc and argv is the easiest
   * way to do it.  The third argument to init() is the name of the node.
   *
   * You must call one of the versions of ros::init() before using any other
   * part of the ROS system.
   */
  ros::init(argc, argv, "listener");

  /**
   * NodeHandle is the main access point to communications with the ROS system.
   * The first NodeHandle constructed will fully initialize this node, and the last
   * NodeHandle destructed will close down the node.
   */
  ros::NodeHandle n;

  /**
   * The subscribe() call is how you tell ROS that you want to receive messages
   * on a given topic.  This invokes a call to the ROS
   * master node, which keeps a registry of who is publishing and who
   * is subscribing.  Messages are passed to a callback function, here
   * called chatterCallback.  subscribe() returns a Subscriber object that you
   * must hold on to until you want to unsubscribe.  When all copies of the Subscriber
   * object go out of scope, this callback will automatically be unsubscribed from
   * this topic.
   *
   * The second parameter to the subscribe() function is the size of the message
   * queue.  If messages are arriving faster than they are being processed, this
   * is the number of messages that will be buffered up before beginning to throw
   * away the oldest ones.
   */
// %Tag(SUBSCRIBER)%
  ros::Subscriber sub = n.subscribe("chatter", 1000, chatterCallback);
// %EndTag(SUBSCRIBER)%

  /**
   * ros::spin() will enter a loop, pumping callbacks.  With this version, all
   * callbacks will be called from within this thread (the main one).  ros::spin()
   * will exit when Ctrl-C is pressed, or the node is shutdown by the master.
   */
// %Tag(SPIN)%
  ros::spin();
// %EndTag(SPIN)%

  return 0;
}
// %EndTag(FULLTEXT)%
----------------------------------------------------------------------------------------------------------
	
	## update CMakeLists.txt for both packages
	notepad c:\work\overlay\src\talker\CMakeLists.txt
	--> replace content with:
----------------------------------------------------------------------------------------------------------
cmake_minimum_required(VERSION 2.8.3)
project(talker)

## Find catkin dependencies
find_package(catkin REQUIRED COMPONENTS roscpp my_msg_pkg)

include_directories(${catkin_INCLUDE_DIRS})

add_executable(talker talker.cpp)
target_link_libraries(talker ${catkin_LIBRARIES})

catkin_package(CATKIN_DEPENDS message_runtime std_msgs)

install(TARGETS talker RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION})
----------------------------------------------------------------------------------------------------------

	notepad c:\work\overlay\src\listener\CMakeLists.txt
	--> replace content with:
----------------------------------------------------------------------------------------------------------
cmake_minimum_required(VERSION 2.8.3)
project(listener)

## Find catkin dependencies
find_package(catkin REQUIRED COMPONENTS roscpp my_msg_pkg)

include_directories(${catkin_INCLUDE_DIRS})

add_executable(listener listener.cpp)
target_link_libraries(listener ${catkin_LIBRARIES})

catkin_package(CATKIN_DEPENDS message_runtime std_msgs)

install(TARGETS listener RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION})
----------------------------------------------------------------------------------------------------------

	## update package.xml for both packages
	notepad c:\work\overlay\src\talker\package.xml
	--> replace content with:
----------------------------------------------------------------------------------------------------------
  <package>
	  <name>talker</name>
	  <version>0.0.1</version>
	  <description>talker</description>
	  <maintainer email="un@known.com">Un Known</maintainer>
	
	  <license>BSD</license>
	
	  <url type="website">http://www.google.com</url>

	  <author email="un@known.com">Un Known</author>
	
	  <buildtool_depend>catkin</buildtool_depend>
	
	  <build_depend>roscpp</build_depend>
	  <build_depend>my_msg_pkg</build_depend>
	
	  <run_depend>roscpp</run_depend>
	  <run_depend>my_msg_pkg</run_depend>
	  <run_depend>std_msgs</run_depend>
	  <run_depend>message_runtime</run_depend>
	
  </package>
----------------------------------------------------------------------------------------------------------	

	notepad c:\work\overlay\src\listener\package.xml
	--> replace content with:	
----------------------------------------------------------------------------------------------------------
  <package>
	  <name>listener</name>
	  <version>0.0.1</version>
	  <description>listener</description>
	  <maintainer email="un@known.com">Un Known</maintainer>
	
	  <license>BSD</license>
	
	  <url type="website">http://www.google.com</url>

	  <author email="un@known.com">Un Known</author>
	
	  <buildtool_depend>catkin</buildtool_depend>
	
	  <build_depend>roscpp</build_depend>
	  <build_depend>my_msg_pkg</build_depend>
	
	  <run_depend>roscpp</run_depend>
	  <run_depend>my_msg_pkg</run_depend>
	  <run_depend>std_msgs</run_depend>
	  <run_depend>message_runtime</run_depend>
	
</package>
----------------------------------------------------------------------------------------------------------	
	
	## build the modified packages
	
	cd c:\work\overlay
	setup.bat
	winros_make --pre-clean
	
	
	## now test the modified talker and listener
	
	--> open 3 new terminals
		.. for each terminal: run c:\work\overlay\devel\setup.bat
	cd c:\work\overlay
	devel\setup.bat
	
	--> then start: roscore, talker, and listener
	1) roscore											# start ros-master
	2) c:\work\overlay\build\talker\talker.exe			# start talker
	3) c:\work\overlay\build\listener\listener.exe		# start listener
	
	
	==> talker should send, and listener receive.. ( attribute "num" of type "my_msg_pkg.Num" )	

##############################################################################################################
Issues to take a look at:
	- rosrun does not find talker and listener packages..
	  --> why?
	  --> workaround is to start talker.exe and listener.exe manually



Troubleshooting:
	- make sure to use rosdeps for groovy, when extracting rosdeps into c:\opt! (ros-wiki hydro tutorials link to rosdeps-hydro...)
		http://files.yujinrobot.com/win_ros/rosdeps/rosdeps-groovy-x86-vc10.zip
	  
	- use WinRos_Python_Build_Tools version 0.2.5
		http://files.yujinrobot.com/repositories/windows/python/2.7/winros-python-build-tools-0.2.5.win32.msi
	  
	- winros_python_build_tools 0.2.5 does not generate correct config.cmake file!
		--> this will cause an error about "Boost not found"
		--> to fix this just edit config.cmake as described, change the following lines:
		notepad c:\work\overlay\config.cmake
		----------------------------------------------------------------------------------------------------------
			set(ROSDEPS_ROOT "C:/opt/rosdeps/hydro/x86" CACHE STRING "System root for ros dependency.")
			set(INSTALL_ROOT "C:/opt/overlay/hydro/x86" CACHE PATH "Install root.")
		----------------------------------------------------------------------------------------------------------
			... into:
		----------------------------------------------------------------------------------------------------------
			set(ROSDEPS_ROOT "C:/opt/rosdeps/groovy/x86" CACHE STRING "System root for ros dependency.")
			set(INSTALL_ROOT "C:/opt/ros/groovy/x86" CACHE PATH "Install root.")
		----------------------------------------------------------------------------------------------------------
		
	- "gtest" not found: download gtest via svn (if needed because winros_make failed..)
		--> solution is described in error-message:
			You can run 'svn checkout http://googletest.googlecode.com/svn/tags/release-1.6.0 gtest' in the root of your workspace
		--> root of workspace means c:\work\overlay\src
		cd c:\work\overlay\src
		svn checkout http://googletest.googlecode.com/svn/tags/release-1.6.0 gtest
		
	- build-errors because of missing (/not yet ported) dependencies:
		remove packages from common_tutorials
		.. just goto c:\work\overlay\src\common_tutorials and remove following package folders
		.. (should also remove those packages from package.xml etc. ..but removing the folders works good enough)
		- pluginlib
		- nodelet_tutorial_math
		- turtle_actionlib
	
	- Boost-Errors:
		--> forgot to extract rosdeps into c:\opt ?
		  (this is described here: https://github.com/ipa-fxm-db/windows_ros-groovy)
		--> make sure you extracted the correct package for your ros-version. there are different downloads for groovy and hydro!
	
	- genaction.py gets opened in editor instead of being called to generate msg-files
		--> https://3c.gmx.net/mail/client/dereferrer?redirectUrl=http%3A%2F%2Fstackoverflow.com%2Fquestions%2F7690150%2Fpython-sys-argv-out-of-range-dont-understand-why
		--> SOLUTION: just right-click a .py file and choose python.exe as default programm for all .py files
	
	- error because of windows/unix line-endings in .cpp or other files
		--> use notepad++: edit -> line-endings conversion --> Unix-style
	
	- 
