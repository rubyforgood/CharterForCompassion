# Charter For Compassion 
[![Travis](https://travis-ci.org/rubyforgood/CharterForCompassion.svg?branch=master)](https://travis-ci.org/rubyforgood/CharterForCompassion)
 

## About

The [Charter for Compassion](https://www.charterforcompassion.org) is a document that urges the peoples and religions of the world to embrace the core value of compassion. The supporting organization, Charter for Compassion International, connects organizers, leaders, and individuals from around the world, providing educational resources, organizing tools, and avenues for communication.

### About this App

The goal of this application is to provide a tool to allow individuals who opt-in to connect with other individuals and organizations who are affiliated with Charter for Compassion near them or who share common interests or goals in making the world a more compassionate place.

## Contribution policy

For any changes, please create a feature branch and open a PR for it when you feel it's ready to merge. Even if there's no real disagreement about a PR, at least one other person on the team needs to look over a PR before merging. The purpose of this review requirement is to ensure shared knowledge of the app and its changes and to take advantage of the benefits of working together changes without any single person being a bottleneck to making progress.

## Getting Started

This is a Ruby on Rails app that uses Postgres since we'll likely depend on Postgres features around geolocation.
Ruby and Rails versions are specified in the project's .ruby-version and Gemfile.

Postgres installation instructions are [here](https://wiki.postgresql.org/wiki/Detailed_installation_guides).

If you have Ruby and Postgres installed, clone this repository.
Then run:
```
bundle install
bundle exec rake db:create
bundle exec rake db:migrate
```

