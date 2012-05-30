require 'YAML'
require 'net/http'

commits_as_yaml =
  Net::HTTP.get('github.com', '/api/v2/yaml/commits/list/rails/rails/master');

tree = YAML::load(commits_as_yaml)

authors = {}

tree["commits"].each {|c|
  author = c["author"]
  login = author["login"]
  unless(authors[login])
    authors[login] = {:name => author["name"], :commits => []}
  end
  
  authors[login][:commits].push({:id => c["id"], :message => c["message"]})  
}

puts "<html><head><title>Recent Commits to rails/rails on GitHub</title></head>"
puts "<body>"

authors.each {|login,info|
  puts "<h1>" + info[:name] + "</h1>\n<ul>"
  info[:commits].each {|c|
    puts "<li>Commit: " + c[:id] + "<br/>" + c[:message] + "</li>" 
  }
  puts "</ul>"
}
puts "</body></html>"
