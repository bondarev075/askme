class UsersController < ApplicationController
  def index
    @users = [
      User.new(
        id: 1,
        name: 'Vadim',
        username: 'installero',
        avatar_link: 'https://secure.gravatar.com/avatar/' \
          '71269686e0f757ddb4f73614f43ae445?s=100'
      ),
      User.new(id: 2, name: 'Misha', username: 'aristofun')
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new ({
      name: 'Bondarev',
      username: 'bondarev075',
      avatar_link: 'https://i.pinimg.com/236x/f8/90/1d/f8901d2a9de9b46add84f91fadbc65d8--piggy-bank-easter-candy.jpg'
    })

    @questions = [
      Question.new(text: "Как дела?", created_at: Date.parse('13.08.2020')),
      Question.new(text: "Еще не родила?", created_at: Date.parse('12.08.2020'))
    ]

    @new_question = Question.new
  end
end
