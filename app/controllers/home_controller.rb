class HomeController < ApplicationController
  before_filter :authenticate_user!
  def index
  end

  def random
    scrabble_scores = {
      "A" => [9, 1], "B" => [2, 3], "C" => [2, 3], "D" => [4, 2], "E" => [12, 1],
      "F" => [2, 4], "G" => [3, 2], "H" => [2, 4], "I" => [9, 1], "J" => [1, 8],
      "K" => [1, 5], "L" => [4, 1], "M" => [2, 3], "N" => [6, 1], "O" => [8, 1],
      "P" => [2, 3], "Q" => [1, 10], "R" => [6, 1], "S" => [4, 1], "T" => [6, 1],
      "U" => [4, 1], "V" => [2, 4], "W" => [2, 4], "X" => [1, 8], "Y" => [2, 4],
      "Z" => [1, 10]
    }

    random_letters = []
    scrabble_scores.map do |k,v|
      (1..v[0]).each do
        random_letters << k
      end
    end

    random_set = []
    (0..7).map do |i|
      random_key = random_letters[rand(0..random_letters.length)]
      random_set << [random_key, scrabble_scores[random_key][0]]
    end

    render :json => {random_set: random_set}
  end

  def answer
    answer = params['answer']
    is_valid = true
    if $redis.get(answer) === nil
      is_valid = false
    end

    render :json => {is_valid: is_valid}
  end
end
