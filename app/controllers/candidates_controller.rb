# frozen_string_literal: true

class CandidatesController < ApplicationController
  before_action :set_candidate, only: [:upvote]
  before_action :user_not_admin

  def index
    session[:ballot_id] = nil
    @candidates = current_user.candidates
    #  Candidate.all.order(:cached_scoped_subscribe_votes_up=> :desc)
  end

  def upvote
    if current_user.already_voted
      flash[:alert] = 'You already voted '
    else
      @candidate.upvote_from current_user
    end
    redirect_to voting_area_path(ballot_id: current_ballot.id)
  end

  def new
    @candidate = Candidate.new
    @ballot = Ballot.find(params[:ballot_id])
  end

  def edit
    @ballot = Ballot.find(params[:ballot_id])
    @candidate = Candidate.find(params[:candidate_id])
  end

  def create 
    byebug
    @ballot = Ballot.find(params[:ballot_id])
    if params[:user_id]
      if current_user.candidate_in_db?(params[:first_name], params[:last_name])
        flash[:alert] = 'Candidate already Added'
        redirect_to @ballot
      else
        @candidate = Candidate.new(first_name: params[:first_name], last_name: params[:last_name],
                                   user_id: params[:user_id])
        @candidate.image.attach(params[:image])

        if @candidate.save
          @ballot.ballot_candidates.build(candidate_id: @candidate.id)
          @ballot.save
          flash[:notice] = 'Candidate has been added to ballot'
          redirect_to @ballot
        else
          render :new, status: :unprocessable_entity
        end
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
    if params.require(:candidate).permit(:image).present?
      @candidate = Candidate.find(params.require(:candidate).permit(:candidate_id)[:candidate_id])
      @candidate.image.purge
      @candidate.image.attach(params.require(:candidate).permit(:image)[:image])
      if @candidate.update(params.require(:candidate).permit(:first_name, :last_name))
        flash[:notice] = 'Candidate updated successfully'
        redirect_to ballot
      else
        puts @candidate.errors.full_messages
        flash.now[:alert] = 'Didnt save'
        render :edit, status: :unprocessable_entity
      end
    else
      @candidate = Candidate.find(params.require(:candidate).permit(:candidate_id)[:candidate_id])
      if @candidate.update(params.require(:candidate).permit(:first_name, :last_name))
        flash[:notice] = 'Candidate updated successfully'
        redirect_to ballot
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @candidate = Candidate.find(params[:id])
    if @candidate.on_ballot?
      flash.now[:alert] = 'Candidates on a ballot cannot be permanently deleted'
      render 'index', status: :unprocessable_entity
    else
      @candidate.destroy
      flash.now[:notice] = 'Candidate Permanently Deleted'
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def set_candidate
    @candidate = Candidate.find(params[:candidate_id])
  end
end
