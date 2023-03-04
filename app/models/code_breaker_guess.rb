class CodeBreakerGuess < ApplicationRecord
  belongs_to :code_breaker
  has_many :code_breaker_guess_colors, dependent: :destroy
  has_many :code_breaker_guess_keys, dependent: :destroy
end
