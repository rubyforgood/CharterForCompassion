require 'ffaker'

FactoryGirl.define do
  factory :project do
    sequence :name do |n|
      "Project #{n}"
    end
    description FFaker::Lorem.paragraphs(2).join("\n\n")
    url FFaker::Internet.http_url
  end
end
