require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }

  describe 'GET #new' do
    context 'if related question exists' do
      before { get :new, params: { question_id: question } }

      it 'assigns new answer to @answer' do
        expect(assigns(:answer)).to be_a_new(Answer)
      end

      it 'sets :question key of a new answer to question' do
        expect(answer.question).to eq(question)
      end

      it 'renders a new view' do
        expect(response).to render_template(:new)
      end
    end

    context 'if related question does not exist' do
      it 'renders 404 page' do
        get :new, params: { question_id: 0 }
        expect(response.status).to eq(404)
      end
    end
  end

  describe 'GET #edit' do
    before { get :edit, params: { id: answer } }
    it 'assigns answer to @answer' do
      expect(assigns(:answer)).to eq(answer)
    end

    it 'renders edit view' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new answer' do
        expect {
          post :create, params: { answer: attributes_for(:answer) }
        }.to change(Answer, :count).by(1)
      end

      it 'redirects to a question view' do
        post :create, params: { answer: attributes_for(:answer) }
        expect(response).to redirect_to(question_url(assigns(:question)))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect {
          post :create, params: { answer: attributes_for(:answer) }
        }.to_not change(Answer, :count)
      end

      it 're-renders new view' do

      end
    end
  end
end
