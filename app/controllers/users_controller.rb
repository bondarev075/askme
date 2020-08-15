class UsersController < ApplicationController

  before_action :find_user, except: [:index, :create, :new]
  before_action :authorize_user, only: [:edit, :update]

  def index
    @users = User.all
  end

  def new
    redirect_to root_url, alert: 'Вы уже авторизованы на сайте' if current_user.present?
    @user = User.new
  end

  def create
    redirect_to root_url, alert: 'Вы уже авторизованы на сайте' if current_user.present?
    @user = User.new(user_params)

    if @user.save
      redirect_to root_url, notice: 'Вы успешно зарегистрированы!'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Профиль изменен!'
    else
      render :edit
    end
  end

  def show
    @questions = @user.questions.order(created_at: :desc)

    @questions_count = @questions.count
    @answers_count = @questions.where.not(answer: nil).count
    @unanswered_count = @questions_count - @answers_count

    @question_declinated = word_declination(@questions_count, 'вопрос', 'вопроса', 'вопросов')
    @answer_declinated = word_declination(@answers_count, 'ответ', 'ответа', 'ответов')

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
            :name, :username, :avatar_link)
  end

  def word_declination(number, one, few, many)
    return many if (11..14).include?(number % 100)

    last_digit = number % 10

    return one if last_digit == 1
    return few if (2..4).include?(last_digit)
    many
  end
end
