class Yacht < ApplicationRecord
  belongs_to :user
	has_many :yacht_turns
end
