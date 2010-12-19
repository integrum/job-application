require 'net/http'
require 'json'

json = JSON.parse(Net::HTTP.get URI.parse("http://github.com/api/v2/json/commits/list/rails/rails/master"))

json = json['commits'].sort{|a,b| a['committer']['name']<=>b['committer']['name']}
html = "<html><body>"
json.each do |j|
  html += "<div>"
  html += "<h1> #{j['committer']['name']} </h1>"
  html += "<p> <strong>Commit</strong>: #{j['id']} </p>"
  html += "<p> <strong>Commit Message</strong>: #{j['message']} </p>"
  html += "</div>"
end
html += "</body></html>"

File.open('index.html', 'w') do |f|
  f.puts html
end
puts "A file called index.html has been created / updated with the markup."