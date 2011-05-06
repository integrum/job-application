require 'rubygems'
require 'httparty'

class GitHub

  BASE_URL = 'http://github.com/api/v2/json/commits/list'

  def initialize(user, repo)
    @user = user
    @repo = repo
  end

  def render_commits
    commits = get_commits_grouped_by_authors
    return 'Wrong user/repo' if commits.empty?
  end
  
  def get_commits_grouped_by_authors
    raw_commits.inject({}) do |commit_container, commit|
      fill_commit_data(commit, commit_container)
      commit_container
    end
  end

  private
    def raw_commits
      response =  HTTParty.get("#{BASE_URL}/#{@user}/#{@repo}/master")
      response.parsed_response['commits'] || []
    end

    def fill_commit_data(commit, commit_container)
      commit_author = get_commit_author(commit)
      commit_container[commit_author] ||= []
      commit_container[commit_author] << commit_data(commit)
    end 

    def get_commit_author(commit)
      commit['author']['name']
    end

    def commit_data(commit)
      { :commit_id      => commit['id'], 
        :commit_date    => commit['committed_date'],
        :commit_message => commit['message'] }
    end
end
