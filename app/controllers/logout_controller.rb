class LogoutController < ApplicationController
    def index
        session[:current_user_id] = nil
        redirect_to root_path
    end
end