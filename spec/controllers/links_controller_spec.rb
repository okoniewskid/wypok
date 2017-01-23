require 'rails_helper'

RSpec.describe LinksController, type: :controller do

  let(:valid_attributes) {
    FactoryGirl.attributes_for(:link)
  }

  let(:invalid_attributes) {
    FactoryGirl.attributes_for(:link, url: nil)
  }
  
  let(:valid_session) { 
    @user = create(:user)
    sign_in @user }

  describe "GET #index" do
    it "assigns all links as @links" do
      link = Link.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:links)).to eq([link])
    end
  end

  describe "GET #show" do
    it "assigns the requested link as @link" do
      link = Link.create! valid_attributes
      get :show, params: {id: link.to_param}, session: valid_session
      expect(assigns(:link)).to eq(link)
    end
  end

  describe "GET #new" do
    it "assigns a new link as @link" do
      get :new, params: {}, session: valid_session
      expect(assigns(:link)).to be_a_new(Link)
    end
  end

  describe "GET #edit" do
    it "assigns the requested link as @link" do
      link = Link.create! valid_attributes
      get :edit, params: {id: link.to_param}, session: valid_session
      expect(assigns(:link)).to eq(link)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Link" do
        expect {
          post :create, params: {link: valid_attributes}, session: valid_session
        }.to change(Link, :count).by(1)
      end

      it "assigns a newly created link as @link" do
        post :create, params: {link: valid_attributes}, session: valid_session
        expect(assigns(:link)).to be_a(Link)
        expect(assigns(:link)).to be_persisted
      end

      it "redirects to the created link" do
        post :create, params: {link: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Link.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved link as @link" do
        post :create, params: {link: invalid_attributes}, session: valid_session
        expect(assigns(:link)).to be_a_new(Link)
      end

      it "re-renders the 'new' template" do
        post :create, params: {link: invalid_attributes}, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested link" do
      link = Link.create! valid_attributes
      expect {
        delete :destroy, params: {id: link.to_param}, session: valid_session
      }.to change(Link, :count).by(-1)
    end

    it "redirects to the links list" do
      link = Link.create! valid_attributes
      delete :destroy, params: {id: link.to_param}, session: valid_session
      expect(response).to redirect_to(links_url)
    end
  end

end
