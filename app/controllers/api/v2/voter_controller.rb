class Api::V2::VoterController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user!
   
    
    def index
        
        flag = !!check_db?(params[:first_name],params[:last_name],params[:email])
        render json: {message: "#{flag}"}
    end 


    private 

    def check_db?(first_name,last_name,email)
        begin 
            Voter.where(first_name:first_name,last_name:last_name,email: email).first 
        rescue 
            nil 
        end 
    
    end
end
