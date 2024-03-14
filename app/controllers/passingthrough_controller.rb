 class PassingthroughController < ApplicationController

    def index 
        path = case current_user.role 
        when "Voter"
            voter_home_path 
        when "Election Official"
            admin_home_path
        end 

        redirect_to path
    end 
 end 