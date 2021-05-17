class DepartmentsController < ApplicationController
  def index
    @departments = Department.all
    @sess_val = session[:current_user_id]
    @current_user = ((@sess_val != "admin" and Student.find_by(id: @sess_val) == nil) ? nil : @sess_val)
    puts session[:current_user_id]
  end

  def new
    @department = Department.new
  end

  def show
    @department = Department.find(params[:id])
  end

  def create
    @department = Department.new(department_params)
    if @department.save
      redirect_to @department
    else
      render :new
    end
  end

  def edit
    @department = Department.find(params[:id]);
  end
  
  def update
    @department = Department.find(params[:id]);
    if @department.update(department_params)
      redirect_to @department
    else
      render :edit
    end
  end

  def destroy
    @department = Department.find(params[:id])
    @department.destroy
    redirect_to departments_path
  end

  private
    def department_params
      params.require(:department).permit(:name, :departmentCode)
    end
end
