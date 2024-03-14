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

    def new 
       @ballot = Ballot.find(params[:ballot_id])
    end

    def create 
       @ballot = Ballot.find(params[:ballot_id])
       @candidate = Candidate.new(first_name: params[:first_name],last_name: params[:last_name])
       if @candidate.save 
            @ballot.ballot_candidates.build(candidate_id: @candidate.id) 
            @ballot.save 
                flash[:notice] = "Candidate has been added to ballot"
                redirect_to @ballot   
        else 
            flash.now[:alert] = "Candidate couldn't be added"
            render "new", status: :unprocessable_entity
        end

    end

    private 
     def set_candidate 
        @candidate = Candidate.find(params[:candidate_id])
     end

end 