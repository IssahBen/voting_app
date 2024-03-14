class Candidate < ApplicationRecord
    acts_as_votable
    has_many :ballot_candidates 
    has_many :ballots,through: :ballot_candidates
    def full_name 
        first_name + " " + last_name 
    end
end
