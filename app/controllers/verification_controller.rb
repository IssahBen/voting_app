class VerificationController < ApplicationController 
    skip_before_action :authenticate_user!
    def verify 
        response = get_http_response(params)["message"]
        
        message = case response 
                when "true"    
                    "You are Registered"
                when "false"
                    "Contact your Election Official"
                end 
       
        flash[:notice] = message
        redirect_to root_path 

    end 









    private
    def get_http_response(params)
        first_name = params.require(:verification).permit(:first_name)[:first_name]
        last_name = params.require(:verification).permit(:last_name)[:last_name]
        email = params.require(:verification).permit(:email)[:email]
        response = Faraday.new("http://localhost:3000/api/v1/voters?first_name=#{first_name}&email=#{email}&last_name=#{last_name}")
        parsed_data = JSON.parse(response.get.body)
    end
end