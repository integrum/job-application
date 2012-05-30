require 'rubygems'
require 'factory_girl'
require 'factories'
require 'redgreen'
require 'user_profile'
require 'helper'
require 'user'
require 'photo'

describe "Helper" do
  before(:each) do
    @helper = Helper.new
    @helper.stub!(:profile_path).and_return("profile_path")
    @helper.stub!(:url_for_file_column).and_return("file_column_url")
    @helper.stub!(:set_image_default_html).and_return({})
  end
  describe "display_photo" do
    before do
      @helper.stub!(:image_tag).and_return("wrench.png")
    end
    it "should return the wrench if there is no profile" do
      @helper.display_photo(nil, "100x100", {}, {}, true).should == "wrench.png"
    end
        
    describe "With a profile, user and photo requesting a link" do
      before(:each) do
        @profile = UserProfile.new
        @profile.name = "Clayton"
        @user    = User.new
        @profile.user = @user
        @photo   = Photo.new
        @user.photo = @photo
        @profile.stub!(:has_valid_photo?).and_return(true)
        @helper.stub!(:image_tag).and_return("")
        @helper.stub_chain(:link_to).and_return("this link")
      end
      it "should return a link" do
        @helper.display_photo(@profile, "100x100", {}, {}, true).should == "this link"
      end
    end
    
    describe "With a profile, user and photo not requesting a link" do
      before(:each) do
        @profile = UserProfile.new
        @profile.name = "Clayton"
        @user    = User.new
        @profile.user = @user
        @photo   = Photo.new
        @user.photo = @photo
        @profile.stub!(:has_valid_photo?).and_return(true)
        @helper.stub!(:image_tag).and_return("just image")
      end
      it "should just an image" do
        @helper.display_photo(@profile, "100x100", {}, {}, false).should == "just image"
      end
    end
    
    describe "Without a user, but requesting a link" do
      before(:each) do
        @profile = UserProfile.new
        @profile.name = "Clayton"
        @profile.stub!(:has_valid_photo?).and_return(false)
        @helper.stub!(:image_tag).and_return("")
        @helper.stub_chain(:link_to).and_return("default link 100x100")
      end
      it "return a default" do
        @helper.display_photo(@profile, "100x100", {}, {}, true).should == "default link 100x100"
      end
    end
    
    
    
    describe "When the user doesn't have a photo" do
      before(:each) do
        @profile = UserProfile.new
        @profile.name = "Clayton"
        @user    = User.new
        @profile.user = @user
        @profile.stub!(:has_valid_photo?).and_return(false)
      end
      describe "With a rep user" do
        before(:each) do
          @user.stub!(:rep?).and_return(true)
          @helper.stub!(:image_tag).and_return("")
          @helper.stub_chain(:link_to).and_return("default link 190x119")
        end
        it "return a default link" do
          @helper.display_photo(@profile, "100x100", {}, {}, true).should == "default link 190x119"
        end
        
      end
      
      describe "With a regular user" do
        before(:each) do
          @user.stub!(:rep?).and_return(false)
          @helper.stub!(:image_tag).and_return("")
          @helper.stub_chain(:link_to).and_return("default link 100x100")
        end
        it "return a default link" do
          @helper.display_photo(@profile, "100x100", {}, {}, true).should == "default link 100x100"
        end
      end
    end
 
 
    describe "When the user doesn't have a photo and we don't want to display the default" do
      before(:each) do
        @profile = UserProfile.new
        @profile.name = "Clayton"
        @user    = User.new
        @profile.user = @user
        @profile.stub!(:has_valid_photo?).and_return(false)
      end
      describe "With a rep user" do
        before(:each) do
          @user.stub!(:rep?).and_return(true)
        end
        it "return a default link" do
          @helper.display_photo(@profile, "100x100", {}, {:show_default => false}, true).should == "NO DEFAULT"
        end
        
      end
      
      describe "With a regular user" do
        before(:each) do
          @user.stub!(:rep?).and_return(false)
          @helper.stub!(:image_tag).and_return("")
          @helper.stub_chain(:link_to).and_return("default link 100x100")
        end
        it "return a default link" do
          @helper.display_photo(@profile, "100x100", {}, {}, true).should == "default link 100x100"
        end
      end
    end
    
    
  end
end