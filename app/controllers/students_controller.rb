class StudentsController < ApplicationController

  def index
    #puts session[:_csrf_token]
    @students = Student.all
    #render json: @students[0], content_type: "application/json", status: :forbidden
  end

  def show
    @student = Student.find(params[:id])
    @department = Department.find(@student.department_id)
    @enrolls = Enroll.where(student_id: @student.id)
    @courses = Course.find(@enrolls.map {|enroll| enroll.course_id})
  end

  def new
    @student = Student.new
    @departments = Department.all
    @courses = nil
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
    @enrolls = Enroll.where(student_id: @student.id)
    @enrolledCourses = Course.find(@enrolls.map {|enroll| enroll.course_id})
    @allCourses = Course.all.select {|course| course.department_id == @student.department_id}
    @courses = @allCourses-@enrolledCourses
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
    #puts verified_request?
    #puts Base64.strict_decode64(session[:_csrf_token])
    @student = Student.find(params[:id])
    @student.destroy
    redirect_to students_path
  end

  private
    def student_params
      params.require(:student).permit(:name, :rollNumber, :department_id)
    end
end
