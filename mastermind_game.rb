class Player
end

class HumanPlayer < Player
  def initialize(name,role)
    @name = name
    @role = role
  end
  def make_guess()
    print("Please enter a guess for the code: ")
    guess = gets.chomp.strip.to_i
    return guess
  end

  def score_guess()
    print("Please enter the number of black and white hits respectively for the guess: ")
    score = gets.chomp.strip.split(" ").map { |hit_count_str|  hit_count_str.to_i}
    return score
  end
end

class ComputerPlayer < Player

  attr_accessor :answer_array, :score_hash, :answer

  def initialize(role)
    @role = role
    @answer = "#{rand(1..6)}#{rand(1..6)}#{rand(1..6)}#{rand(1..6)}".to_i
    @answer_array = []
    @score_hash = {}
  end
  def score_guess(guess)
    return score(guess, @answer)
  end

  def make_guess(last_guess_score)
    if last_guess_score.nil?
      # write code to fill answer array and score dictionary
      for i in (1..6)
        for j in (1..6)
          for k in (1..6)
            for l in (1..6)
              # @answer_array = []
              @answer_array << "#{i}#{j}#{k}#{l}".to_i
            end
          end
        end
      end

      for guess in @answer_array
        answer_score_hash = {}
        @score_hash[guess] = answer_score_hash
        for answer in @answer_array
          answer_score_hash[answer] = score(guess, answer)
        end
      end
    end
    guesses_to_try = []
    @score_hash.each do |guess, scores_by_answer_dict|
      scores_by_answer_dict = scores_by_answer_dict.select { |answer, score| @answer_array.include?(answer) }
      @score_hash[guess] = scores_by_answer_dict

      possibilities_per_score = scores_by_answer_dict.values.group_by(&:itself).transform_values(&:count)
      worst_case = possibilities_per_score.values.max

      impossible_guess = !@answer_array.include?(guess)

      guesses_to_try << [worst_case, impossible_guess, guess]
    end
    begin
      guess = guesses_to_try.min.last
    rescue StandardError
      guess = guesses_to_try.select { |worst_case,impossible_guess,guess| impossible_guess == false }.min.last
    end
    puts("The computer guess is: #{guess}")
    return guess
  end

  private

  def score(guess,answer)
    answer_digits =  answer.digits.reverse
    guess_digits = guess.digits.reverse
    b = w = 0
    black_hit_digits_index_arr = []
    black_hit_digits = []
    (0...guess_digits.length).each do |i|
      if guess_digits[i] == answer_digits[i]
        b += 1
        black_hit_digits.push(guess_digits[i])
        black_hit_digits_index_arr.unshift(i)
      end
    end

    black_hit_digits_index_arr.each do |index|
      guess_digits.delete_at(index)
      answer_digits.delete_at(index)
    end

    (0...guess_digits.length).each do |i|
      if guess_digits[0...i].include?(guess_digits[i]) == false
        w += [guess_digits.count(guess_digits[i]),answer_digits.count(guess_digits[i])].min
      end
    end
    score = [b,w]
    return score
  end

end


class MasterMindGame
  def initialize(user_name,user_role)
    @user_name = user_name
    @user_role = user_role
    @computer_role = nil
  end

  def start_game()

    if @user_role == "cb"
      @computer_role = "cm"
      human = HumanPlayer.new(@user_name,@user_role)
      computer = ComputerPlayer.new("cm")
      guess_score = nil
      guess_count = 0
      loop do
        guess = human.make_guess()
        # pp guess
        guess_count += 1
        guess_score = computer.score_guess(guess)
        puts("black hits count:#{guess_score[0]}\twhite hits count:#{guess_score[1]}")
        puts
        break if (guess_count > 12 || guess_score == [4,0])
      end
    elsif @user_role == "cm"
      @computer_role = "cb"
      human = HumanPlayer.new(@user_name,@user_role)
      computer = ComputerPlayer.new(@computer_role)
      # print("Please enter the secret code: ")
      # computer.answer = gets.chomp.strip.to_i
      computer.answer = nil
      guess_score = nil
      guess_count = 0
      loop do
        guess = computer.make_guess(guess_score)
        guess_count += 1
        guess_score = human.score_guess()
        computer.answer_array = computer.answer_array.select { |answer| computer.score_hash[guess][answer] == guess_score }
        puts
        break if (guess_count > 12 || guess_score == [4,0])
      end
    end
  end
end

print("Enter your name: ")
name = gets.chomp.strip
print("Enter your role in the game (cm for codemaker and cb for codebreaker): ")
role = gets.chomp.strip
if role == 'cm'
  print("\nPlease choose the secret code and hit enter(do not enter the text in console)")
  gets
end
print("\n\n")

game1 = MasterMindGame.new(name,role)
game1.start_game()

