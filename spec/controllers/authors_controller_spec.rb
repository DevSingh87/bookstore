require 'rails_helper'

describe AuthorsController do 
	describe "GET #index" do
		it "assigns all the authors to the @authors varaible " do
			author1 = FactoryGirl.create(:author)
			author2 = FactoryGirl.create(:author)
			get :index
			expect(assigns(:authors)).to include(author1, author2)
		end
		it "renders the index view file" do
			get :index
			expect(response).to render_template :index
		end
	end
	describe "GET #show" do
		let(:author){ author = FactoryGirl.create(:author) }
		it "assigns author id to the @author varaible " do
			get :show, id: author
			expect(assigns(:author)).to eq(author)
		end
		it "renders the show view file" do
			get :show, id: author
			expect(response).to render_template :show
		end
	end
	
end