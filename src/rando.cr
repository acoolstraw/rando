require "random"
require "option_parser"

VERSION = "0.1.0"
dice = false
dice_amount = 2
dice_sides = 6
flip = false
flip_amount = 1
flip_delay = 0

parser = OptionParser.new do |parser|
  parser.banner = "Usage: rand [subcommand] [arguments]"

  parser.on("gen", "Generate a random number") do
    parser.banner = "Usage: rand gen [from] [to]"
    parser.on("-f FROM", "--from=FROM", "Lowest number to select") do |from|
      parser.on("-t TO", "--to=TO", "Highest number to select") do |to|
        puts rand(from.to_i..to.to_i)
      end
    end
  end

  parser.on("flip", "Flip a coin") do
    flip = true
    parser.banner = "Usage: rand flip [arguments]" 
    parser.on("-a AMOUNT", "--amount=AMOUNT", "Specify how many coins to flip") do |amount|
      flip_amount = amount.to_i
    end

    parser.on("-d DELAY", "--delay=DELAY", "Specify delay (in seconds) between results") do |delay|
      flip_delay = delay.to_i
    end
  end

  parser.on("roll", "Roll dice") do
    parser.banner = "Usage: rand roll [arguments]"

    parser.on("-a AMOUNT", "--amount=AMOUNT", "Specify amount of dice to roll") do |dice|
      dice_amount = dice.to_i
    end

    parser.on("-s SIDES", "--sides=SIDES", "Specify how many sides the dice should have") do |sides|
      dice_sides = sides.to_i
    end

    parser.on("-d DELAY", "--delay=DELAY", "Specify delay (in seconds) between results") do |delay|
      flip_delay = delay.to_i
    end
  end

  parser.on("-v", "--version", "Show version of rand") do
    puts "rando v#{VERSION}"
  end

  parser.on("-h", "--help", "Show this help") do
    puts parser
    exit
  end
end

parser.parse

if flip == true
  if flip_amount == 1 
    flip_state = rand(1..101)
    if flip_state <= 50
      puts "HEADS"
    else
      puts "TAILS"
    end
  else
    loop do
      flip_state = rand(1..101)
      if flip_state <= 50
        puts "HEADS"
      else
        puts "TAILS"
      end

      flip_amount = flip_amount - 1

      unless flip_amount == 0
        sleep(flip_delay)
      else
        break
      end
    end
  end
end
