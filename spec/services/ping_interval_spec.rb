require 'rails_helper'

RSpec.describe PingInterval do
	let(:ping_interval) { described_class.new }


	describe '#record_ping' do
		subject { ping_interval.record_ping(user_id, time) }
		
		context "when valid arguments are passed"	do
			let(:user_id) { 'user_a' }
			let(:time) { 10 }

			it { is_expected.to eql({ user_id => [time] }) }
		end

		context "when invalid arguments are passed"	do
			let(:user_id) { nil }
			let(:time) { 10 }

			it 'raises an error' do
			  expect { subject }.to raise_error(RuntimeError, 'Invalid arguments')
			end
		end


		context "when pings are already recorded" do
			let(:expected_outcome) do
				{
					"user_1" => [5,90,110],
					"user_2" => [15, 20, 2500],
					"user_3" => [100, 120, 170, 3600, 3800]
				}
			end


			before do
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
			end

			it "verifies the user recorded pings" do
			  expect(ping_interval.ping_tracker).to eql(expected_outcome)
			end
		end
	end

	describe '#get_user_pings_per_interval' do
		subject { ping_interval.get_user_pings_per_interval(user_id, freq, start_time, end_time) }

		before do
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
		end

		context "when freq is minute" do
			let(:freq) { 'minute' }
			let(:start_time) { 0 }
			let(:end_time) { 150 }
			let(:user_id) { 'user_1' }

			let(:expected_outcome) { [1,2,0] }

			it { is_expected.to eql(expected_outcome) }
		end

		context "when freq is hour" do
			let(:freq) { 'hour' }
			let(:start_time) { 0 }
			let(:end_time) { 5800 }
			let(:user_id) { 'user_1' }

			let(:expected_outcome) { [3,0] }

			it { is_expected.to eql(expected_outcome) }
		end

		context "when freq is day" do
			let(:freq) { 'day' }
			let(:start_time) { 10 }
			let(:end_time) { 5800 }
			let(:user_id) { 'user_3' }

			let(:expected_outcome) { [5] }

			it { is_expected.to eql(expected_outcome) }
		end
	end
end