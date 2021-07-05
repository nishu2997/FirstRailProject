class LoginController < ApplicationController
  def index
    @valid = true
  end

  def validate
    unless !isEmpty and valid?
      @valid = false
      render :index
    else 
      @valid = true
      redirect_to root_path
    end
  end

  private
    def require_params
      params.permit(:authenticity_token, :username, :password)
    end
  
    def isEmpty
      data = require_params
      if data[:username].empty? || data[:password].empty?
        return true
      else return false
      end
    end

    def valid?
      userDetails = require_params
      if userDetails[:username].downcase == "admin" and userDetails[:password] == "admin"
        session[:current_user_id] = "admin"
        return true
      else
        Student.all.each do |student|
          if userDetails[:username].downcase == (student[:name].split(/ /)[0].downcase + "123") and
          userDetails[:password] == (student[:name].split(/ /)[0].downcase + "@123")
            session[:current_user_id] = student[:id]
            return true
          end 
        end
      end
      return false
    end
end
