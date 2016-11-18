class AnswersController < ApplicationController
  before_action :load_answer, only: [:destroy, :edit, :update]
  before_action :load_question, only: [:create, :destroy, :new]

  def new
    @answer = Answer.new
  end

  def edit
  end

  def create
    @answer = @question.answers.new(answer_params)

    if @answer.save
      redirect_to @answer.question
    else
      render :new
    end
  end

  def update
    if @answer.update(answer_params)
      redirect_to @answer.question
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy
    redirect_to @question
  end

  private

  def answer_params
    params.require(:answer).permit(:body, :question_id)
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def load_question
    @question = Question.find(params[:question_id])
  end
end
