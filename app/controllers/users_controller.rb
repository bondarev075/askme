class UsersController < ApplicationController
  before_action :find_user, except: [:index, :create, :new]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    redirect_to root_path, alert: 'Вы уже авторизованы на сайте' if current_user.present?
    @user = User.new
  end

  def create
    redirect_to root_path, alert: 'Вы уже авторизованы на сайте' if current_user.present?
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user[:id]
      redirect_to root_path, notice: 'Вы успешно зарегистрированы!'
    else
      render :new
    end
  end

  def edit
  end

  def destroy
    if @user.destroy
      session[params[:id]] = nil
      redirect_to root_path, alert: 'Ваш профиль удален!'
    else
      render :edit
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Профиль изменен!'
    else
      render :edit
    end
  end

  def show
    @questions = @user.questions.sorted_desc
    @questions_count = @questions.count
    @answers_count = @questions.with_answers.count
    @unanswered_count = @questions_count - @answers_count

    @new_question = @user.questions.build
  end

  private

  def authorize_user
    reject_user unless @user == current_user
  end

  def find_user
    @user ||= User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
            :name, :username, :avatar_link, :profile_bg_color)
  end
end
