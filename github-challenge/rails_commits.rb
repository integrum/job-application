require 'open-uri'
require 'rubygems'
require 'json/pure'

number_of_commits = (ARGV[0] || 10).to_i

begin
  response = open("https://api.github.com/repos/rails/rails/commits?per_page=#{number_of_commits}")
rescue Exception => e
  puts "Error contacting GitHub: #{e.message}"
  exit 1
end

document_title = "Last #{number_of_commits} Commit#{number_of_commits > 1 ? 's' : ''} to rails"
html =<<-EOH
<html>
<head>
  <title>#{document_title}</title>
</head>
<body>
<section id="title">
  <h1>#{document_title}</h1>
</section>
<section id="commits">
EOH

JSON.parse(response.read).each do |commit_data|
  html << <<-EOC
  <section id='commit#{commit_data['commit']['tree']['sha']}'>
    <pre>
      <h1><img src="#{commit_data['committer']['avatar_url']}" /><span>#{commit_data['commit']['author']['name']}</span></h1>
      <ul>
        <li>Commit: #{commit_data['sha']}<br/>#{commit_data['commit']['message']}</li>
      </ul>
    </pre>
  </section>
  EOC
end

html << <<EOF
</section>
</body>
</html>
EOF

puts html
exit