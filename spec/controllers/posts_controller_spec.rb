require 'rails_helper'

RSpec.describe PostsController, type: :controller do
    describe "GET #index" do
        it "renders the index template" do
            get :index
            expect(response).to render_template :index
        end
    end
    
    # end of index method
    
    describe "GET #new" do
        it "render the new template" do
            get :new
            expect(response).to render_template :new
        end
    end

    # end of new method
    
    describe "GET #show" do
        it "render the show template" do
            post = FactoryGirl.create(:post)
            get :show, id: post.id
            expect(response).to render_template :show
        end
    end
    
    # end of show method
    
    describe "POST #create" do
        it "creates a new post" do
            expect {
            post :create, post: FactoryGirl.attributes_for(:post)
            }.to change(Post, :count).by(1)
        end
        context "with valid attributes" do
            it "redirects to root_path" do
                post :create, post: FactoryGirl.attributes_for(:post)
                expect(response).to redirect_to root_path
            end
            
        end
        context "with invalid attributes" do
            it "render the new template" do
                post :create, post: FactoryGirl.attributes_for(:invalid_post)
                expect(response).to render_template :new
            end
        end
    end
    
    # end of create method
    
    describe "VERB #action" do
        it "edits a existing post" do
            post = FactoryGirl.create(:post)
            get :edit, id: post.id
            expect(response).to render_template :edit
        end
    end
    
    # end of action method
    
    describe "PUT #update" do
        context "when attribues are valid" do
            it "updates the post" do
                post = FactoryGirl.create(:post)
                put :update, id: post.id, post: FactoryGirl.attributes_for(:post, title: 'New Title', author: 'Someone')
                post.reload
                expect(post.title).to eq("New Title")
                expect(post.author).to eq("Someone")
            end
            it "redirects to root path" do
                post = FactoryGirl.create(:post)
                put :update, id: post.id, post: FactoryGirl.attributes_for(:post, title: 'New Title', author: 'Someone')
                expect(response).to redirect_to root_path
            end
        end
        context "when the attributes are not valid" do
            it "doens't updates the post" do
                post = FactoryGirl.create(:post)
                put :update, id: post.id, post: FactoryGirl.attributes_for(:post, title: 'New Title', author: 'Someone', content: 'Hey')
                expect(post.title).to_not eq("New Title")
                expect(post.author).to_not eq("Larry")
            end
            it "renders the edit page" do
                post = FactoryGirl.create(:post)
                put :update, id: post.id, post: FactoryGirl.attributes_for(:invalid_post)
                expect(response).to render_template :edit
            end
        end
    end
    
    # end of update method
    
    describe "DELETE #destroy" do
        it "deletes the post" do
            post = FactoryGirl.create(:post)
            expect {
                delete :destroy, id: post.id
            }.to change(Post, :count).by(-1)
        end

        it "redirects to root_path" do
            post = FactoryGirl.create(:post)
            delete :destroy, id: post.id
            expect(response).to redirect_to root_path
        end
    end
end