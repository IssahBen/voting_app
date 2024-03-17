# frozen_string_literal: true

class Ballot < ApplicationRecord
  belongs_to :user
  has_many :ballot_candidates, dependent: :destroy
  has_many :candidates, through: :ballot_candidates
  has_many :ballot_voters,dependent: :destroy 
  has_many :voters, through: :ballot_voters
end
