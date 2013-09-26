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
  	
# now create a simple publisher and subscriber to thest the new msg-file


  --> get ros_tutorials from github
  cd c:\work\overlay\src
  wstool set ros_tutorials --git https://github.com/ros/ros_tutorials.git -v groovy-devel
  wstool update ros_tutorials
  
  --> copy folders "talker" and "listener" from: C:\work\overlay\src\ros_tutorials\roscpp_tutorials
  	to: C:\work\overlay\src\
  --> rename the new folders to my_talker and my_listener
  --> change CMakeLists.txt in both folders to match the new package names (add my_.... to listener and talker)
  	
  	include_directories(${catkin_INCLUDE_DIRS})
	add_executable(my_listener listener.cpp)
	target_link_libraries(my_listener ${catkin_LIBRARIES})
	install(TARGETS my_listener
  	RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION})
  	
      and
      
	include_directories(${catkin_INCLUDE_DIRS})
	add_executable(my_talker talker.cpp)
	target_link_libraries(my_talker ${catkin_LIBRARIES})
	install(TARGETS my_talker
  	RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION})
 
  --> remove "ros_tutorials"-folder because it contains a lot of dependencies that winros cannot resolve (yet)
 
  remove folder: "C:\work\overlay\ros_tutorials"
 
# build new packages (my_talker and my_listener)
  
  cd c:\work\overlay
  setup.bat
  winros_make --pre-clean
  
  --> should build to 100%
  
# test both scripts as they are now (with std_msgs)
  
  devel\setup.bat
  rosrun my_talker my_talker
  
  --> fails because package cannot be found


# fix CMakeLists.txt and package.xml for both packages
  
  --> replace content of "my_talker" CMakeLists.txt with:
  -------------------
	cmake_minimum_required(VERSION 2.8.3)
	project(my_talker)
	
	## Find catkin dependencies
	find_package(catkin REQUIRED COMPONENTS roscpp)
	
	include_directories(${catkin_INCLUDE_DIRS})
	
	add_executable(my_talker talker.cpp)
	target_link_libraries(my_talker ${catkin_LIBRARIES})
	
	catkin_package(CATKIN_DEPENDS message_runtime std_msgs)
	
	install(TARGETS my_talker RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION})
  ------------------
  
  --> replace content of "my_listener" CMakeLists.txt with:
  -------------------
	cmake_minimum_required(VERSION 2.8.3)
	project(my_listener)
	
	## Find catkin dependencies
	find_package(catkin REQUIRED COMPONENTS roscpp)
	
	include_directories(${catkin_INCLUDE_DIRS})
	
	add_executable(my_listener listener.cpp)
	target_link_libraries(my_listener ${catkin_LIBRARIES})
	
	catkin_package(CATKIN_DEPENDS message_runtime std_msgs)
	
	install(TARGETS my_listener RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION})
  ------------------
  
# create package.xml for both packages

  cd c:\work\overlay\src\my_talker
  touch package.xml
  notepad package.xml
  --> insert:
  -----------------------
  	<package>
	  <name>my_talker</name>
	  <version>0.0.1</version>
	  <description>my_talker</description>
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
  -----------------------


  cd c:\work\overlay\src\my_listener
  touch package.xml
  notepad package.xml
  --> insert:
  -----------------------
  	<package>
	  <name>my_listener</name>
	  <version>0.0.1</version>
	  <description>my_listener</description>
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
  -----------------------
  
  
# test talker and listener with std_msgs

  --> start roscore in a new terminal
	
	cd c:\work\overlay\
  	devel\setup.bat
  	roscore
  	
  --> start my_talker in a new terminal

	cd c:\work\overlay\
  	devel\setup.bat  
  	build\my_talker\my_talker.exe
  	
  --> start my_listener in a new terminal

	cd c:\work\overlay\
  	devel\setup.bat  
  	build\my_listener\my_listener.exe
  
  ==> talker should send, and listener receive..
  
# change talker and listener to use custom-message

  --> change my_talker.cpp to:
---------------------------------------------------------------------------------------------------------------------
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
	ROS_INFO("%s", msg.num);
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
---------------------------------------------------------------------------------------------------------------------


my_talker\CMakeLists.txt
---------------------------------------------------------------------------------------------------------------------
cmake_minimum_required(VERSION 2.8.3)
project(my_talker)

## Find catkin dependencies
find_package(catkin REQUIRED COMPONENTS roscpp my_msg_pkg)

include_directories(${catkin_INCLUDE_DIRS})

add_executable(my_talker talker.cpp)
target_link_libraries(my_talker ${catkin_LIBRARIES})

catkin_package(CATKIN_DEPENDS message_runtime std_msgs)

install(TARGETS my_talker RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION})
---------------------------------------------------------------------------------------------------------------------

my_talker\package.xml
---------------------------------------------------------------------------------------------------------------------
  <package>
	  <name>my_talker</name>
	  <version>0.0.1</version>
	  <description>my_talker</description>
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
---------------------------------------------------------------------------------------------------------------------


my_listener.cpp
---------------------------------------------------------------------------------------------------------------------
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
---------------------------------------------------------------------------------------------------------------------

my_listener\CMakeLists.txt
---------------------------------------------------------------------------------------------------------------------
cmake_minimum_required(VERSION 2.8.3)
project(my_listener)

## Find catkin dependencies
find_package(catkin REQUIRED COMPONENTS roscpp my_msg_pkg)

include_directories(${catkin_INCLUDE_DIRS})

add_executable(my_listener listener.cpp)
target_link_libraries(my_listener ${catkin_LIBRARIES})

catkin_package(CATKIN_DEPENDS message_runtime std_msgs)

install(TARGETS my_listener RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION})
---------------------------------------------------------------------------------------------------------------------

my_listener\package.xml
---------------------------------------------------------------------------------------------------------------------
  <package>
	  <name>my_listener</name>
	  <version>0.0.1</version>
	  <description>my_listener</description>
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
---------------------------------------------------------------------------------------------------------------------
  
  
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
