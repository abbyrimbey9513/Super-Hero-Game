require './Thor'
require './Character'
require './CatWoman'
require './BatMan'
require './WonderWoman'
require './Monster.rb'
require './Tests.rb'

def main()
  ##Start game
  puts "Welcome to the adventure game!! "
  puts "First you will choose a character then a weapon"
  puts "Finally you will have to beat all three tests to win the game"
  puts "You better choose wisely, any invalid input terminates the game"
  puts "When you are ready to begin hit 'y'"
  userReady = gets()
  #initialize one of every character so they can be displayed on the screen
  myCW = CatWoman.new
  myWW = WonderWoman.new
  myBM = BatMan.new
  myT = Thor.new
  #Create a monster for the battle test
  myMonster = Monster.new

  #Create an array of characters to display and have user choose 1
  myCharacters = [myCW, myWW, myBM, myT]
  if ( userReady.chomp.capitalize == 'Y')
    puts "Character List:"
    idx = 1
    myCharacters.each do |i|
      puts idx
      i.displayQualities
      idx += 1
    end

    puts "Choose a character name from the list above ( 1, 2, 3, or 4)."
    playerChar = gets()
    #Display the weapons and how it affects their qualites
    puts "Weapon List and how each weapon changes the characters qualities:"
    puts "Sword: Changes strength, speed, and Intelligence to 1."
    puts "Crossbow: Changes strength to 5 and decreases health by 1."
    puts "Shield: Increases all qualities by 1, and its great for defense!"
    puts "Shotgun: Lowers speed to 1 and sets health to 4."
    puts "Choose a weapon from above."
    playerWeapon = gets()

    weapons = ["Sword", "Crossbow", "Shield", "Shotgun"]

    if not(weapons.include? playerWeapon.chomp.capitalize)
      puts "invalid weapon choice"
    elsif (playerChar.chomp == '1')#Determine what kind of character the player chose and set their weapon
      myCW.setWeapon(playerWeapon.chomp.capitalize)
      puts "Good choice of weapon! Here are your new qualities:"
      myCW.displayQualities
      puts "Weapon: #{myCW.weapon.name}"
      beginTests = Tests.new(myCW, myMonster)
      beginTests.startGame()
    elsif (playerChar.chomp == '2')
      myWW.setWeapon(playerWeapon.chomp.capitalize)
      puts "Good choice of weapon! Here are your new qualities:"
      myWW.displayQualities
      puts "Weapon: #{myWW.weapon.name}"
      beginTests = Tests.new(myWW, myMonster)
      beginTests.startGame()
    elsif (playerChar.chomp =='3')
      myBM.setWeapon(playerWeapon.chomp.capitalize)
      puts "Good choice of weapon! Here are your new qualities:"
      myBM.displayQualities
      puts "Weapon: #{myBM.weapon.name}"
      beginTests = Tests.new(myBM, myMonster)
      beginTests.startGame()
    elsif (playerChar.chomp == '4')
      myT.setWeapon(playerWeapon.chomp.capitalize)
      puts "Good choice of weapon! Here are your new qualities:"
      myT.displayQualities
      puts "Weapon: #{myT.weapon.name}"
      beginTests = Tests.new(myT, myMonster)
      beginTests.startGame()
    else
      puts "Invalid name or weapon"
      puts "Game Over."
    end
else #if user  not ready
  puts "Game Over."
end


end

main()
