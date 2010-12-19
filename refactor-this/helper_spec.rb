require 'rubygems'
require 'factory_girl'
#windows env using require_relative, *nix / mac should use normal require.
require_relative 'factories'
require_relative 'user_profile'
require_relative 'helper'
require_relative 'user'
require_relative 'photo'

describe "Helper" do
  before(:each) do
    @helper = Helper.new
  end
  describe "display_photo" do
    it "should return the wrench if there is no profile" do
      @helper.display_photo(nil, "100x100", {}, {}, true).should == "<img src='wrench.png' />"
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
      end
      it "should return a link" do
        @helper.display_photo(@profile, "100x100", {}, {}, true).should == "<a href='/profiles/Clayton'><img src='/Clayton/photo_100x100.jpg' /></a>"
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
      end
      it "should just an image" do
        @helper.display_photo(@profile, "100x100", {}, {}, false).should == "<img src='/Clayton/photo_100x100.jpg' />"
      end
    end
    
    describe "Without a user, but requesting a link" do
      before(:each) do
        @profile = UserProfile.new
        @profile.name = "Clayton"
      end
      it "return a default" do
        @helper.display_photo(@profile, "100x100", {}, {}, true).should == "<a href='/profiles/Clayton'><img src='default_100x100.jpg' /></a>"
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
        end
        it "return a default link" do
          @helper.display_photo(@profile, "100x100", {}, {}, true).should == "<a href='/profiles/Clayton'><img src='rep_default_100x100.jpg' /></a>"
        end
        
      end
      
      describe "With a regular user" do
        before(:each) do
          @user.stub!(:rep?).and_return(false)
        end
        it "return a default link" do
          @helper.display_photo(@profile, "100x100", {}, {}, true).should == "<a href='/profiles/Clayton'><img src='default_100x100.jpg' /></a>"
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
        end
        it "return a default link" do
          @helper.display_photo(@profile, "100x100", {}, {}, true).should == "<a href='/profiles/Clayton'><img src='default_100x100.jpg' /></a>"
        end
      end
    end
    
    
  end
end