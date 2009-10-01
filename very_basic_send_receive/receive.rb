require 'rubygems'
require 'amqp'
require 'mq'

AMQP.start(:host => 'localhost') do

 amq = MQ.new
  amq.queue('every second').bind(amq.fanout('q_one')).subscribe{ |time|
	puts Marshal.load(time)
  }
end
