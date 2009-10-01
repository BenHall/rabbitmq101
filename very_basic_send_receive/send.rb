require 'rubygems'
require 'amqp'
require 'mq'

AMQP.start(:host => 'localhost') do

  def log *args
    p args
  end

  AMQP.logging = true

  qone = MQ.new.fanout('q_one')
  EM.add_periodic_timer(1){
    time = Time.now
    qone.publish(Marshal.dump('Publishing >> ' + time.to_s))
  }
end
