require 'rubygems'
require 'amqp'
require 'mq'

class TestObject
   def initialize(msg)
    @msg = msg
   end
   def get
    "This was my message: " + @msg
   end
   def to_s
     @msg
   end
end

AMQP.start(:host => 'localhost') do

 amq = MQ.new
  amq.queue('every 5 seconds').bind(amq.fanout('q_one')).subscribe{ |time|
	obj = Marshal.load(time)
	puts obj.get
  }
end
