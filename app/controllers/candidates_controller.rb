class CandidatesController <  ApplicationController 

    def index 
        @candidates = Candidate.all.order(:cached_votes_down => :desc)

    end 

    def upvote 
        @candidate.upvote_from current_user
        redirect_to poll_path 
    end 

end 