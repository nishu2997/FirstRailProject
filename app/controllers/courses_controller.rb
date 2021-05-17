class CoursesController < ApplicationController
  def index
    @courses = Course.all
    @sess_val = session[:current_user_id]
    @current_user = ((@sess_val != "admin" and Student.find_by(id: @sess_val) == nil) ? nil : @sess_val)
  end

  def show
    @course = Course.find(params[:id])
  end

  def new
    @course = Course.new
    @departments = Department.all
  end

  def create
    @course = Course.new(course_params)
    @departments = Department.all
    if @course.save
      redirect_to @course
    else
      render :new
    end
  end

  def edit
    @course = Course.find(params[:id]);
    @departments = Department.all
  end
  
  def update
    @course = Course.find(params[:id]);
    if @course.update(course_params)
      redirect_to @course
    else
      render :edit
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    redirect_to courses_path
  end

  private
    def course_params
      params.require(:course).permit(:name, :courseCode, :department_id)
    end
end
