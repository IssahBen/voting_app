class UploadsController < ApplicationController

    require "csv"
    def show 
       
    end

    
  def create

   message = createvoters(clean_csv(params[:csv_file]))

    if flash.nil?
        flash[:alert] = "Voters Couldn't Be Added"
        redirect_to controller: :voters,action: :index

    else 
        flash[:alert] = "Voters Added"
        redirect_to controller: :voters,action: :index
    end



end

  private
    def clean_csv(file)
        csv=CSV.read(file)
        cleared_csv = csv.map{|row| row.compact }.reject{|row| row.empty?}
        array =[]
        cleared_csv.each_with_index do |row,i|
            if i == 0
                next 
            end 
            array << row 
        end
        return array 
    end

    def createvoters(array)
        begin
            array.each do |voter|
                first_name = voter[0]
                last_name = voter[1]
                email = voter[2]
                 obj = Voter.create(first_name: first_name,last_name: last_name,email: email,user_id: current_user.id)
                 p obj.errors.full_messages
                 ballot_vote = BallotVoter.create(voter_id: obj.id,ballot_id: current_ballot.id)

                 
            end 
            "Voters added"
        rescue Exception 
            return nil 
        end
    end 


   
end