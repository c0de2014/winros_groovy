/* Software License Agreement (BSD License)
 *
 * Copyright (c) 2011, Willow Garage, Inc.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 *  * Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *  * Redistributions in binary form must reproduce the above
 *    copyright notice, this list of conditions and the following
 *    disclaimer in the documentation and/or other materials provided
 *    with the distribution.
 *  * Neither the name of Willow Garage, Inc. nor the names of its
 *    contributors may be used to endorse or promote products derived
 *    from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
 * ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 *
 * Auto-generated by genmsg_cpp from file C:\work\overlay\src\my_msg_pkg\srv\HelloDude.srv
 *
 */


#ifndef MY_MSG_PKG_MESSAGE_HELLODUDEREQUEST_H
#define MY_MSG_PKG_MESSAGE_HELLODUDEREQUEST_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace my_msg_pkg
{
template <class ContainerAllocator>
struct HelloDudeRequest_
{
  typedef HelloDudeRequest_<ContainerAllocator> Type;

  HelloDudeRequest_()
    : greeting()  {
    }
  HelloDudeRequest_(const ContainerAllocator& _alloc)
    : greeting(_alloc)  {
    }



   typedef std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other >  _greeting_type;
  _greeting_type greeting;




  typedef boost::shared_ptr< ::my_msg_pkg::HelloDudeRequest_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::my_msg_pkg::HelloDudeRequest_<ContainerAllocator> const> ConstPtr;
  boost::shared_ptr<std::map<std::string, std::string> > __connection_header;

}; // struct HelloDudeRequest_

typedef ::my_msg_pkg::HelloDudeRequest_<std::allocator<void> > HelloDudeRequest;

typedef boost::shared_ptr< ::my_msg_pkg::HelloDudeRequest > HelloDudeRequestPtr;
typedef boost::shared_ptr< ::my_msg_pkg::HelloDudeRequest const> HelloDudeRequestConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::my_msg_pkg::HelloDudeRequest_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::my_msg_pkg::HelloDudeRequest_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace my_msg_pkg

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': False, 'IsMessage': True, 'HasHeader': False}
// {'my_msg_pkg': ['C:/work/overlay/src/my_msg_pkg/msg'], 'std_msgs': ['C:/opt/ros/groovy/x86/share/std_msgs/cmake/../msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::my_msg_pkg::HelloDudeRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::my_msg_pkg::HelloDudeRequest_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::my_msg_pkg::HelloDudeRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::my_msg_pkg::HelloDudeRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::my_msg_pkg::HelloDudeRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::my_msg_pkg::HelloDudeRequest_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::my_msg_pkg::HelloDudeRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "af3498ba158bcdd555fe81847eb6e16d";
  }

  static const char* value(const ::my_msg_pkg::HelloDudeRequest_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xaf3498ba158bcdd5ULL;
  static const uint64_t static_value2 = 0x55fe81847eb6e16dULL;
};

template<class ContainerAllocator>
struct DataType< ::my_msg_pkg::HelloDudeRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "my_msg_pkg/HelloDudeRequest";
  }

  static const char* value(const ::my_msg_pkg::HelloDudeRequest_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::my_msg_pkg::HelloDudeRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "string greeting\n\
\n\
";
  }

  static const char* value(const ::my_msg_pkg::HelloDudeRequest_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::my_msg_pkg::HelloDudeRequest_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.greeting);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER;
  }; // struct HelloDudeRequest_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::my_msg_pkg::HelloDudeRequest_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::my_msg_pkg::HelloDudeRequest_<ContainerAllocator>& v)
  {
    s << indent << "greeting: ";
    Printer<std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other > >::stream(s, indent + "  ", v.greeting);
  }
};

} // namespace message_operations
} // namespace ros

#endif // MY_MSG_PKG_MESSAGE_HELLODUDEREQUEST_H
