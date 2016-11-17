class AnswersController < ApplicationController
  def new
    @answer = Answer.new()

    if Question.exists?(params[:question_id])
      @answer.question = Question.find(params[:question_id])
    else
      render status: 404
    end
  end

  def edit
    @answer = Answer.find(params[:id])
  end
end
