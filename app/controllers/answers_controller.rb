class AnswersController < ApplicationController
  before_action :authenticate_user_login, only: :create
  load_and_authorize_resource :question 
  load_and_authorize_resource :answer, through: :question

   # Get /questions/:question_id/answer/id/edit
  def edit
    respond_to do |format|
      format.js
    end
  end

  # Post /questions/:question_id/answers
  def create
    updated_params = answer_params.merge(user_id: current_user.id)
    @answers  = @question.answers
    @answer   = @answers.build(updated_params)
    respond_to do |format|
      if @answer.save
        flash.now[:success] = t("answers.create.success") 
        format.js
      else
        flash.now[:success] = t("answers.create.error")
        format.js
      end
    end
  end

  # PATCH/PUT questions/:question_id/answers/id
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        flash.now[:success] = t("answers.update.success")
        format.js
      else
        flash.now[:success] = t("answers.update.error")
        format.js
      end
    end
  end

  # DELETE /questions/:question_id/answers/id
  def destroy
    @answer.destroy
    respond_to do |format|
      if @answer.destroyed?
        flash.now[:success] = t("answers.destroy.success")
        format.js
      else
        flash.now[:success] = t("answers.destroy.error")
        format.js
      end  
    end
  end

  def authenticate_user_login
    if current_user.blank?
      respond_to do |format|
        flash[:danger] = t("answers.authenticate_user_login.error")
        format.html{redirect_to new_user_session_path( page_referrer: request.referrer )}
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:content)
    end

end
