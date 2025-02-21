#
# When booting the Intercom messenger on any website we make a request to the "ping" endpoint with the user credentials.
# We want to analyse the number of requests per user to this endpoint in select periods of time.
# These periods are partitioned into smaller chunks based on a certain frequency (minute/hour/day).
#
# You have to design and implement the following API:
# Class: PingFrequency
# Function: void record_ping(<string> userId, <integer> Time)
# Function: List<Integer> getUserPingsPerInterval(<string> userId, <string> freq, <integer> startTime, <integer> endTime)
#
# Example:
#
# INPUT
# record_ping("user_1", 5)
# record_ping("user_2", 15)
# record_ping("user_2", 20)
# record_ping("user_1", 90)
# record_ping("user_3", 100)
# record_ping("user_1", 110)
# record_ping("user_3", 120)
# record_ping("user_3", 170)
# record_ping("user_2", 2500)
# record_ping("user_3", 3600)
# record_ping("user_3", 3800)
#
# INPUT - getUserPingsPerInterval("user_1", "minute", 0, 150)
# OUTPUT - [1, 2, 0]
#
# Explanation: This is partitioned into [0-59, 60-119, 120-150]
# Within the 0-59 window, the user pinged once.
# Within the 60-119 window, the user pinged twice.
# They made no request in the last window.
# This leads to a final result of: [1, 2, 0]
#
# INPUT - getUserPingsPerInterval("user_3", "hour", 10, 4000)
# OUTPUT - [4, 1]
#
# Explanation: This is partitioned into [10-3609, 3610-4000]
# Within the 10-3609 window, the user pinged 4 times.
# Within the 3610-4000 window, they pinged once.
# This leads to the final result of: [4, 1]
#
#
#
# class PingFrequency
#   def record_ping(user_id, time)
#
#   end
#
#   def get_user_pings_per_interval(user_id, freq, start_time, end_time)
#
#   end
# end
#
# # Your PingFrequency object will be instantiated and called as such:
# # obj = PingFrequency.new()
# # obj.record_ping("user_1", 5)
# # obj.record_ping("user_2", 15)
# # ...
# # obj.get_user_pings_per_interval("user_1", "minute", 0, 150)
#


class PingFrequency
	attr_accessor :store

	def initialize
		@store = {}
	end

  def record_ping(user_id, time)
  	raise 'Invalid argument' if user_id.nil? || time.nil?

  	store[user_id] ||= []
  	store[user_id] << time
  end

  def get_user_pings_per_interval(user_id, freq, start_time, end_time)
  	user_pings = store[user_id]
  	return [] if user_pings.nil?

  	intervals = identify_intervals(freq, start_time, end_time)

  	user_pings.each do |ping|
  		intervals.each_key do |interval|
  			if interval.cover?(ping)
  				intervals[interval] += 1
  				break
  			end
  		end
  	end

  	intervals.values
  end

  private

  def identify_intervals(freq, start_time, end_time)
  	duration = identify_duration(freq)
  	range = {}

  	while(start_time < end_time) do
  		temp = [start_time + duration - 1, end_time].min
  		range[(start_time..temp)] = 0
  		start_time = temp + 1
  	end

  	range
  end

  def identify_duration(freq)
  	case freq
  	when 'minute' then 60
  	when 'hour' then 60 * 60
  	when 'day' then 24 * 60 * 60
  	else raise 'Invalid Frequency'
  	end
  end
end


def main
	obj = PingFrequency.new
	obj.record_ping("user_1", 5)
	obj.record_ping("user_2", 15)
	obj.record_ping("user_2", 20)
	obj.record_ping("user_1", 90)
	obj.record_ping("user_3", 100)
	obj.record_ping("user_1", 110)
	obj.record_ping("user_3", 120)
	obj.record_ping("user_3", 170)
	obj.record_ping("user_2", 2500)
	obj.record_ping("user_3", 3600)
	obj.record_ping("user_3", 3800)

	pp obj.store

	obj.get_user_pings_per_interval("user_1", "minute", 0, 150)
	obj.get_user_pings_per_interval("user_3", "hour", 10, 4000)
end

main
