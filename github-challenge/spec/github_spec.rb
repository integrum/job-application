require './git_hub.rb'

describe GitHub do

  describe "when getting the commits for an invalid user" do

    before :each do
      @user    = 'derp'
      @repo    = 'rails'
      @git_hub = GitHub.new(@user, @repo)
    end

    it "should render an error message" do
      html = @git_hub.render_commits
      html.should match('<h1>Wrong user/repo</h1>')
    end
  end

  describe "when getting the commits for an invalid repo" do

    before :each do
      @user    = 'rails'
      @repo    = 'herp'
      @git_hub = GitHub.new(@user, @repo)
   end
    
    it "should render an error message" do
      html = @git_hub.render_commits
      html.should match('<h1>Wrong user/repo</h1>')
    end
  end

  describe "when getting the commits for a valid user and repo" do

    before :each do
      @user = 'juan-hawa'
      @repo = 'autotest_config'
      @git_hub = GitHub.new(@user, @repo)
    end

    describe "get_commits_grouped_by_authors" do

      it "should contain a key for every user that has a commit" do
        commits = @git_hub.get_commits_grouped_by_authors
        commits.keys.should include('Juan Hawa')
      end

      it "should fetch the commits of each user" do
        user_commits = @git_hub.get_commits_grouped_by_authors
        user_commits.each do |user, commits|
          commits.count.should == 3
        end
      end 

      it "should store the right information for each commit" do
        user_commits = @git_hub.get_commits_grouped_by_authors
        user_commits.each do |user, commits|
          commits.each do |commit|
            commit.has_key?(:commit_id).should be_true
            commit.has_key?(:commit_date).should be_true
            commit.has_key?(:commit_message).should be_true            
          end
        end
      end

      describe "when rendering the html" do
        it "should render a header for each user name" do
          user_names = @git_hub.get_commits_grouped_by_authors.keys
          html = @git_hub.render_commits
          user_names.each do |user_name|
            html.should match("<h2>#{user_name}</h2>")
          end
        end
     end
    end
  end
end
