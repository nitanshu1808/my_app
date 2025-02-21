class User < ApplicationRecord
	has_many :sender_messages, foreign_key: 'sender_id', class_name: 'Message'
	has_many :recipient_messages, foreign_key: 'recipient_id', class_name: 'Message'
end
