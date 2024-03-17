class VotingareaController < ApplicationController
  def show
    ballot = Ballot.find(params[:ballot_id])
    session[:ballot_id] = ballot.id
    @candidates = ballot.candidates
    @winner = with_most_votes(@candidates)
  end

  private

  def with_most_votes(candidates)
    winning_number_of_votes = 0
    candidates.each do |candidate|
      winning_number_of_votes = candidate.get_upvotes.size if candidate.get_upvotes.size > winning_number_of_votes
    end
    candidates.find { |candidate| candidate.get_upvotes.size == winning_number_of_votes }
  end
end
