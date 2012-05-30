require 'rubygems'
require 'httparty'
require 'RedCloth'

class GitHub

  BASE_URL = 'http://github.com/api/v2/json/commits/list'

  def initialize(user, repo)
    @user = user
    @repo = repo
  end

  def render_commits
    author_commits = get_commits_grouped_by_authors
    render_tha_html(author_commits)
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

    # This is not, by any means, valid html, but it does get the job done
    def render_tha_html(author_commits)
      html_text = ""
      
      if author_commits.empty?
        html_text << "h1. Wrong user/repo\n\n"
      else
        html_text << "h1. Commits for #{@repo}\n\n"

        author_commits.each do |author, commits|
          html_text << "h2. #{author}\n\n"
          # Do pardon my use of a bracket here
          commits.each { |commit|
            html_text << "* Commit Id: #{commit[:commit_id]}\n"
            html_text << "Commited: #{commit[:commit_date]}\n"
            html_text << "Commit Message: #{commit[:commit_message]}\n"
          }
        end
      end
      RedCloth.new(html_text).to_html
    end
end
