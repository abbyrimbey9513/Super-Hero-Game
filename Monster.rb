require './Character.rb'
require './Weapon.rb'
class Monster < Character
  def initialize()
    @name = "Monster"
    @strength = 5
    @speed = 5
    @smarts = 1
    @health = 30
    @weapon = Weapon.new("Sword")
  end

end
