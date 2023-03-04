class SeaBattle < ApplicationRecord
	enum Status:, { Lost: 0, Playing: 1, Won: 2 }

  belongs_to :user
	has_many :sea_battle_ships
	has_many :sea_battle_turns
end
