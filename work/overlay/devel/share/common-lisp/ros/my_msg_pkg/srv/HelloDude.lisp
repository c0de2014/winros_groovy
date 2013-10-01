; Auto-generated. Do not edit!


(cl:in-package my_msg_pkg-srv)


;//! \htmlinclude HelloDude-request.msg.html

(cl:defclass <HelloDude-request> (roslisp-msg-protocol:ros-message)
  ((greeting
    :reader greeting
    :initarg :greeting
    :type cl:string
    :initform ""))
)

(cl:defclass HelloDude-request (<HelloDude-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HelloDude-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HelloDude-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name my_msg_pkg-srv:<HelloDude-request> is deprecated: use my_msg_pkg-srv:HelloDude-request instead.")))

(cl:ensure-generic-function 'greeting-val :lambda-list '(m))
(cl:defmethod greeting-val ((m <HelloDude-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader my_msg_pkg-srv:greeting-val is deprecated.  Use my_msg_pkg-srv:greeting instead.")
  (greeting m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HelloDude-request>) ostream)
  "Serializes a message object of type '<HelloDude-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'greeting))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'greeting))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HelloDude-request>) istream)
  "Deserializes a message object of type '<HelloDude-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'greeting) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'greeting) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HelloDude-request>)))
  "Returns string type for a service object of type '<HelloDude-request>"
  "my_msg_pkg/HelloDudeRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HelloDude-request)))
  "Returns string type for a service object of type 'HelloDude-request"
  "my_msg_pkg/HelloDudeRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HelloDude-request>)))
  "Returns md5sum for a message object of type '<HelloDude-request>"
  "129227e2fd0b0327c04b3887d00cb056")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HelloDude-request)))
  "Returns md5sum for a message object of type 'HelloDude-request"
  "129227e2fd0b0327c04b3887d00cb056")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HelloDude-request>)))
  "Returns full string definition for message of type '<HelloDude-request>"
  (cl:format cl:nil "string greeting~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HelloDude-request)))
  "Returns full string definition for message of type 'HelloDude-request"
  (cl:format cl:nil "string greeting~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HelloDude-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'greeting))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HelloDude-request>))
  "Converts a ROS message object to a list"
  (cl:list 'HelloDude-request
    (cl:cons ':greeting (greeting msg))
))
;//! \htmlinclude HelloDude-response.msg.html

(cl:defclass <HelloDude-response> (roslisp-msg-protocol:ros-message)
  ((dude
    :reader dude
    :initarg :dude
    :type my_msg_pkg-msg:Dude
    :initform (cl:make-instance 'my_msg_pkg-msg:Dude)))
)

(cl:defclass HelloDude-response (<HelloDude-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HelloDude-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HelloDude-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name my_msg_pkg-srv:<HelloDude-response> is deprecated: use my_msg_pkg-srv:HelloDude-response instead.")))

(cl:ensure-generic-function 'dude-val :lambda-list '(m))
(cl:defmethod dude-val ((m <HelloDude-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader my_msg_pkg-srv:dude-val is deprecated.  Use my_msg_pkg-srv:dude instead.")
  (dude m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HelloDude-response>) ostream)
  "Serializes a message object of type '<HelloDude-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'dude) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HelloDude-response>) istream)
  "Deserializes a message object of type '<HelloDude-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'dude) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HelloDude-response>)))
  "Returns string type for a service object of type '<HelloDude-response>"
  "my_msg_pkg/HelloDudeResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HelloDude-response)))
  "Returns string type for a service object of type 'HelloDude-response"
  "my_msg_pkg/HelloDudeResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HelloDude-response>)))
  "Returns md5sum for a message object of type '<HelloDude-response>"
  "129227e2fd0b0327c04b3887d00cb056")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HelloDude-response)))
  "Returns md5sum for a message object of type 'HelloDude-response"
  "129227e2fd0b0327c04b3887d00cb056")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HelloDude-response>)))
  "Returns full string definition for message of type '<HelloDude-response>"
  (cl:format cl:nil "Dude dude~%~%~%================================================================================~%MSG: my_msg_pkg/Dude~%string Dude~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HelloDude-response)))
  "Returns full string definition for message of type 'HelloDude-response"
  (cl:format cl:nil "Dude dude~%~%~%================================================================================~%MSG: my_msg_pkg/Dude~%string Dude~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HelloDude-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'dude))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HelloDude-response>))
  "Converts a ROS message object to a list"
  (cl:list 'HelloDude-response
    (cl:cons ':dude (dude msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'HelloDude)))
  'HelloDude-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'HelloDude)))
  'HelloDude-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HelloDude)))
  "Returns string type for a service object of type '<HelloDude>"
  "my_msg_pkg/HelloDude")