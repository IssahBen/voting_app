# frozen_string_literal: true

class CandidatesController < ApplicationController
  before_action :set_candidate, only: [:upvote]

  def index
    @candidates = current_user.candidates
    #  Candidate.all.order(:cached_scoped_subscribe_votes_up=> :desc)
  end

  def upvote
    if current_user.already_voted
      flash[:alert] = 'You already voted '
    else
      @candidate.upvote_from current_user
    end
    redirect_to poll_path
  end

  def new
    @ballot = Ballot.find(params[:ballot_id])
    @user_candidates = current_user.candidates
  end

  def edit
    @ballot = Ballot.find(params[:ballot_id])
    @candidate = Candidate.find(params[:candidate_id])
  end

  def create
    byebug
    @ballot = Ballot.find(params[:ballot_id])
    if params[:user_id]
      @candidate = Candidate.new(first_name: params[:first_name], last_name: params[:last_name],
                                 user_id: params[:user_id])
      if @candidate.save
        @ballot.ballot_candidates.build(candidate_id: @candidate.id)
        @ballot.save
        flash[:notice] = 'Candidate has been added to ballot'
        redirect_to @ballot
      else
        flash.now[:alert] = "Candidate couldn't be added"
        render 'new', status: :unprocessable_entity
      end
    else
      @candidate = Candidate.find(params[:candidate_id])
      @ballot = Ballot.find(params[:ballot_id])
      ballot_candidate = BallotCandidate.new(ballot_id: @ballot.id, candidate_id: @candidate.id)
      if ballot_candidate.save
        flash[:notice] = 'Candidate has been added to ballot'
      else
        flash[:alert] = "Candidate couldn't be added"
      end
      redirect_to @ballot
    end
  end

  def update
    ballot = Ballot.find(params[:ballot_id])
    @candidate = Candidate.find(params.require(:candidate).permit(:candidate_id)[:candidate_id])
    if @candidate.update(params.require(:candidate).permit(:first_name, :last_name))
      flash[:notice] = 'Candidate updated successfully'
      redirect_to ballot
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_candidate
    @candidate = Candidate.find(params[:candidate_id])
  end
end
