# frozen_string_literal: true

class Candidate < ApplicationRecord
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100],preprocessed: true
  end
  validates :first_name,presence: true
  validates :last_name,presence: true
  validates :image, allow_blank: true, format: {
  with: %r{\.gif|jpg|png|jpeg|}i,
  message: 'must be a url for gif, jpg, jpeg or png image.'
}


  # before_save do 
  #    self.first_name = first_name.capitalize
  #    self.last_name = last_name.capitalize 
  # end
  acts_as_votable
  belongs_to :user
  has_many :ballot_candidates
  has_many :ballots, through: :ballot_candidates
  def full_name
    "#{first_name} #{last_name}"
  end
  def on_ballot?
    !self.ballots.empty?
  end
end
