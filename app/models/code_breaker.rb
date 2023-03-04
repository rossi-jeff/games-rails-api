class CodeBreaker < ApplicationRecord
  enum Status:, { Lost: 0, Playing: 1, Won: 2 }
  
  belongs_to :user
  has_many :code_breaker_codes, dependent: :destroy
  has_many :code_breaker_guesses, dependent: :destroy
end