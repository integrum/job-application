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
require 'active_support/core_ext/hash/reverse_merge'

describe "Helper" do
  before(:each) do
    @helper = Helper.new
  end
  describe "display_photo" do
    describe "If the profile is not set" do
      before do
        @helper.stub!(:image_tag) do |img|
          img
        end
      end
      it "return the wrench" do
        @helper.display_photo(nil, "100x100", {}, {}, true).should == "wrench.png"
      end
    end
        
    describe "With a profile" do
      before do
        @profile = UserProfile.new
        @profile.name = "Clayton"
      end
      describe "and user" do
        before do
	        @user    = User.new
	        @profile.user = @user
	        @html = {:class => 'thumbnail', :size => "100x100", :title => "Link to #{@profile.name}"}
	        
	        @profile.stub!(:has_valid_photo?).and_return(true)
	        @helper.stub!(:url_for_file_column).with("user", "photo", "100x100").and_return("imagefile")
		      @helper.stub!(:profile_path).with(@profile).and_return("profile_path")
	      end
	      describe "and photo" do
	        before do
	          @photo   = Photo.new
		        @user.photo = @photo
	        end
	        describe "requesting a link" do
			      before(:each) do
			        @helper.stub!(:image_tag).with("imagefile", @html).and_return("image_tag")
			        @helper.stub!(:link_to).with("image_tag", "profile_path").and_return("this link")
			      end
			      it "return a link" do
			        @helper.display_photo(@profile, "100x100", {}, {}, true).should == "this link"
			      end
			    end
			    
			    describe "not requesting a link" do
			      before(:each) do
			        @helper.stub!(:image_tag).with("imagefile", @html).and_return("just image")
			      end
			      it "return just an image" do
			        @helper.display_photo(@profile, "100x100", {}, {}, false).should == "just image"
			      end
			    end
  	    end
	    
	    
	      describe "without a photo" do
  	      before(:each) do
	          @profile.stub!(:has_valid_photo?).and_return(false)
	        end
	        describe "and the user is a rep user" do
	          before(:each) do
	            @user.stub!(:rep?).and_return(true)
	            @helper.stub!(:image_tag).with("user190x119.jpg", {}).and_return("image_tag")
			        @helper.stub!(:link_to).with("image_tag", "profile_path").and_return("default link 190x119")
	          end
	          it "return a default link" do
  	          @helper.display_photo(@profile, "100x100", {}, {}, true).should == "default link 190x119"
	          end
  	      end
      
  	      describe "and the user is a regular user" do
  	        before(:each) do
		          @user.stub!(:rep?).and_return(false)
	            @helper.stub!(:image_tag).with("user100x100.jpg", {}).and_return("image_tag")
			        @helper.stub!(:link_to).with("image_tag", "profile_path").and_return("default link 100x100")
		        end
		        it "return a default link" do
		          @helper.display_photo(@profile, "100x100", {}, {}, true).should == "default link 100x100"
		        end
		      end
	    
	        describe "and we don't want to display the default" do
			      before(:each) do
			        @profile.stub!(:has_valid_photo?).and_return(false)
			      end
			      describe "and the user is a rep user" do
			        before(:each) do
			          @user.stub!(:rep?).and_return(true)
			        end
			        it "return a default link" do
			          @helper.display_photo(@profile, "100x100", {}, {:show_default => false}, true).should == "NO DEFAULT"
			        end
			      end
		      
		        describe "and the user is a regular user" do
	            before(:each) do
			          @user.stub!(:rep?).and_return(false)
			        end
			        it "return a default link" do
			          @helper.display_photo(@profile, "100x100", {}, {}, true).should == "default link 100x100"
			        end
			      end
		      end
		    end
      end
    end
    describe "Without a user, but requesting a link" do
      before(:each) do
      end
      it "return a default" do
        @helper.display_photo(@profile, "100x100", {}, {}, true).should == "default link 100x100"
      end
    end
    
  end
end