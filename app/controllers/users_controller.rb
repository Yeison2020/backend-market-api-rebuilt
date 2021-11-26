class UsersController < ApplicationController

    def create
        user  = User.create(user_params)
        if user.valid? 
            render json: user, status: :created 
        else  
         render json: {error: user.errors.full_messages},status: :unprocessable_entity   
            
        end
    end
    # Notes here this action need work to delete current user
    def destroy  
        user = User.find_by(id: params[:id])
        if user.valid? 
            user.destroy 
            render json: {user: 'Your user account have been deleted'} 
        else
            render json: {error: 'User no found'}, status: :not_found   
        end



private 
# Deafult user can be buyer and seller
def user_params
    params.permit(:username, :email) 
end


end
