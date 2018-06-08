class QuestionsController < ApplicationController
  skip_authorization_check only: :index
  load_and_authorize_resource
  
  # GET /questions
  def index
    options = Hash.new
    options[:search]       = params[:search]   
    options[:sort_by]      = params[:sort_by]  
    options[:category]     = params[:category]
    options[:sorting_order]= params[:sorting_order] 
    options[:answer_count] = params[:answer_count].to_i
    @questions = @questions.filter(options)
    respond_to do |format|
      format.html
    end
  end

  # GET /questions/1
  def show
    @answers = @question.answers
    respond_to do |format|
      format.html
    end
  end
  # GET /questions/new
  def new
    respond_to do |format|
      format.html
    end
  end

  # GET /questions/1/edit
  def edit
    respond_to do |format|
      format.html
    end
  end

  # POST /questions
  def create
    @question.user_id = current_user.id
    respond_to do |format|
      if @question.save
        flash[:success] = t("questions.create.success")
        format.html { redirect_to @question }
      else
        flash[:danger] = t("questions.create.error")
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /questions/1
  def update
    respond_to do |format|
      if @question.update(question_params)
        flash[:success] = t("questions.update.success")
        format.html { redirect_to @question }
      else
        flash[:danger] = t("questions.update.error")
        format.html { render :edit }
      end
    end
  end

  # DELETE /questions/1
  def destroy
    @question.destroy
    respond_to do |format|
      if @question.destroyed?
        if current_user.id != @question.user_id && current_user.admin?
          @user = @question.user
          ExampleMailer.sample_email(@user).deliver
        end
        flash[:success] = t("questions.destroy.success")
        format.html { redirect_to user_root_path }
      else
        flash[:danger] = t("questions.destroy.error")
        format.html { redirect_to user_root_path }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:title, :content, :category)
    end
end
