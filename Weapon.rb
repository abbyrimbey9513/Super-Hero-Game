class Weapon

  attr_accessor :name

  def initialize(weaponName)
    @name = weaponName
  end

  def offensiveWeapon()
    power = Random.new()
    power = rand(10)
    return power
  end

  def defensiveWeapon()
    power = Random.new()
    power = rand(50)
    return power
  end
end
