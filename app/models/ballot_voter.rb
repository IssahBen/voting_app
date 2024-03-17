class BallotVoter < ApplicationRecord
    belongs_to :voter 
    belongs_to :ballot 
end
