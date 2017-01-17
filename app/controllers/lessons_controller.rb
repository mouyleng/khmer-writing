class LessonsController < ApplicationController
  before_filter :authorize

  def new
    @grade = Grade.find(params[:grade_id])
    @lesson = @grade.lessons.build
  end

  def create
    @grade = Grade.find(params[:grade_id])
    @lesson = @grade.lessons.create(lesson_params)
    redirect_to grade_path(@grade)
  end

  def show
    @grade = Grade.find(params[:grade_id])
    @lesson = @grade.lessons.find(params[:id])
    @methods = WritingMethod.all
  end

  def edit
    @grade = Grade.find(params[:grade_id])
    @lesson = @grade.lessons.find(params[:id])
  end

  def update
    @grade = Grade.find(params[:grade_id])
    @lesson = @grade.lessons.find(params[:id])

    if @lesson.update(lesson_params)
      redirect_to grade_path(@grade)
    else
      render 'edit'
    end

  end

  def destroy
    @grade = Grade.find(params[:grade_id])
    @lesson = @grade.lessons.find(params[:id])
    @lesson.destroy
    redirect_to grade_path(@grade)
  end

  private
    def lesson_params
      params.require(:lesson).permit(:name, :code, :khmer_numeric)
    end
end
