require 'byebug'

class SystemEventFrequency
  attr_accessor :system_event_logger

  def initialize
    @system_event_logger = {}
  end

  def log_event(event_id, time)
    if system_event_logger[event_id]
      system_event_logger[event_id] << time
    else
      system_event_logger[event_id] = [time]
    end
  end

  def get_event_count_per_interval(event_id, freq, start_time, end_time)
    event_log = system_event_logger[event_id]
    return [] if event_log.nil?

    event_range_interval = identify_event_range(freq, start_time, end_time)

    event_log.each do |log|
      event_range_interval.each do |range, val|
        if range.to_a.include?(log)
          event_range_interval[range] += 1
          break
        end
      end
    end

    event_range_interval.values
  end

  def identify_event_range(freq, start_time, end_time)
    duration = start_time +
      case freq
      when 'minute' then 60
      when 'hour' then 60 * 60
      when 'day' then 24 * 60 * 60
      else raise 'Invalid Frequency'
      end

    event_range = {}

    while start_time < end_time
      if duration > end_time
        event_range[start_time..end_time] = 0
      else
        event_range[start_time..duration-1] = 0
      end

      start_time = duration
      duration += duration
    end
    puts event_range
    event_range
  end
end


def main
  obj = SystemEventFrequency.new
  obj.log_event("event_1", 5)
  obj.log_event("event_1", 10)
  obj.log_event("event_2", 15)
  obj.log_event("event_1", 100)
  obj.log_event("event_2", 150)
  obj.log_event("event_1", 200)
  obj.log_event("event_1", 250)
  obj.log_event("event_2", 500)
  puts "obj.system_event_logger #{obj.system_event_logger}"

  puts obj.get_event_count_per_interval("event_1", "minute", 0, 300)
end

main

# (0..59)

# Problem 2: System Event Frequency

# You are developing a logging system to monitor system events. The system logs events with their timestamps, and you need to count the events in given time intervals (daily, hourly, etc.).

# You have to design and implement the following API:

# Class: EventFrequency
# Function: void log_event(<string> eventId, <integer> timestamp)
# Function: List<Integer> getEventCountPerInterval(<string> eventId, <string> freq, <integer> startTime, <integer> endTime)
# Example:

# log_event("error_1", 5)
# log_event("error_1", 10)
# log_event("error_2", 15)
# log_event("error_1", 100)
# log_event("error_2", 150)
# log_event("error_1", 200)
# log_event("error_1", 250)
# log_event("error_2", 500)

# getEventCountPerInterval("error_1", "hour", 0, 300)
