class BallotsController < ApplicationController 
    def index 
        @ballots = Ballot.all
    end 

    def create 
        @ballot = Ballot.new(ballot_params)
        if @ballot.save 
            flash[:notice] = "Ballot Successfully Added"
            redirect_to @ballot 
        else 
            flash[:alert] = "Ballot wasn't saved check credentials"
        end


    end

    def new 
        @ballot = Ballot.new
    end 

    def edit 
        @ballot = Ballot.find(params[:id])
    end 

    def show 
        @ballot = Ballot.find(params[:id])
        @candidates = @ballot.candidates
    end

    def update 
        
        @ballot = Ballot.find(params[:id])
        if @ballot.update(params.require(:ballot).permit(:name,:description))
            flash[:notice]="Ballot updated successfully"
            redirect_to @ballot  
        else
            render :edit ,status: :unprocessable_entity
        end
    end

    def destroy 
    
    end 
    private 
    def ballot_params 
        params.require(:ballot).permit(:name,:description)
    end
    

end