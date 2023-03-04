class TenGrandScore < ApplicationRecord
	enum Category:, {
		CrapOut: 0
		Ones: 1,
		Fives: 2,
		ThreePairs: 3,
		Straight: 4,
		FullHouse: 5,
		DoubleThreeKind: 6,
		ThreeKind: 7,
		FourKind: 8,
		FiveKind: 9,
		SixKind: 10,
	}

  belongs_to :ten_grand_turn
end
