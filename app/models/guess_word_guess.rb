class GuessWordGuess < ApplicationRecord
  belongs_to :guess_word
	has_many :guess_word_guess_ratings
end
