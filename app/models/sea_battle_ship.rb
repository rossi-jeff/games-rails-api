class SeaBattleShip < ApplicationRecord
	enum Type:, {
		BattleShip: 0,
		Carrier: 1,
		Cruiser: 2,
		PatrolBoat: 3,
		SubMarine: 4
	}
	enum Navy:, { Player: 0, Opponent: 1 }

  belongs_to :sea_battle
	has_many :sea_battle_ship_grid_points
	has_many :sea_battle_ship_hits
end
