class TenGrand < ApplicationRecord
	enum Status:, { Lost: 0, Playing: 1, Won: 2 }

  belongs_to :user
	has_many :ten_grand_turns
end
