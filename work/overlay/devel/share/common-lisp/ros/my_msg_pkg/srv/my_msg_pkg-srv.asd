
(cl:in-package :asdf)

(defsystem "my_msg_pkg-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :my_msg_pkg-msg
)
  :components ((:file "_package")
    (:file "HelloDude" :depends-on ("_package_HelloDude"))
    (:file "_package_HelloDude" :depends-on ("_package"))
  ))