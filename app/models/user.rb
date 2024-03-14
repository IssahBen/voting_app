class User < ApplicationRecord
  acts_as_voter
  has_many :ballots
  has_many :candidates
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def already_voted 
    candidates = Candidate.all 
    candidates.each do |candidate|
      if self.voted_for? candidate 
        return true  
      end 
    end 
    false
  end

  def voter?
    self.role == "Voter"
  end 
  
  def admin?
    self.role == "Election Official"
  end
end
