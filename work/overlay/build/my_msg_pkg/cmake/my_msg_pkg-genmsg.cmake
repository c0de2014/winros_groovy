# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "my_msg_pkg: 1 messages, 1 services")

set(MSG_I_FLAGS "-Imy_msg_pkg:C:/work/overlay/src/my_msg_pkg/msg;-Istd_msgs:C:/opt/ros/groovy/x86/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(genlisp REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(my_msg_pkg_generate_messages ALL)

#
#  langs = gencpp;genlisp;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(my_msg_pkg
  "C:/work/overlay/src/my_msg_pkg/msg/Num.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/my_msg_pkg
)

### Generating Services
_generate_srv_cpp(my_msg_pkg
  "C:/work/overlay/src/my_msg_pkg/srv/HelloDude.srv"
  "${MSG_I_FLAGS}"
  "C:/work/overlay/src/my_msg_pkg/msg/Dude.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/my_msg_pkg
)

### Generating Module File
_generate_module_cpp(my_msg_pkg
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/my_msg_pkg
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(my_msg_pkg_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(my_msg_pkg_generate_messages my_msg_pkg_generate_messages_cpp)

# target for backward compatibility
add_custom_target(my_msg_pkg_gencpp)
add_dependencies(my_msg_pkg_gencpp my_msg_pkg_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS my_msg_pkg_generate_messages_cpp)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(my_msg_pkg
  "C:/work/overlay/src/my_msg_pkg/msg/Num.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/my_msg_pkg
)

### Generating Services
_generate_srv_lisp(my_msg_pkg
  "C:/work/overlay/src/my_msg_pkg/srv/HelloDude.srv"
  "${MSG_I_FLAGS}"
  "C:/work/overlay/src/my_msg_pkg/msg/Dude.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/my_msg_pkg
)

### Generating Module File
_generate_module_lisp(my_msg_pkg
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/my_msg_pkg
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(my_msg_pkg_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(my_msg_pkg_generate_messages my_msg_pkg_generate_messages_lisp)

# target for backward compatibility
add_custom_target(my_msg_pkg_genlisp)
add_dependencies(my_msg_pkg_genlisp my_msg_pkg_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS my_msg_pkg_generate_messages_lisp)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(my_msg_pkg
  "C:/work/overlay/src/my_msg_pkg/msg/Num.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/my_msg_pkg
)

### Generating Services
_generate_srv_py(my_msg_pkg
  "C:/work/overlay/src/my_msg_pkg/srv/HelloDude.srv"
  "${MSG_I_FLAGS}"
  "C:/work/overlay/src/my_msg_pkg/msg/Dude.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/my_msg_pkg
)

### Generating Module File
_generate_module_py(my_msg_pkg
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/my_msg_pkg
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(my_msg_pkg_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(my_msg_pkg_generate_messages my_msg_pkg_generate_messages_py)

# target for backward compatibility
add_custom_target(my_msg_pkg_genpy)
add_dependencies(my_msg_pkg_genpy my_msg_pkg_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS my_msg_pkg_generate_messages_py)


debug_message(2 "my_msg_pkg: Iflags=${MSG_I_FLAGS}")


if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/my_msg_pkg)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/my_msg_pkg
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
add_dependencies(my_msg_pkg_generate_messages_cpp std_msgs_generate_messages_cpp)

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/my_msg_pkg)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/my_msg_pkg
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
add_dependencies(my_msg_pkg_generate_messages_lisp std_msgs_generate_messages_lisp)

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/my_msg_pkg)
  install(CODE "execute_process(COMMAND \"C:/Python27/python.exe\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/my_msg_pkg\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/my_msg_pkg
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
add_dependencies(my_msg_pkg_generate_messages_py std_msgs_generate_messages_py)
