class MovieTheatre
  attr_accessor :row_seats

  def initialize(row_seats)
    @row_seats = row_seats
  end

  # Check if a specific seat is available or booked
  def check_seat(row_number, seat_number)
    row, seat = find_row_and_seat(row_number, seat_number)
    seat
  end

  # Book a specific seat
  def book_seat(row_number, seat_number)
    row, seat = find_row_and_seat(row_number, seat_number)

    raise 'Seat already booked' if seat == 'booked'

    row[seat_number - 1] = 'booked'
    true
  end

  # Find the first available seat in the theatre
  def find_first_available_seat
    row_seats.each do |row_name, seats|
      seats.each_with_index do |seat, index|
        return "#{row_name}#{index + 1}" if seat == 'available'
      end
    end
    'N/A'
  end

  # Calculate the percentage of seats booked
  def percentage_booked
    total_seats = row_seats.values.flatten.size
    booked_seats = row_seats.values.flatten.count('booked')

    ((booked_seats.to_f / total_seats) * 100).round(2)
  end

  private

  # Find row and seat safely, returning them as an array
  def find_row_and_seat(row_number, seat_number)
    row = find_row(row_number)
    raise 'Invalid Row' if row.nil?
    
    seat = find_seat(row, seat_number)
    raise 'Invalid Seat' if seat.nil?

    [row, seat]
  end

  # Get the row
  def find_row(row_number)
    row_seats[row_number]
  end

  # Get the seat, ensuring it exists within valid index range
  def find_seat(row, seat_number)
    row[seat_number - 1] if seat_number.between?(1, row.size)
  end
end


row_seats = {
  "A" => ["available", "booked", "available"],
  "B" => ["booked", "booked", "available"],
  "C" => ["available", "available", "booked"]
}


# Expected Output:

theatre = MovieTheatre.new(row_seats)
puts theatre.check_seat("A", 1) # => "available"
puts theatre.book_seat("A", 1) # => true  # Now "A1" is booked
puts theatre.find_first_available_seat # => "A3"
puts theatre.percentage_booked # => 50.0

# Movie Theater Booking System (Seats as Hash & Array)
# Scenario:
# You are designing a simple movie theater booking system. The seats are represented as a hash, where:

# Keys are row numbers (A, B, C, etc.).
# Values are arrays representing seats (e.g., ["available", "booked", "available"]).
# Task:
# Check seat availability for a given row and seat number.
# Book a seat if available.
# Find the first available seat in any row.
# Return the percentage of seats booked.

# Sample Input:

# seats = {
#   "A" => ["available", "booked", "available"],
#   "B" => ["booked", "booked", "available"],
#   "C" => ["available", "available", "booked"]
# }

