require 'rubygems'
require 'factory_girl'
require 'factories'
require 'spec'
require 'spec/autorun'
require 'redgreen'
require 'user_profile'
require 'helper'
require 'user'
require 'photo'

describe "Helper" do
  before(:each) do
    @helper = Helper.new
    #stub rails helper methods
    @helper.stub!(:image_tag).and_return{|*args| "image(#{argument_values(args)})" }
    @helper.stub!(:link_to).and_return{|*args| "link(#{argument_values(args)})"}
    @helper.stub!(:profile_path).and_return{|*args| "profile_path(#{argument_values(args)})"}
  end

  describe "display_photo" do
    it "should return the wrench if there is no profile" do
      @helper.display_photo("100x100", nil, {}, {}, true).should == "image(wrench.png)"
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
        @helper.display_photo("100x100", @profile, {}, {}, true).should =~ /^link\(.*\)$/
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
        @helper.display_photo("100x100",@profile, {}, {}, false).should_not =~ /^link\(.*\)$/
      end
    end
    
    describe "Without a user, but requesting a link" do
      before(:each) do
        @profile = UserProfile.new
        @profile.name = "Clayton"
      end
      it "return a default" do
        @helper.display_photo("100x100", @profile, {}, {}, true).should =~ /^link\(.*image\(user100x100\.jpg.*size:100x100\).*\)$/
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
          @helper.display_photo("100x100", @profile, {}, {}, true).should =~ /^link\(.*image\(user190x119\.jpg.*size:190x119\).*\)$/
        end
        
      end
      
      describe "With a regular user" do
        before(:each) do
          @user.stub!(:rep?).and_return(false)
        end
        it "return a default link" do
          @helper.display_photo("100x100", @profile, {}, {}, true).should =~ /^link\(.*image\(user100x100\.jpg.*size:100x100\).*\)$/
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
          @helper.display_photo("100x100", @profile, {}, {:show_default => false}, true).should_not =~ /^link\(.*image\(.*\),*\)$/
        end
        
      end
      
      describe "With a regular user" do
        before(:each) do
          @user.stub!(:rep?).and_return(false)
        end
        it "return a default link" do
          @helper.display_photo("100x100", @profile, {}, {}, true).should =~ /^link\(.*image\(user100x100\.jpg.*size:100x100\).*\)$/
        end
      end
    end
  end

  def argument_values(args)
    args.compact.collect{|a| a.is_a?(Hash) ? a.each_pair.collect{|k,v| "#{k}:#{v}"} : a.to_s}.join(' ')
  end
end