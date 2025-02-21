require 'byebug'

class PingFrequency
	attr_accessor :user_pings

	def initialize
		@user_pings = {}
	end

	def record_ping(user_id, time)
		user_pings[user_id] ||= []
		user_pings[user_id] << time
	end

	def get_user_pings_per_interval(user_id, freq, start_time, end_time)
		return [] if user_pings.nil?
		user_pings = @user_pings[user_id]
		return [] unless user_pings
		


		# determine interval
		intervals = determine_interval(freq, start_time, end_time)
		user_pings.each do |ping|
			intervals.each do |interval, val|
				if interval.to_a.include? ping
					intervals[interval] += 1
				end
			end
		end

		intervals.values
	end

	private

	def determine_interval(freq, start_time, end_time)
		intervals = {}
		duration = start_time

		duration =
			case freq
				when 'minute' then 60
				when 'hour' then 60 * 60
				when 'minute' then 60 * 60 * 24
				else raise 'invalid freq'
			end

		while start_time <= end_time
			next_time = [start_time + duration, end_time].min
			intervals[(start_time..(next_time))] = 0
			start_time = next_time
		end
		intervals
	end
end

png = PingFrequency.new

png.record_ping("user_1", 5)
png.record_ping("user_2", 15)
png.record_ping("user_2", 20)
png.record_ping("user_1", 90)
png.record_ping("user_3", 100)
png.record_ping("user_1", 110)
png.record_ping("user_3", 120)
png.record_ping("user_3", 170)
png.record_ping("user_2", 2500)
png.record_ping("user_3", 3600)
png.record_ping("user_3", 3800)

puts png.user_pings
puts "png.get_user_pings_per_interval('user_1', 'minute', 0, 150) for #{png.get_user_pings_per_interval("user_1", "minute", 0, 150)} should be equal to [1, 2, 0]"

puts "png.get_user_pings_per_interval('user_3', 'hour', 10, 4000) for #{png.get_user_pings_per_interval("user_3", "hour", 10, 4000)} should be equal to [4, 1]"


