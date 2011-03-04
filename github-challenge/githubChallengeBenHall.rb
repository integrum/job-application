require "rubygems"
require "json"
require "open-uri"

github_api_url = open("http://github.com/api/v2/json/commits/list/rails/rails/master")

author = JSON.parse(github_api_url.read)['commits'].group_by { |commit| commit['author'] }

#puts author
#<pre><h1>Some Person</h1><ul><li>Commit: xxxxxxyyyyzzz<br/>Commit Message</li></ul></pre>

html_output = "<html><head><title>Ben Hall - Integrum Job Application</title></head><body><pre>"

author.each do |k, v|
  html_output << "<h1>#{k['name']}</h1><ul>"
  v.each do |v|
    html_output << "<li>Commit: #{v['message']} </li>"
  end
  html_output << "</ul>"
end

html_output << "</pre></body></html>"

output_file = File.new("output.html", "w+")
output_file.puts html_output
