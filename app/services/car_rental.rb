class CarRegistry
	attr_accessor :car_registry

	def initialize
		@car_registry = {}
	end

	def register(car_name, type)
		if car_registry[type]
			car_registry[type] << car_name
		else
			car_registry[type] = [car_name]
		end
	end

	def sort_by(attribute)
		if attribute == 'car_name'
			car_registry.sort_by { |key, val| val }
		elsif attribute == 'type'
			car_registry.sort_by { |key, val| key }
		else
			raise 'Invalid Argument'
		end
	end
end

def main
	obj = CarRegistry.new
	obj.register('Toyota Aqua', 'Basic')
	obj.register('Toyota CRM', 'SUV')
	obj.register('BMW 2 series', 'SUV')
	obj.register('BMW 5 series', 'Sedane')
	obj.register('Toyota Corlla', 'Sedane')
	puts obj.car_registry
	obj.sort_by('type')
end

main