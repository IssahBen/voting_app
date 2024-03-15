# frozen_string_literal: true

class Candidate < ApplicationRecord
  before_save do 
     self.first_name = first_name.capitalize
     self.last_name = last_name.capitalize 
  end
  acts_as_votable
  belongs_to :user
  has_many :ballot_candidates
  has_many :ballots, through: :ballot_candidates
  def full_name
    "#{first_name} #{last_name}"
  end
end
