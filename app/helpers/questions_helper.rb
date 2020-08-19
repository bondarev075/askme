module QuestionsHelper
  def question_author(question)
    User.find(question.author) if question.author
  end

  def question_author_name(question)
    user = question_author(question)
    user.name if user
  end
end
