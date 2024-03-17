class VotersController < ApplicationController
  before_action :user_not_admin
  def index
    @voters = current_ballot.voters
  end

  def new
    @voter = Voter.new
  end

  def edit
    @voter = Voter.find(params[:id])
  end

  def create
    @voter = Voter.new(voter_params)
    if @voter.save
      ballot_voter = BallotVoter.create(ballot_id: current_ballot.id, voter_id: @voter.id)
      flash[:notice] = 'Voter Added'
      redirect_to voters_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def update; end

  def destroy
    @voter = Voter.find(params[:id])
    ballot_vote = BallotVoter.where(ballot_id: current_ballot.id, voter_id: @voter.id).first
    ballot_vote.destroy
    @voter.destroy
    flash[:notice] = 'Voter has been deleted'
  end

  private

  def voter_params
    params.require(:voter).permit(:first_name, :last_name, :email, :user_id)
  end
end
