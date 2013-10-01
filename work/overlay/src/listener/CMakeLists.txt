cmake_minimum_required(VERSION 2.8.3)
project(listener)

## Find catkin dependencies
find_package(catkin REQUIRED COMPONENTS roscpp my_msg_pkg)

include_directories(${catkin_INCLUDE_DIRS})

add_executable(listener listener.cpp)
target_link_libraries(listener ${catkin_LIBRARIES})

catkin_package(CATKIN_DEPENDS message_runtime std_msgs)

install(TARGETS listener RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION})