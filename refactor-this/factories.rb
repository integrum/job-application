Factory.sequence(:email) do |n|
  "user-#{n}@example.com"
end

Factory.define(:user) do |u|
  u.name "Example User"
  u.email Factory.next(:email)
end

Factory.define(:photo) do |p|

end