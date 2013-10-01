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
