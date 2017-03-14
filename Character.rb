require './Weapon'
class Character
	attr_reader :name
	attr_reader :strength
	attr_reader :speed
	attr_reader :smarts
	attr_accessor :health
	attr_accessor :weapon

	def initialize()
		raise NoMethodError
	end

	#Changes the characters attributes based on the type of weapon they chose
	def setWeapon(weaponName)
		if weaponName == "Sword"
			@weapon = Weapon.new("Sword")
			@strength = 1
			@speed = 1
			@smarts = 1
		elsif weaponName == "Crossbow"
			@weapon = Weapon.new("Crossbow")
			@strength = 5
			if @health > 1
				@health = @health - 1
			end
		elsif weaponName == "Shield"
			@weapon = Weapon.new("Shield")
			if(@strength < 5)
				@strength = @strength + 1
			end
			if (@speed < 5)
				@speed = @speed + 1
			end
			@smarts = @smarts + 1
			@health += 1
		elsif weaponName == "Shotgun"
			@weapon = Weapon.new("Shotgun")
			@speed = 1
			@health += 4
		else
			puts "Invalid weapon choice!"
		end
	end

	def displayQualities()
		puts "Name: #{@name}"
		puts "strength: #{@strength}"
		puts "Speed: #{ @speed}"
		puts "Intelligence: #{@smarts}"
		puts "Health: #{@health}"
	end

#When the character is attacking use their strength and the weapons power to
#as the attack value. However if their weapon is a shield they do not get
#as much of an attack
	def attack()
		weaponPower = @weapon.offensiveWeapon()
		if(@weapon.name == "Shield")
			return (weaponPower*@strength)/2
		else
			return weaponPower*@strength
		end
	end

#When the character is defending they can only use their strength to defend them
#selves however if their weapon is a shield then they get a weapon power
#and use that value to increase their defense
	def defend()
		if(@weapon.name == "Shield")
			weaponPower = @weapon.defensiveWeapon()
			return (weaponPower*@strength)
		else
			return @strength
		end
	end
end
