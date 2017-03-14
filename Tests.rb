require './Character'

class Tests
  def initialize(character, monster)
    @charPlaying = character
    @points = 0
    @answer
    @monster = monster
  end

  #Calls the three tests the character has to pass to win the game
  #needs to ask char what test to do
  def startGame()
    puts " "
    puts "Starting the tests! Get 3 points to win the game!"
    puts "Pick wisely or you may forfeit a round!"
    round = 1
    testFinished = false
    tests = {"Battle" => true, "Intelligence" => true, "Speed" => true}
    while round <= 3
      puts "Choose a test from the list:"
      tests.each {|key, value|
        if value
          puts key
        end
      }
      puts " "
      choice = gets()

      for i in tests.keys
        if (i == choice.chomp.capitalize)
          tests[i] = false
        end
      end
      if (choice.chomp.capitalize == "Battle")
        battleTest()
      elsif (choice.chomp.capitalize == "Intelligence")
        intelligenceTest()
      elsif (choice.chomp.capitalize == "Speed")
        speedTest()
      else
        puts "Invalid test choice"
      end

        puts ""
        puts "Your points after round #{round} = #{@points}"
        puts ""

      round += 1
    end #while

    if (@points  == 3)
      puts "YOU WON!"
    else puts "You lose!"
    end
  end #End startGame()

#In the first thread, the character attacks and the monster defends
#if the Character attacks with a value larger than the monsters defense then
#the Character wins the round and the monster gets the characters attack value
#taken away from its health.
#Else the monsters defense value is taken away from the characters health.
#For the second thread, the monster attacks the character defends
#if the characters defense is greater than the monsters attack then the character wins the
#round. etc...
  def battleTest()
    threads = []
    threads << Thread.new {
      while( @charPlaying.health > 0 && @monster.health > 0)
        charAttack = @charPlaying.attack()
        monsterDefend = @monster.defend()
      #  puts "1 charAttack #{charAttack}"
      #  puts " 1 monsDefend #{monsterDefend}"
        if (charAttack <= monsterDefend)
          @charPlaying.health = @charPlaying.health - monsterDefend
        else
          @monster.health = @monster.health - charAttack
        end
      #  puts "1 Char Health #{@charPlaying.health}"
      #  puts "1 Monster Health #{@monster.health}"
      end
    }
    threads << Thread.new {
      while( @charPlaying.health > 0 && @monster.health > 0)
        charDefend = @charPlaying.defend()
        monsAttack = @monster.attack()
      #  puts "2 chardefend #{charDefend}"
      #  puts "2 monsterAttack #{monsAttack}"
        if (charDefend <= monsAttack)
          @charPlaying.health = @charPlaying.health - monsAttack
        else
          @monster.health = @monster.health - charDefend
        end
      #  puts "2 Char Health #{@charPlaying.health}"
      #  puts "2 Monster Health #{@monster.health}"
      end
    }
    threads.each {|thread| thread.join}

    if @charPlaying.health > @monster.health
       @points += 1
       puts "You beat the Monster, #{@charPlaying.name}: #{@charPlaying.health} to Monster: #{@monster.health}"
     else
       puts "You lost to the Monster, #{@charPlaying.name}: #{@charPlaying.health} to Monster: #{@monster.health}"
    end
  end

  #Depending on what intelligence level the character has determines the kind
  #of question they are asked. It's somewhat conterintutive because the
  #smarter the person is the easier the question is.
  def intelligenceTest()
    puts "Your intelligence is about to tested, let's see how you can do!"
    if(@charPlaying.smarts == 5)
      puts"Evaluate the expression: "
      puts "1^2 + 1^2 = "
      @answer = gets()
      if (@answer.chomp == '2')
        @points += 1
        puts "Good job smarty pants!"
      else
        puts "Really you don't know what 1 + 1 is!"
      end
    elsif @charPlaying.smarts == 4
      puts"Evaluate the expression: "
      puts "pi/0 = "
      @answer = gets()
      if(@answer.chomp == '0')
        @points += 1
        puts "Wow! You are smart!"
      else
        puts "You probably are not smarter than a 5th grader."
      end
    elsif @charPlaying.smarts == 3
      puts "What is the square root of 4 * 16 = "
      @answer = gets()
      if(@answer.chomp == '8')
        @points +=  1
        puts "Thats correct! One point for you!"
      else
        puts "Better luck next time!"
      end
    elsif @charPlaying.smarts == 2
      puts "How many minutes are in one year?"
      @answer = gets()
      if(@answer.chomp == '525600')
        @points += 1
        puts "That is a lot of minutes! 1 point for you #{@charPlaying.name}"
      else
        puts "I guess there's too many for you to count."
      end
    else
      puts "What is the 50th digit of pi?"
      @answer = gets()
      if(@answer.chomp == '1')
        @points += 1
        puts "Thats correct and a point for you!"
      else
        puts "Well you only had a 1/10 chance to guess the right answer!"
      end
    end
  end

  #Based off the characters speed quality a phrase is requested to be typed.
  #The character is timed and if their time is less than the time alloted
  #for the test then they do not get any points.
  def speedTest()
    puts "You now have to pass the speed test!"
    if @charPlaying.speed == 2
      phrase = 'abcdefghijklmnopqrstuvwxyz'
      puts "Type the alphabet!"
      startTime = Time.now
      ans = gets()
      stopTime = Time.now
      if (ans.chomp == phrase)
        @answer = stopTime.sec - startTime.sec
        if (@answer < 20 && @answer > 0)
          @points += 1
          puts "1 point for you ya speed demon!"
        else
          puts "You were too slow!"
        end
      else
        puts "You couldn't type the alphabet! You don't deserve points!"
      end
    elsif @charPlaying.speed == 3
      phrase = 'zyxwvutsrqponmlkjihgfedcba'
      puts "Type the alphabet backwards!"
      startTime = Time.now
      ans = gets()
      stopTime = Time.now
      if (ans.chomp == phrase)
        @answer = stopTime.sec - startTime.sec
        #puts @answer
        if (@answer < 20 && @answer > 0)
          @points += 1
          puts "YOU DID IT! 1 point!"
        else
          puts "You were too slow!"
        end
      else
        puts "Do you not know the alphabet!?! No points for you!"
      end;2
    elsif @charPlaying.speed == 5
      phrase = 'Hello World!'
      puts "Type #{phrase}!"
      startTime = Time.now
      ans = gets()
      stopTime = Time.now
      if ans.chomp == phrase
        @answer = stopTime.sec - startTime.sec
        #puts @answer
        if (@answer < 15 && @answer > 0)
          @points += 1
          puts "No surprise here, you earned 1 point!"
        else
          puts "You have the highest speed! How did you take so long?! NO POINTS!"
        end
      else
        puts "This is the easiest test and you couldnt type correctly! No points for you!"
      end
    elsif @charPlaying.speed == 4
      phrase = 'Hello World!'
      puts "Type #{phrase} backwards!"
      startTime = Time.now
      ans = gets()
      stopTime = Time.now
      if ans.chomp == phrase.reverse
        @answer = stopTime.sec - startTime.sec
        #puts @answer
        if (@answer < 15 && @answer > 0)
          @points += 1
          puts "Good job!"
        else
          puts "You were too slow yet you have a high speed. Whats up with that? NO POINTS!"
        end
      else
        puts "I guess typing backwards is just not your thing! No points for you!"
      end
    elsif @charPlaying.speed == 1
      phrase = " . % !"
      puts " Directions: For this test you will need to hit a sequence button as fast as you can."
      puts " If you do not hit the right sequence of buttons NO POINTS! If you hit the right button but are,"
      puts "too slow, which I predict to be true, then you get NO POINTS! Good luck, you have 1 second!"
      puts "Hit <space>.<space><shift>5<space><shift>1"
      startTime = Time.now
      ans = gets()
      stopTime = Time.now
      if ans.chomp == phrase
        @answer = stopTime.sec - startTime.sec
        #puts @answer
        if (@answer < 10  && @answer > 0)
          @points += 1
          puts "SHOCKER! You actually earned points for this round!"
        else
          puts "You were too slow!"
        end
      else
        puts "You did not match the statement! No points for you!"
      end
    end
  end #End test
end #End class
