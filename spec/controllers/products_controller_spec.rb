require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:user) { User.create(first_name: "J", last_name: "S", email: "j.s@example.com", password: "supersecret") }
  let(:product) { FactoryBot.create(:product,  

  before :each do
    request.session[:user_id] = user.id
  end

  describe '#index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it "populates an array of products" do
       product
       get :index
       assigns(:products).should eq([product])
     end
  end

  describe '#new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'sets an instance variable with a new product' do
      get :new
      expect(assigns(:product)).to(be_a_new(Product))
    end
  end

  describe '#create' do
    context 'with valid parameters' do
      def valid_request
        post :create, params: {
          product: FactoryBot.attributes_for(:product)
        }
      end

      it 'creates a new product in the database' do

        valid_request
        expect {
          post :create, params: {
            product: FactoryBot.attributes_for(:product)
          }
        }.to change { Product.count }.by(+1)
      end

      it 'redirects to the show page of that product' do
        valid_request
        expect(response).to redirect_to(product_path(Product.last))
      end
    end

    context 'with invalid parameters' do
      def invalid_request
        post :create, params: {
          product: FactoryBot.attributes_for(:product).merge({title: nil})
        }
      end

      it 'doesn\'t create a product in the database' do
        count_before = Product.count
        invalid_request
        count_after = Product.count

        expect(count_before).to eq(count_after)
      end

      it 'renders the new template' do
        invalid_request
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#show' do
    def valid_request
      get :show, params: { id: product.id }
    end

    it 'renders the show template' do
      valid_request
      expect(response).to render_template(:show)
    end

    it 'assigns an instance variable to product whose id is in the params' do
      valid_request
      expect(assigns(:product)).to eq(product)
    end
  end



  describe '#edit' do
    # context 'with no user signed in' do
    #   it 'redirects the user to the new sessions path' do
    #     get :edit, params: {id: product.id}
    #     expect(response).to redirect_to(new_session_path)
    #   end
    # end

    # context 'with user signed in' do
    #   context 'with non-owner signed in' do
    #     before do
    #       request.session[:user_id] = user.id
    #     end
    #
    #     it 'redirects to the home page' do
    #       get :edit, params: {id: product.id}
    #       expect(response).to redirect_to(home_path)
    #     end
    #     it 'alerts the user with a flash' do
    #       get :edit, params: {id: product.id}
    #       expect(flash[:alert]).to be
    #     end
    #   end
    #
    #   context 'with owner signed in' do
    #     before do
    #       request.session[:user_id] = product.user.id
    #     end
    #
    #     it 'renders the edit template' do
    #       get :edit, params: { id: product.id }
    #       expect(response).to render_template(:edit)
    #     end
    #
    #     it 'assigns an instance variable to the product being edited' do
    #       get :edit, params: { id: product.id }
    #       expect(assigns(:product)).to eq(product)
    #     end
    #   end
    # end
  # end







  describe '#update' do
    context "valid attributes" do
      let(:new_attributes) {
        {
          title: "New great product",
          description: "jdkjfgalkfhgajdfhgaljdhfglajdfkhgaljkdfgh"
        }
      }
      it "located the requested @product" do
        patch :update, params: {
          id: product.id ,product: FactoryBot.attributes_for(:product)
        }

        expect(assigns(:product)).to eq(product)
      end

      it "changes products's attributes" do
        patch :update, params: {
          id: product.id,
          product: new_attributes
        }
        product.reload

        expect(product.title).to eq(new_attributes[:title])

        # expect(product.description).to eq(new_attributes[:description])
      end

      it "redirects to the updated product" do
        patch :update, params: {
          id: product.id,
          product: new_attributes
        }
        expect(response).to redirect_to(product)
      end
    end

    # context "invalid attributes" do
    #   it "locates the requested @product" do
    #     put :update, id: @product, product: Factory.attributes_for(:invalid_product)
    #     assigns(:product).should eq(@product)
    #   end
    #
    #   it "does not change @product's attributes" do
    #     put :update, id: @product,
    #       product: Factory.attributes_for(:product, first_name: "Larry", last_name: nil)
    #     @product.reload
    #     @product.first_name.should_not eq("Larry")
    #     @product.last_name.should eq("Smith")
    #   end
    #
    #   it "re-renders the edit method" do
    #     put :update, id: @product, product: Factory.attributes_for(:invalid_product)
    #     response.should render_template :edit
    #   end
    # end
  end




  describe '#destroy' do
    it 'removes a record from the database' do
      product
      expect {
        delete :destroy, params: {id: product.id}
      }.to change { Product.count }.by(-1)
    end

    it 'redirects to the index' do
      delete :destroy, params: {id: product.id}
      expect(response).to redirect_to(products_path)
    end

    it 'alerts the user with a flash' do
      delete :destroy, params: {id: product.id}
      expect(flash[:alert]).to be
    end
  end
end
