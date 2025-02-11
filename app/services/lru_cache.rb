class LruCache
	attr_accessor :capacity, :cache

	def initialize(capacity)
		@capacity = capacity
		@cache = {}
	end

	def get(key)
		return -1 if cache[key].nil?

		value = cache.delete(key)

		cache[key] = value
		value
	end

	def put(key, value)		
		cache.delete(key) if cache[key]

		cache.shift if cache.size == capacity

		cache[key] = value
	end

	def show
		cache
	end
end


# Implement an LRU Cache with two methods:
# get(key): Retrieve a value if it exists and mark it as recently used.
# put(key, value): Insert a key-value pair and evict the least recently used (LRU) entry if the cache is full.
# The cache should have a fixed capacity and maintain the order of usage.