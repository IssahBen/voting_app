class Ballot < ApplicationRecord
    has_many :ballot_candidates
    has_many :candidates,through: :ballot_candidates
end
