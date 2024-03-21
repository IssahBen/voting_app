class Voter < ApplicationRecord
  belongs_to :user
  has_many :ballot_voters,dependent: :destroy
  has_many :ballots, through: :ballot_voters
  before_save { self.email = email.downcase }

  before_save do
    self.first_name = first_name.capitalize
    self.last_name = last_name.capitalize
  end

  validates :first_name, presence: true, length: { minimum: 3, maximum: 25 }
  validates :last_name, presence: true, length: { minimum: 3, maximum: 25 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 105 },
                    format: { with: VALID_EMAIL_REGEX }
end
