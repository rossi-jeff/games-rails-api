class GuessWord < ApplicationRecord
	enum Status:, { Lost: 0, Playing: 1, Won: 2 }
	
  belongs_to :user
	has_many :guess_word_guesses
end
