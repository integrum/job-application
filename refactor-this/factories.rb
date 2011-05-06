require 'rubygems'
require 'factory_girl'

Factory.sequence(:email) do |n|
  "user-#{n}@example.com"
end

Factory.define(:photo) do |photo|
  
end

Factory.define(:user) do |user|
  user.name   "Example User"
  user.email  Factory.next(:email)
  user.photo  Factory.build(:photo)
end

Factory.define(:empty_user, :class => :user) do |user|
end

Factory.define(:user_profile) do |profile|
  profile.name  "Clayton"
  profile.user  Factory.build(:user)
end
