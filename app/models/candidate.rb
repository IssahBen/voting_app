class Candidate < ApplicationRecord
    acts_as_votable
    def full_name 
        first_name + " " + last_name 
    end
end
