# frozen_string_literal: true

class BallotCandidate < ApplicationRecord
  belongs_to :candidate
  belongs_to :ballot
end
