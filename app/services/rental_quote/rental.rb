class Car
	def base_price
		 raise NotImplementedError, "Subclasses must define `base_price`"
	end
end

class Economy < Car
  def base_price
  	30
  end
end

class Suv < Car
  def base_price
  	40
  end
end

class Luxury < Car
  def base_price
  	50
  end
end


class Rental
	attr_accessor :car, :days, :season_price, :add_ons

	SEASON_ADJUSTMENTS = {
		regular: 1.0,
		peak: 1.2,
		off_peak: 0.8
	}

	ADD_ONS = {
		gps: 1.1,
		child_seat: 1.2,
		fast_tag: 1.3
	}

	def initialize(car_type:, days:, season: :regular, add_ons: [])
		@car = identify_car(car_type)
		@days = days
		@season_price = SEASON_ADJUSTMENTS[season]
		@add_ons = add_ons
	end

	def calculate
		car.base_price * days * season_price * calculate_add_on_price
	end

	private

	def identify_car(car_type)
		case car_type
		when :suv then Suv.new
		when :economy then Economy.new
		when :luxury then Luxury.new
		else raise NotImplementedError, "car category does not exist"
		end
	end

	def calculate_add_on_price
		return 1 if add_ons.empty?

		price = 1
		add_ons.each do |add_on|
			add_on_price = ADD_ONS[add_on]
			price = price * add_on_price if add_on_price
		end

		price
	end

end


def main
	rental = Rental.new(car_type: :suv, days: 3)
	pp rental.calculate

	rental = Rental.new(car_type: :luxury, days: 5, add_ons: [:child_seat, :gps], season: :peak)
	pp rental.calculate
end

main
