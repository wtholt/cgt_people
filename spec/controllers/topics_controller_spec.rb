require 'rails_helper'

RSpec.describe TopicsController, :type => :controller do

  describe "GET #index" do 
    it "populates an array of topics" do 
      topic = FactoryGirl.create(:topic)
      get :index
      assigns(:topics).should eq([topic])
    end
    it "renders the :index view" do 
      get :index
      response.should render_template :index
    end
  end

  describe "GET #show" do 
    it "assigns the requested topic to @topic" do 
      topic = FactoryGirl.create(:topic)
      get :show, id: topic
      assigns(:topic).should eq(topic)
    end
    it "renders the :show template" do 
      get :show, id: FactoryGirl.create(:topic)
      response.should render_template :show
    end
  end

  describe "GET #new" do 
    it "assigns a new Topic to @topic" do 
      topic = FactoryGirl.build(:topic)
      Topic.stub(:new).and_return(topic)
      get :new
      assigns(:topic).should == topic
    end
    it "renders the :new template" do 
      get :new, id: FactoryGirl.create(:topic)
      response.should render_template :new
    end
  end

  describe "POST #create" do 
    context "with valid attributes" do 
      it "saves the new topic in the database" do 
        expect{
          post :create, topic: FactoryGirl.attributes_for(:topic)
        }.to change(Topic, :count).by(1)
      end
      it "redirects to the index page" do 
        post :create, topic: FactoryGirl.attributes_for(:topic)
        response.should redirect_to topics_path
      end
    end

    context "with invalid attributes" do 
      it "does not save the new topic in the database" do 
        expect{
          post :create, topic:{title: "mytitle", description: ""}
        }.to_not change(Topic, :count)
      end
      it "re-renders the :new template" do 
        post :create, topic:{title: "mytitle", description: ""}
        response.should render_template :new
      end
    end
  end

  describe "PUT update" do 
    before :each do 
      @topic = FactoryGirl.create(:topic, title: "title", description: "description")
    end
    context "valid attributes" do 
      it "located the requested @topic" do 
        put :update, id: @topic, topic: FactoryGirl.attributes_for(:topic)
        assigns(:topic).should eq(@topic)
      end

      it "changes @topic's attributes" do 
        put :update, id: @topic,
          contact: FactoryGirl.attributes_for(:topic, title: "title", description: "title")
        @topic.reload
        @topic.title.should eq("title")
        @topic.description.should eq("title")
      end

      it "redirects to the updated topic" do 
        put :update, id: @topic, topic: FactoryGirl.attributes_for(:topic)
        response.should redirect_to @topic
      end
    end

    context "invalid attributes" do 

      it "locates the requested @topic" do 
        put :update, id: @topic, topic: FactoryGirl.attributes_for(:topic)
        assigns(:topic).should eq(@topic)
      end

      it "does not change @topic's attributes" do 
        put :update, id: @topic, 
          topic: FactoryGirl.attributes_for(:topic, title: "title", description: nil)
        @topic.reload
        @topic.title.should_not eq("title")
        @topic.description.should eq("description")
      end

      it "re-renders the edit method" do 
        put :update, id: @topic, topic: FactoryGirl.attributes_for(:topic)
        response.should render_template :edit
      end
    end
  end

end
