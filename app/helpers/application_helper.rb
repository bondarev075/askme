module ApplicationHelper
  def user_avatar(user)
    if user.avatar_link.present?
      user.avatar_link
    else
      asset_path 'avatar.jpg'
    end
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end


  def question_declinated(questions_count)
    word_declination(questions_count, 'вопрос', 'вопроса', 'вопросов')
  end

  def answer_declinated(answers_count)
    word_declination(answers_count, 'ответ', 'ответа', 'ответов')
  end

  def word_declination(number, one, few, many)
    return many if (11..14).include?(number % 100)

    last_digit = number % 10

    return one if last_digit == 1
    return few if (2..4).include?(last_digit)
    many
  end
end
