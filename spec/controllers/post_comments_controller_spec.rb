require 'rails_helper'

RSpec.describe PostCommentsController, type: :controller do

  let(:valid_attributes) {
    FactoryGirl.attributes_for(:post_comment)
  }

  let(:invalid_attributes) {
    FactoryGirl.attributes_for(:post_comment, name: nil)
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PostCommentsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all post_comments as @post_comments" do
      post_comment = PostComment.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:post_comments)).to eq([post_comment])
    end
  end

  describe "GET #show" do
    it "assigns the requested post_comment as @post_comment" do
      post_comment = PostComment.create! valid_attributes
      get :show, params: {id: post_comment.to_param}, session: valid_session
      expect(assigns(:post_comment)).to eq(post_comment)
    end
  end

  describe "GET #new" do
    it "assigns a new post_comment as @post_comment" do
      get :new, params: {}, session: valid_session
      expect(assigns(:post_comment)).to be_a_new(PostComment)
    end
  end

  describe "GET #edit" do
    it "assigns the requested post_comment as @post_comment" do
      post_comment = PostComment.create! valid_attributes
      get :edit, params: {id: post_comment.to_param}, session: valid_session
      expect(assigns(:post_comment)).to eq(post_comment)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new PostComment" do
        expect {
          post :create, params: {post_comment: valid_attributes}, session: valid_session
        }.to change(PostComment, :count).by(1)
      end

      it "assigns a newly created post_comment as @post_comment" do
        post :create, params: {post_comment: valid_attributes}, session: valid_session
        expect(assigns(:post_comment)).to be_a(PostComment)
        expect(assigns(:post_comment)).to be_persisted
      end

      it "redirects to the created post_comment" do
        post :create, params: {post_comment: valid_attributes}, session: valid_session
        expect(response).to redirect_to(PostComment.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved post_comment as @post_comment" do
        post :create, params: {post_comment: invalid_attributes}, session: valid_session
        expect(assigns(:post_comment)).to be_a_new(PostComment)
      end

      it "re-renders the 'new' template" do
        post :create, params: {post_comment: invalid_attributes}, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested post_comment" do
        post_comment = PostComment.create! valid_attributes
        put :update, params: {id: post_comment.to_param, post_comment: new_attributes}, session: valid_session
        post_comment.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested post_comment as @post_comment" do
        post_comment = PostComment.create! valid_attributes
        put :update, params: {id: post_comment.to_param, post_comment: valid_attributes}, session: valid_session
        expect(assigns(:post_comment)).to eq(post_comment)
      end

      it "redirects to the post_comment" do
        post_comment = PostComment.create! valid_attributes
        put :update, params: {id: post_comment.to_param, post_comment: valid_attributes}, session: valid_session
        expect(response).to redirect_to(post_comment)
      end
    end

    context "with invalid params" do
      it "assigns the post_comment as @post_comment" do
        post_comment = PostComment.create! valid_attributes
        put :update, params: {id: post_comment.to_param, post_comment: invalid_attributes}, session: valid_session
        expect(assigns(:post_comment)).to eq(post_comment)
      end

      it "re-renders the 'edit' template" do
        post_comment = PostComment.create! valid_attributes
        put :update, params: {id: post_comment.to_param, post_comment: invalid_attributes}, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested post_comment" do
      post_comment = PostComment.create! valid_attributes
      expect {
        delete :destroy, params: {id: post_comment.to_param}, session: valid_session
      }.to change(PostComment, :count).by(-1)
    end

    it "redirects to the post_comments list" do
      post_comment = PostComment.create! valid_attributes
      delete :destroy, params: {id: post_comment.to_param}, session: valid_session
      expect(response).to redirect_to(post_comments_url)
    end
  end

end
