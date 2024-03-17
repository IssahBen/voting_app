# frozen_string_literal: true

class BallotsController < ApplicationController
  before_action :user_not_admin
  def index
    session[:ballot_id] = nil
    @ballots  = current_user.ballots
  end

  def show
    @ballot = Ballot.find(params[:id])
    session[:ballot_id] = @ballot.id
    @candidates = @ballot.candidates
    @winner = with_most_votes(@candidates)
  end

  def new
    @ballot = Ballot.new
  end

  def edit
    @ballot = Ballot.find(params[:id])
  end

  def create
    @ballot = Ballot.new(ballot_params)
    if @ballot.save
      flash[:notice] = 'Ballot Successfully Added'
      redirect_to @ballot
    else
      flash[:alert] = "Ballot wasn't saved check credentials"
    end
  end

  def update
    @ballot = Ballot.find(params[:id])
    if @ballot.update(params.require(:ballot).permit(:name, :description))
      flash[:notice] = 'Ballot updated successfully'
      redirect_to @ballot
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @ballot = Ballot.find(params[:id])
    @ballot.destroy
    flash[:notice] = 'Ballot has been deleted'
    redirect_to ballots_pathball
  end

  private

  def ballot_params
    params.require(:ballot).permit(:name, :description, :user_id)
  end
  def with_most_votes(candidates)
    if candidates.empty?
      return nil 
    end
    winning_number_of_votes = 0
    candidates.each do |candidate| 
        if candidate.get_upvotes.size > winning_number_of_votes 
            winning_number_of_votes = candidate.get_upvotes.size 
        end 
    end 
    candidates.find{|candidate| candidate.get_upvotes.size == winning_number_of_votes}
end
end
