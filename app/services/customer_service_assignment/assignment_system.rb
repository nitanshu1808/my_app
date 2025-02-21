require 'byebug'

# Intercom builds a customer service product that allows businesses to talk to their end users.
# In this programming exercise, we’d like you to build functionality that determines how conversations
# should be assigned to the customer support staff (who we will refer to as “operators”).

# Task: Load-balanced assignments
# Implement a AssignmentSystem class that has the following API:
# - Initializes with a set of available operators.
# - set_limit(operator_name, n)
#   Sets an operator’s limit.
# - assign(conversation_id)
#   Assigns a given conversation to the next available operator.
# - get_assignment_queue(n)
#   Returns a queue of size n of the next possible assignments, respecting operators’ limits and balancing load fairly.

# Requirements
# 1. Multiple Operators: Multiple operators are handling support conversations.
# 2. Load balanced: Assign conversations to the operator with the least current assignments.
#   Tie-Breaking Rule: If multiple operators have the same number of assignments, priority is given to 
#   the operator who received their most recent assignment the earliest.
# 3. Assignment limits: Do not assign more than the specific limit of conversations.
#   The default limit is 2 assignments per operator.
# '''


# # Example
# # operators = ["Alice", "Bob", "Charlie"]
# # system = AssignmentSystem(operators)

# # system.set_limit("Bob", 4)
# # system.set_limit("Charlie", 3)

# # I want to know who will receive next 4 conversations
# # system.get_assignment_queue(4)
# # ["Alice", "Bob", "Charlie", "Alice"]

# # Make some assignments
# # system.assign(101)  # Assigns to Alice
# # system.assign(102)  # Assigns to Bob
# # system.assign(103)  # Assigns to Charlie
# # system.assign(104)  # Assigns to Alice

# # Now that the above assignments have been made, I want to know who will receive next 5 conversations
# # system.get_assignment_queue(5)
# # ['Bob', 'Charlie', 'Bob', 'Charlie', 'Bob']


class AssignmentSystem
	attr_accessor :operators

	def initialize(list)
		@operators = list.map { |name| Operator.new(name) }
	end

	def set_limit(operator_name, limit)
		operator = operators.find { |op| op.name == operator_name }
    operator.limit = limit if operator
	end

	def assign(conversation_id)
		operator = next_available_operator
		operator.assign_conversation(conversation_id)
	end

	def get_assignment_queue(num)
		Array.new(4) { next_available_operator&.name }
	end


	private

	def next_available_operator
		available_operators = operators.select { |operator| operator.conversations.size < operator.limit }

		return nil if available_operators.nil?

		available_operators.min_by { |operator| operator.conversations.size }
	end


end


class Operator
	attr_accessor :name, :limit, :conversations

	def initialize(name, limit=nil)
		@name = name
		@limit = limit || 0
		@conversations = []
		@recently_assigned = false
	end

	def assign_conversation(conversation_id)
		conversations << conversation_id
	end
end


def main
	obj = AssignmentSystem.new(["Alice", "Bob", "Charlie"])
	obj.operators
	obj.set_limit("Bob", 1)
	obj.set_limit("Charlie", 3)
	obj.set_limit("Alice", 3)
	obj.operators

	obj.assign(1)
	obj.assign(2)
	obj.assign(3)
	obj.assign(4)
	obj.assign(5)
	obj.assign(6)
	pp obj.operators	

	pp obj.get_assignment_queue(4)
end

main