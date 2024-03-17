class VotingareaController < ApplicationController
    def show 
        
        ballot = Ballot.find(params[:ballot_id])
        session[:ballot_id] = ballot.id
        @candidates = ballot.candidates 
    end 
end
