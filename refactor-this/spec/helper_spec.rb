require './photo'
require './user'
require './user_profile'
require './helper'
require './factories'
  
describe "Helper" do

  before(:each) do
    @helper = Helper.new
  end

  describe "display_photo" do

    it "should return the wrench if there is no profile" do
      @helper.display_photo(nil, "100x100").should == "wrench.png"
    end

    describe "With a profile, user and photo requesting a link" do

      before(:each) do
        @profile = Factory.build(:user_profile)
        @profile.stub!(:has_valid_photo?).and_return(true)
      end

      it "should return a link" do
        @helper.display_photo(@profile, "100x100").should == "this link"
      end

    end

    describe "With a profile, user and photo not requesting a link" do

      before(:each) do
        @profile = Factory.build(:user_profile)
        @profile.stub!(:has_valid_photo?).and_return(true)
      end

      it "should just an image" do
        @helper.display_photo(@profile, "100x100", 
         {}, {:show_default => true}, false).should == "just image"
      end
 
    end
  
    describe "Without a user, but requesting a link" do

      before(:each) do
        @profile = Factory.build(:user_profile, :user => nil)
      end

      it "return a default link" do
        @helper.display_photo(@profile, "100x100").
          should == "default link 100x100"
      end
    end

    describe "When the user doesn't have a photo" do

      before(:each) do
        @user    = Factory.build(:empty_user)
        @profile = Factory.build(:user_profile, :user => @user)
      end

      describe "With a rep user" do

        before(:each) do
          @user.stub!(:rep?).and_return(true)
        end

        it "return a default link" do
          @helper.display_photo(@profile, "100x100").
            should == "default link 190x119"
        end
      end

      describe "With a regular user" do

        before(:each) do
          @user.stub!(:rep?).and_return(false)
        end

        it "return a default link" do
          @helper.display_photo(@profile, "100x100").
            should == "default link 100x100"
        end
      end
    end

    describe "When the user doesn't have a photo and we don't want to display the default" do

      before(:each) do
        @user    = Factory.build(:empty_user)
        @profile = Factory.build(:user_profile, :user => @user)
        @profile.stub!(:has_valid_photo?).and_return(false)
      end

      describe "With a rep user" do

        before(:each) do
          @user.stub!(:rep?).and_return(true)
        end

        it "return a NO DEFAULT" do
          @helper.display_photo(@profile, "100x100", {}, {:show_default => false}, true).
            should == "NO DEFAULT"
        end
      end

      describe "With a regular user" do
        before(:each) do
          @user.stub!(:rep?).and_return(false)
        end
        it "return a default link" do
          @helper.display_photo(@profile, "100x100").
            should == "default link 100x100"
        end
      end
    end
  end

  describe "dynamic methods" do

    describe "when calling an invalid method" do

      it "should raise an exeception" do
        lambda { @helper.lol }.should raise_error
      end
    end

    describe "when calling an invalid display_xyz_photo method" do

      it "should raise an exeception" do
        lambda { @helper.display_xsmall_photo }.should raise_error
      end
    end

    describe "when calling a valid display_xyz_photo method" do
      it "should do it's thing" do
        valid_photo_size = %w{small medium large huge}
        valid_photo_size.each do |photo_size|
          @helper.should_receive(:display_photo).and_return('herp')
          @helper.should_receive(:image_size).and_return('derp')
          lambda { @helper.send("display_#{photo_size}_photo".to_sym, 0) }.
            should_not raise_error
        end
      end
    end
  end
end

