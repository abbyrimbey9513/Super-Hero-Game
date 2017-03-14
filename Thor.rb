require './Character.rb'
class Thor < Character
	def initialize()
		@name = "Thor"
		@strength = 4
		@speed = 2
		@smarts = 3
		@health = 29
	end
end
