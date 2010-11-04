require 'open-uri'
require 'yaml'
github_response = open("https://github.com/api/v2/yaml/commits/list/rails/rails/master")
github_hash = YAML::load(github_response.read)
github_sort = github_hash['commits'].group_by { |commit| commit['author'] }
the_html = "<html><head><title>Github Commits by Author</head><body><h1><center>Recent Github Commits by Author</center></h1><hr>"
github_sort.each do |author, author_commits|
 the_html += "<h2>#{author['name']}</h2>"
 the_html += "<ul>"
 author_commits.each do |commit|
   the_html += "<li><strong>Commit</strong>: #{commit['id']}<br />"
   the_html += commit['message']
   the_html += "</li>"
 end
 the_html += "</ul><hr>"
end
the_html += "</body></html>"
f = File.open('github_challenge.html','w')
f.puts the_html
f.close
