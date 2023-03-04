class TenGrandTurn < ApplicationRecord
  belongs_to :ten_grand

	has_many :ten_grand_scores
end
