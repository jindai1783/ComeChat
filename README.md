# ComeChat

## Introduction

We are going to write a little Twitter clone that will allow the users to post messages to a public stream. This is a fully test covered Sinatra application.

## Try It

```
rackup
```

Then point your browser to http://localhost:9292, enjoy the chat!

## Features

* In order to use chitter as a maker I want to sign up to the service
* In order to user chitter as a maker I want to log in
* In order to avoid others using my account as a maker I want to log out
* In order to let people know what I am doing as a maker I want to post a message (peep) to chitter
* In order to see what people have to say as a maker I want to see all peeps in chronological order
* In order to start a conversation as a maker I want to reply to a peep from another maker

## Notes

* Makers sign up to chitter with their email, password, name and a username.
* The username and email are unique.
* Peeps (posts to chitter) have the name of the maker and their user handle.
* Use bcrypt to secure the passwords.
* Use data mapper and postgres to save the data.
* You don't have to be logged in to see the peeps.
* You only can peep if you are logged in.
* Work on the css to make it look good (we all like beautiful things).
