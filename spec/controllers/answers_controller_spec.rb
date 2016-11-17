require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }

  describe 'GET #new' do
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

  describe 'GET #edit' do
    before { get :edit, params: { question_id: answer.question, id: answer } }
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
          post :create, params: { question_id: question, answer: attributes_for(:answer) }
        }.to change(Answer, :count).by(1)
      end

      it 'redirects to a question view' do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }
        expect(response).to redirect_to(question_path(id: question))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect {
          post :create, params: { question_id: question, answer: attributes_for(:invalid_answer) }
        }.to_not change(Answer, :count)
      end

      it 're-renders new view' do
        post :create, params: { question_id: question, answer: attributes_for(:invalid_answer) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      it 'assigns the answer to @answer' do
        patch :update, params: { id: answer,
                                 question_id: question,
                                 answer: attributes_for(:answer) }
        expect(assigns(:answer)).to eq(answer)
      end

      it 'changes answer attributes' do
        patch :update, params: { id: answer,
                                 question_id: question,
                                 answer: { body: 'New Body' } }
        answer.reload
        expect(answer.body).to eq 'New Body'
      end

      it 'redirects to question view' do
        patch :update, params: { id: answer,
                                 question_id: question,
                                 answer: attributes_for(:answer) }
        expect(response).to redirect_to(question)
      end
    end

    context 'with invalid parameters' do
      before do
        patch :update, params: { id: answer,
                                 question_id: question,
                                 answer: { body: nil } }
      end

      it 'does not change answer attributes' do
        answer.reload
        expect(answer.body).to eq 'MyText'
      end

      it 're-renders edit view' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before { answer }
    it 'removes the answer' do
      expect {
        delete :destroy, params: { id: answer, question_id: question }
      }.to change(Answer, :count).by(-1)
    end

    it 'redirects to question view' do
      delete :destroy, params: { id: answer, question_id: question }
      expect(response).to redirect_to(question)
    end
  end
end
