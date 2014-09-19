require 'rails_helper'

describe DwellingsController do
  describe "creating a dwelling" do
    before { get :new }

    it 'should show page with form to make a new dwelling' do
      expect(response.status).to eq 200
      expect(response).to render_template(:new)
    end

    # uncertain how to test when route requires current user
    it 'should redirect to show page if dwelling is created' do
      post :create, dwelling: {name: "Test dwelling", address: "123 somewhere"}

      expect(response).to redirect_to(dwelling_show_path(assigns(:dwelling)))
    end

  end

  describe "editing a dwelling" do
    before do
      @dwelling = Dwelling.create(name: "Test dwelling", address: "123 somewhere")
      get :edit, id: @dwelling
    end

    it 'should show an edit page' do
      expect(response).to render_template(:edit)
    end

    it 'should redirect to show page if dwelling is created' do
      put :update, id: @dwelling, dwelling: {name: "Test dwelling edited", address: "123"}

      expect(response).to redirect_to(dwelling_show_path(assigns(:dwelling)))
    end
  end

end
