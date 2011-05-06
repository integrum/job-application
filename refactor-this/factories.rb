require 'rubygems'
require 'factory_girl'

Factory.sequence(:email) do |n|
  "user-#{n}@example.com"
end

Factory.define(:user) do |user|
  user.name    "Example User"
  user.email   Factory.next(:email)
end
