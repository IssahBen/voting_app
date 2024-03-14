class CandidatesController <  ApplicationController 
    before_action :set_candidate, only: [:upvote]

    def index 
        @candidates = Candidate.all.order(:cached_scoped_subscribe_votes_up=> :desc)

    end 

    def upvote 
        if current_user.already_voted
            flash[:alert] = "You already voted "
            redirect_to poll_path
        else
            @candidate.upvote_from current_user
            redirect_to poll_path 
        end
    end 

    private 
     def set_candidate 
        @candidate = Candidate.find(params[:candidate_id])
     end

end 