class StudentsController < ApplicationController

  before_action :require_login, only: [:edit, :destroy]
  def index
    @students = Student.all
    @sess_val = session[:current_user_id]
    @current_user = ((@sess_val != "admin" and Student.find_by(id: @sess_val) == nil) ? nil : @sess_val)
  end

  def show
    @student = Student.find(params[:id])
    @department = Department.find(@student.department_id)
    @courses = []
    Enroll.all.each do |enroll|
      if enroll.student_id == @student.id
        @courses.push(Course.find(enroll.course_id))
      end
    end
  end

  def new
    @student = Student.new
    @departments = Department.all
  end

  def create
    @student = Student.new(student_params)
    @departments = Department.all
    if @student.save
      redirect_to @student
    else
      render :new
    end
  end

  def edit
    @student = Student.find(params[:id]);
    @departments = Department.all
  end
  
  def update
    @student = Student.find(params[:id]);
    if @student.update(student_params)
      redirect_to @student
    else
      render :edit
    end
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy
    redirect_to students_path
  end

  private
    def student_params
      params.require(:student).permit(:name, :rollNumber, :department_id)
    end

    def require_login
      unless logged_in?
        redirect_to login_path
      end
    end
    
    def logged_in?
      if session[:current_user_id] && Student.find(session[:current_user_id])
        return true
      else return false
      end
    end
end
