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
	describe "GET #new" do
		it "assigns new object to the @author varaible" do
			get :new
			expect(assigns(:author)).to be_instance_of(Author)

		end

		it "renders new view file" do
			get :new
			expect(response).to render_template :new
		end
	end
	describe "POST #create" do
		context " a successful creation of an author" do
			it "creates the new author object" do
			  post :create, author: FactoryGirl.attributes_for(:author)
			  expect(Author.count).to eq(1)
			end
			it "redirects to the show page" do
			  post :create, author: FactoryGirl.attributes_for(:author)
			  expect(response).to redirect_to author_path(Author.first)
		    end
			it "sets the success flash message" do
				post :create, author: FactoryGirl.attributes_for(:author)
			    expect(flash[:success]).to be_present
			end
		end
		context " an unsuccessful creation of an author" do
			it "doesn't create an author" do
			  post :create, author: FactoryGirl.attributes_for(:author, first_name: nil)
			  expect(Author.count).to eq(0)
			end
			it "renders new template" do
			  post :create, author: FactoryGirl.attributes_for(:author, first_name: nil)
			  expect(response).to render_template :new
			end
			it "sets an error message" do 
			  post :create, author: FactoryGirl.attributes_for(:author, first_name: nil)
			  expect(flash[:alert]).to be_present
			end

		end
	end

	describe "GET #edit" do
	   let(:author){FactoryGirl.create(:author)}
       it "finds the author with the given id and assigns it to the @author variable" do
       	get :edit, id: author
       	expect(assigns(:author)).to eq(author)

       end
       it "renders the edit template" do
       	get :edit, id: author
       	expect(response).to render_template :edit
       end
	end

	describe "PUT #update" do
		
		 context "author gets updated successfully" do
		 	let(:author){FactoryGirl.create(:author)}
		 	it "updates the author object" do
		 	  put :update, author: FactoryGirl.attributes_for(:author, first_name: 'Dev'), id: author
		 	  expect(Author.first.first_name).to eq('Dev')
		 	end
		 	it "redirects to the show page" do
		 		put :update, author: FactoryGirl.attributes_for(:author, first_name: 'Dev'), id: author
		 		expect(response).to redirect_to author_path(Author.first)
		 	end
		 	it "flashes the success message" do
		 		put :update, author: FactoryGirl.attributes_for(:author, first_name: 'Dev'), id: author
		 		expect(flash[:success]).to be_present
		 	end
		 end
		 context "author does not get updated" do
		 	let(:author){FactoryGirl.create(:author, first_name: 'Dev')}
		 	it "does not update the author object" do
		 	  put :update, author: FactoryGirl.attributes_for(:author, first_name: nil), id: author
		 	  expect(Author.first.first_name).to eq('Dev')
		 	end
		 	it "renders the edit page" do
		 		put :update, author: FactoryGirl.attributes_for(:author, first_name: ''), id: author
		 		expect(response).to render_template :edit
		 	end
		 	it "flashes the alert message" do
		 		put :update, author: FactoryGirl.attributes_for(:author, first_name: ''), id: author
		 		expect(flash[:alert]).to be_present
		 	end
		 end
	end

	describe "DELETE #destroy" do
		let(:author){FactoryGirl.create(:author)}
		it "deltes the author with the given id" do
			delete :destroy, id: author
			expect(Author.count).to eq(0)
		end

		it "flashes the success message" do
			delete :destroy, id: author
			expect(flash[:success]).to be_present
		end

		it "redirects to the index page" do
			delete :destroy, id: author
			expect(response).to redirect_to authors_path
		end
	end
	
end