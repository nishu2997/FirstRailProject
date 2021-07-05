class EnrollsController < ApplicationController

  def index
    @student = Student.find(params[:student_id])
    @courses = Course.joins(enrolls: :student).where(student: {id: params[:student_id]})
  end

  def new
    #@student = Student.find(params[:student_id]);
    #@enrolledCourses = Course.joins(enrolls: :student).where(student: {id: params[:student_id]})
    #@totalCourses = Course.where(department_id: @student.department_id)
    #@courses = @totalCourses-@enrolledCourses
    #@enrolls = []
    #@courses.length.times do |index|
      #@enrolls.push(@student.enrolls.build)
      #puts "hello"
    #@end
    #@enroll = @student.enrolls.build
  end

  def create
    @student = Student.find(params[:student_id])
    @enroll = Enroll.new(require_params)
    @enroll = @student.enrolls.build(require_params)
    if @enroll.save
      redirect_to courses_path
    else
      @course = Course.find(@enroll.course_id)
      render "courses/show"
    end
  end

  def destroy
    @enroll = Enroll.find(params[:id])
    @enroll.destroy
    redirect_to student_enrolls_path(params[:student_id])
  end

  private

    def require_params
      params.require(:enroll).permit(:student_id, :course_id)
    end
end
