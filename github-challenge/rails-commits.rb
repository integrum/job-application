require 'net/http'
require 'uri'
require 'rubygems'
require 'json'
require 'erb'

# REST URI for Ruby on Rails Github repository most recent commits
url = "http://github.com/api/v2/json/commits/list/rails/rails/master";

# Get the commits from the URL using JSON and group them by author
data = JSON.parse(Net::HTTP.get(URI.parse(url)))['commits'].group_by { |commit| commit['author'] } 
  
# Print the HTML using the embedded ERB template
puts ERB.new(DATA.read).result(binding)

__END__
<% data.each do |author, commits| %>
<h1><%= author['name']%> (<%= author['email'] %>)</h1>
<ul>
  <% commits.each do |commit| %>
  <li><%= commit['id'] %><br/><%= commit['message'] %></li>
  <% end %>
</ul>
<% end %>