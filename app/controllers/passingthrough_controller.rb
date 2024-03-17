# frozen_string_literal: true

class PassingthroughController < ApplicationController
  def index
    path = nil
    if current_user.role == 'Voter'
      ballot_id = check_eligibility(current_user)
      if ballot_id
        path = voting_area_path(ballot_id:)
      else
        flash[:notice] = 'You are not a registered voter'
        current_user.destroy
        sign_out current_user
        path = root_path
      end
    else
      path = ballots_path
    end

    redirect_to path
  end

  def check_eligibility(current_user)
    Voter.all.each do |voter|
      if current_user.email == voter.email && current_user.first_name == voter.first_name && current_user.last_name == voter.last_name
        return voter.ballots.first.id
      end
    end
    nil
  end
end
