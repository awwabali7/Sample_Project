class UsersController < ApplicationController
  before_action :load_user_data, only: :create_me
  load_and_authorize_resource

  # GET /users
  def index
    respond_to do |format|
      format.html
    end
  end

  # GET /users/1
  def show
    @questions = @user.questions
    respond_to do |format|
      format.html
    end
  end
  # GET /users/new
  def new
    respond_to do |format|
      format.html
    end
  end
  # POST /users
  def create_me
    respond_to do |format|
      if @user.save
        flash[:success] = t("users.create_me.success")
        format.html { redirect_to users_path }
      else
        flash[:danger] = t("users.create_me.error")
        format.html { render :new }
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    respond_to do |format|
      if@user.destroyed?
        flash[:success] = t("users.destroy.success")
        format.html { redirect_to users_url }
      else
        flash[:danger] = t("users.destroy.error")
        format.html {redirect_to users_url}
      end
    end
  end

  private
    def load_user_data
      @user = User.new(user_params)
      unless @user.admin?
        @user[:role] = 1
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:id, :name, :email, :password, :role)
    end

end

