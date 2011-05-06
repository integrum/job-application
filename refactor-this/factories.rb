require 'rubygems'
require 'factory_girl'

Factory.sequence(:email) do |n|
  "user-#{n}@example.com"
end

Factory.define(:photo) do |photo|
end

Factory.define(:user) do |user|
  user.name    "Example User"
  user.email   Factory.next(:email)
end

Factory.define(:user_profile) do |profile|
  profile.name  'Derpy derp'
  profile.user  Factory.build(:user)
  profile.photo Factory.build(:photo)
end

Factory.define(:empty_user, :class => :user) do |user|
end

