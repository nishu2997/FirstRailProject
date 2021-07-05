class ApplicationController < ActionController::Base
    #protect_from_forgery with: :exception
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
    before_action :current_logged_in_user
    private 
        def current_logged_in_user
            @current_user ||= session[:current_user_id] == "admin" ? "admin" : (session[:current_user_id] && Student.find_by(id: session[:current_user_id]))
        end
end
