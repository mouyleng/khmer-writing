class ContentsController < ApplicationController

  def index
    @lesson = Lesson.find(params[:lesson_id])
    @method = WritingMethod.find(params[:writing_method_id])
    @contents = @lesson.contents.where(:writing_method_id => params[:writing_method_id])
  end

  def new
    @lesson = Lesson.find(params[:lesson_id])
    @methods = WritingMethod.all
    @methodId = params[:writing_method_id]
    @content = @lesson.contents.new
  end

  def create
    @lesson = Lesson.find(params[:lesson_id])
    @content = @lesson.contents.new(content_params)
    upload_file
    if @content.save
      redirect_to lesson_contents_path(@lesson , :writing_method_id => params[:content][:writing_method_id])
    else
      render :new
    end
  end

  def edit
    @lesson = Lesson.find(params[:lesson_id])
    @methodId = params[:writing_method_id]
    @content = @lesson.contents.find(params[:id])
  end

  def update
    @lesson = Lesson.find(params[:lesson_id])
    @content = @lesson.contents.find(params[:id])
    upload_file
    if @content.update(content_params)
      redirect_to lesson_contents_path(@lesson, :writing_method_id => params[:content][:writing_method_id])
    else
      render :edit
    end
  end

  def destroy
    @lesson = Lesson.find(params[:lesson_id])
    @content = Content.find(params[:id])
    @content.destroy
    redirect_to lesson_contents_path(@lesson, :writing_method_id => params[:writing_method_id])
  end

  private
  def content_params
    params.require(:content).permit(:content, :writing_method_id, :content_in_khmer , :clue, :image, :audio)
  end

  def upload_file
    begin
      ClueUploader.new.store!(params[:content][:clue]) if params[:content][:clue].present?
      ImageUploader.new.store!(params[:content][:image]) if params[:content][:image].present?
      AudioUploader.new.store!(params[:content][:audio]) if params[:content][:audio].present?
    rescue Exception => e
    end
  end

end
