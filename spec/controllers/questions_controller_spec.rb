require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { create(:question) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }
    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: question } }

    it 'assigns the question to a @question variable' do
      expect(assigns(:question)).to eq(question)
    end

    it 'populates an array of answers' do
      answers = create_list(:answer, 2, question: question)
      expect(question.answers).to match_array(answers)
    end

    it 'renders show view' do
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'assigns new question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders new view' do
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    before { get :edit, params: { id: question } }

    it 'assigns the question to @question' do
      expect(assigns(:question)).to eq(question)
    end

    it 'renders edit view' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new question in the database' do
        expect {
          post :create, params: { question: attributes_for(:question) }
        }.to change(Question, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect {
          post :create, params: { question: attributes_for(:invalid_question) }
        }.to_not change(Question, :count)
      end

      it 're-renders new view' do
        post :create, params: { question: attributes_for(:invalid_question) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'assigns the question to @question' do
        patch :update,
              params: { id: question, question: attributes_for(:question) }
        expect(assigns(:question)).to eq(question)
      end

      it 'changes question arrtibutes' do
        patch(
          :update,
          params: { id: question,
                    question: { title: 'New title', body: 'New body' } }
        )
        question.reload
        expect(question.title).to eq 'New title'
        expect(question.body).to eq 'New body'
      end

      it 'redirects to the question view' do
        patch :update,
              params: { id: question, question: attributes_for(:question) }
        expect(response).to redirect_to(question)
      end
    end

    context 'with invalid attributes' do
      before do
        patch(
          :update,
          params: { id: question,
                    question: { title: nil, body: 'New body' } }
        )
      end
      it 'changes question arrtibutes' do
        question.reload
        expect(question.title).to eq 'MyString'
        expect(question.body).to eq 'MyText'
      end

      it 'reloads the update view' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before { question }

    it 'removes the question' do
      expect {
        delete :destroy, params: { id: question }
      }.to change(Question, :count).by(-1)
    end

    it 'redirects to index view' do
      delete :destroy, params: { id: question }
      expect(response).to redirect_to(questions_path)
    end
  end
end
