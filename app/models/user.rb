# frozen_string_literal: true

class User < ApplicationRecord
  acts_as_voter
  has_many :ballots
  has_many :candidates
  has_many :voters
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def already_voted
    candidates = Candidate.all
    candidates.each do |candidate|
      return true if voted_for? candidate
    end
    false
  end

  def voter?
    role == 'Voter'
  end

  def admin?
    role == 'Election Official'
  end

  def candidate_in_db?(first_name, last_name)
    candidates.each do |candidate|
      return true if candidate.first_name == first_name && candidate.last_name == last_name
    end
    false
  end
end
