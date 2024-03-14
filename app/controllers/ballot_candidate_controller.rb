# frozen_string_literal: true

class BallotCandidateController < ApplicationController
  def destroy
    ballot = Ballot.find(params[:ballot_id])
    candidate = Candidate.find(params[:candidate_id])
    ballot_candidate = BallotCandidate.where(ballot_id: ballot, candidate_id: candidate).first
    ballot_candidate.destroy
    flash[:notice] = 'Candidate Removed'
    redirect_to ballot
  end
end
