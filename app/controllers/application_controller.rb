class ApplicationController < ActionController::API

    private 
    def current_user
        User.find_by(username: 'enmanuel')

    end
end
