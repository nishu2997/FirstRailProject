class ApplicationController < ActionController::Base
    #protect_from_forgery with: :null_session
    #before_action :current_user
    #private
    #  def current_user
    #    if session[:current_user_id]=="admin"
    #    unless logged_in?
    #        redirect_to login_path
    #    end
    #  end
    
    #  def logged_in?
    #    if session[:current_user_id] && Student.find(session[:current_user_id])
    #        return true
    #    else return false
    #    end
    #  end
end
