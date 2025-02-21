class PingInterval
  attr_accessor :ping_tracker

  def initialize
    @ping_tracker = {}
  end

  # records pinged for users
  def record_ping(user_id, time)
    raise 'Invalid arguments' if time.nil? || user_id.nil?

    if ping_tracker[user_id]
      ping_tracker[user_id] << time
    else
      ping_tracker[user_id] = [time]
    end

    ping_tracker
  end

  # freq =      minute,     hour,         day
  # duration =    60,      60 * 60,   24 * 60 * 60  
  def get_user_pings_per_interval(user_id, freq, start_time, end_time)
    raise 'Invalid arguments' if user_id.nil? || freq.nil? || start_time.nil? || end_time.nil?

    user_pings = ping_tracker[user_id]
    return [] if user_pings.nil?

    #{(0-59) => 0, (60-119) => 0, (120-150) => 0] OR 
    #{(10-3609) => 0, (3610-4000) => 0}
    range_intervals = identify_range(freq, start_time, end_time)

    user_pings.each do |ping|
      range_intervals.each do |range, value|
        if range.to_a.include?(ping)
          range_intervals[range] += 1
          break
        end
      end
    end

    range_intervals.values
  end

  def identify_range(freq, start_time, end_time)
    duration = 
      case freq
      when 'minute' then 60
      when 'hour' then 60 * 60
      when 'day' then 24 * 60 * 60
      else raise 'invalid frequency'
      end

    range_interval = {}

    while (start_time < end_time) do
      next_time = [start_time + duration, end_time].min - 1
      range_interval[start_time..next_time] = 0
      start_time = next_time
    end

    range_interval
  end
end

def main
  ping_interval = PingInterval.new
  ping_interval.record_ping("user_1", 5)
  ping_interval.record_ping("user_2", 15)
  ping_interval.record_ping("user_2", 20)
  ping_interval.record_ping("user_1", 90)
  ping_interval.record_ping("user_3", 100)
  ping_interval.record_ping("user_1", 110)
  ping_interval.record_ping("user_3", 120)
  ping_interval.record_ping("user_3", 170)
  ping_interval.record_ping("user_2", 2500)
  ping_interval.record_ping("user_3", 3600)
  ping_interval.record_ping("user_3", 3800)

  puts "png.get_user_pings_per_interval('user_1', 'minute', 0, 150) for #{ping_interval.get_user_pings_per_interval("user_1", "minute", 0, 150)} should be equal to [1, 2, 0]"

puts "png.get_user_pings_per_interval('user_3', 'hour', 10, 4000) for #{ping_interval.get_user_pings_per_interval("user_3", "hour", 10, 4000)} should be equal to [4, 1]"
end

main
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
