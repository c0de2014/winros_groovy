# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "learning_actionlib: 7 messages, 0 services")

set(MSG_I_FLAGS "-Ilearning_actionlib:C:/work/overlay/devel/share/learning_actionlib/msg;-Istd_msgs:C:/opt/ros/groovy/x86/share/std_msgs/cmake/../msg;-Iactionlib_msgs:C:/opt/ros/groovy/x86/share/actionlib_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(genlisp REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(learning_actionlib_generate_messages ALL)

#
#  langs = gencpp;genlisp;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(learning_actionlib
  "C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/learning_actionlib
)
_generate_msg_cpp(learning_actionlib
  "C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciActionResult.msg"
  "${MSG_I_FLAGS}"
  "C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciResult.msg;C:/opt/ros/groovy/x86/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;C:/opt/ros/groovy/x86/share/std_msgs/cmake/../msg/Header.msg;C:/opt/ros/groovy/x86/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/learning_actionlib
)
_generate_msg_cpp(learning_actionlib
  "C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciActionGoal.msg"
  "${MSG_I_FLAGS}"
  "C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciGoal.msg;C:/opt/ros/groovy/x86/share/std_msgs/cmake/../msg/Header.msg;C:/opt/ros/groovy/x86/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/learning_actionlib
)
_generate_msg_cpp(learning_actionlib
  "C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/learning_actionlib
)
_generate_msg_cpp(learning_actionlib
  "C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciFeedback.msg;C:/opt/ros/groovy/x86/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;C:/opt/ros/groovy/x86/share/std_msgs/cmake/../msg/Header.msg;C:/opt/ros/groovy/x86/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/learning_actionlib
)
_generate_msg_cpp(learning_actionlib
  "C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciAction.msg"
  "${MSG_I_FLAGS}"
  "C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciFeedback.msg;C:/opt/ros/groovy/x86/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;C:/opt/ros/groovy/x86/share/std_msgs/cmake/../msg/Header.msg;C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciGoal.msg;C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciActionGoal.msg;C:/opt/ros/groovy/x86/share/actionlib_msgs/cmake/../msg/GoalID.msg;C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciActionResult.msg;C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciActionFeedback.msg;C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciResult.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/learning_actionlib
)
_generate_msg_cpp(learning_actionlib
  "C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/learning_actionlib
)

### Generating Services

### Generating Module File
_generate_module_cpp(learning_actionlib
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/learning_actionlib
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(learning_actionlib_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(learning_actionlib_generate_messages learning_actionlib_generate_messages_cpp)

# target for backward compatibility
add_custom_target(learning_actionlib_gencpp)
add_dependencies(learning_actionlib_gencpp learning_actionlib_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS learning_actionlib_generate_messages_cpp)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(learning_actionlib
  "C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/learning_actionlib
)
_generate_msg_lisp(learning_actionlib
  "C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciActionResult.msg"
  "${MSG_I_FLAGS}"
  "C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciResult.msg;C:/opt/ros/groovy/x86/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;C:/opt/ros/groovy/x86/share/std_msgs/cmake/../msg/Header.msg;C:/opt/ros/groovy/x86/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/learning_actionlib
)
_generate_msg_lisp(learning_actionlib
  "C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciActionGoal.msg"
  "${MSG_I_FLAGS}"
  "C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciGoal.msg;C:/opt/ros/groovy/x86/share/std_msgs/cmake/../msg/Header.msg;C:/opt/ros/groovy/x86/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/learning_actionlib
)
_generate_msg_lisp(learning_actionlib
  "C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/learning_actionlib
)
_generate_msg_lisp(learning_actionlib
  "C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciFeedback.msg;C:/opt/ros/groovy/x86/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;C:/opt/ros/groovy/x86/share/std_msgs/cmake/../msg/Header.msg;C:/opt/ros/groovy/x86/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/learning_actionlib
)
_generate_msg_lisp(learning_actionlib
  "C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciAction.msg"
  "${MSG_I_FLAGS}"
  "C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciFeedback.msg;C:/opt/ros/groovy/x86/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;C:/opt/ros/groovy/x86/share/std_msgs/cmake/../msg/Header.msg;C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciGoal.msg;C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciActionGoal.msg;C:/opt/ros/groovy/x86/share/actionlib_msgs/cmake/../msg/GoalID.msg;C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciActionResult.msg;C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciActionFeedback.msg;C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciResult.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/learning_actionlib
)
_generate_msg_lisp(learning_actionlib
  "C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/learning_actionlib
)

### Generating Services

### Generating Module File
_generate_module_lisp(learning_actionlib
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/learning_actionlib
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(learning_actionlib_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(learning_actionlib_generate_messages learning_actionlib_generate_messages_lisp)

# target for backward compatibility
add_custom_target(learning_actionlib_genlisp)
add_dependencies(learning_actionlib_genlisp learning_actionlib_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS learning_actionlib_generate_messages_lisp)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(learning_actionlib
  "C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/learning_actionlib
)
_generate_msg_py(learning_actionlib
  "C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciActionResult.msg"
  "${MSG_I_FLAGS}"
  "C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciResult.msg;C:/opt/ros/groovy/x86/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;C:/opt/ros/groovy/x86/share/std_msgs/cmake/../msg/Header.msg;C:/opt/ros/groovy/x86/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/learning_actionlib
)
_generate_msg_py(learning_actionlib
  "C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciActionGoal.msg"
  "${MSG_I_FLAGS}"
  "C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciGoal.msg;C:/opt/ros/groovy/x86/share/std_msgs/cmake/../msg/Header.msg;C:/opt/ros/groovy/x86/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/learning_actionlib
)
_generate_msg_py(learning_actionlib
  "C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/learning_actionlib
)
_generate_msg_py(learning_actionlib
  "C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciFeedback.msg;C:/opt/ros/groovy/x86/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;C:/opt/ros/groovy/x86/share/std_msgs/cmake/../msg/Header.msg;C:/opt/ros/groovy/x86/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/learning_actionlib
)
_generate_msg_py(learning_actionlib
  "C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciAction.msg"
  "${MSG_I_FLAGS}"
  "C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciFeedback.msg;C:/opt/ros/groovy/x86/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;C:/opt/ros/groovy/x86/share/std_msgs/cmake/../msg/Header.msg;C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciGoal.msg;C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciActionGoal.msg;C:/opt/ros/groovy/x86/share/actionlib_msgs/cmake/../msg/GoalID.msg;C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciActionResult.msg;C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciActionFeedback.msg;C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciResult.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/learning_actionlib
)
_generate_msg_py(learning_actionlib
  "C:/work/overlay/devel/share/learning_actionlib/msg/FibonacciResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/learning_actionlib
)

### Generating Services

### Generating Module File
_generate_module_py(learning_actionlib
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/learning_actionlib
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(learning_actionlib_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(learning_actionlib_generate_messages learning_actionlib_generate_messages_py)

# target for backward compatibility
add_custom_target(learning_actionlib_genpy)
add_dependencies(learning_actionlib_genpy learning_actionlib_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS learning_actionlib_generate_messages_py)


debug_message(2 "learning_actionlib: Iflags=${MSG_I_FLAGS}")


if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/learning_actionlib)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/learning_actionlib
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
add_dependencies(learning_actionlib_generate_messages_cpp std_msgs_generate_messages_cpp)
add_dependencies(learning_actionlib_generate_messages_cpp actionlib_msgs_generate_messages_cpp)

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/learning_actionlib)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/learning_actionlib
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
add_dependencies(learning_actionlib_generate_messages_lisp std_msgs_generate_messages_lisp)
add_dependencies(learning_actionlib_generate_messages_lisp actionlib_msgs_generate_messages_lisp)

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/learning_actionlib)
  install(CODE "execute_process(COMMAND \"C:/Python27/python.exe\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/learning_actionlib\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/learning_actionlib
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
add_dependencies(learning_actionlib_generate_messages_py std_msgs_generate_messages_py)
add_dependencies(learning_actionlib_generate_messages_py actionlib_msgs_generate_messages_py)
