# Contactually-Ruby

[![Code Climate](https://codeclimate.com/github/revaluate/contactually-ruby/badges/gpa.svg)](https://codeclimate.com/github/revaluate/contactually-ruby)
[![Build
Status](https://travis-ci.org/revaluate/contactually-ruby.svg?branch=master)](https://travis-ci.org/revaluate/contactually-ruby)

This is a simple API Wrapper for the Contactually API. It is not feature complete, as it does not support all available API endpoints yet, but should work for most use cases this will be fine. Feel free to contribute!

## Installation

Add this line to your application's Gemfile:

    gem 'contactually-ruby'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install contactually-ruby

## Usage

### Configuration

As `contactually-ruby` is shipped with sensible defaults, that will allow you
to start right away, there are a couple of settings you may want to adjust,
depending on your applications requirements.

The available configuration options are:

* access_token (your contactually access_token)
* contactually_url (Default: "https://api.contactually.com/v2/")

Configuration goes as follows:

```ruby
    Contactually.configure do |c|
      c.api_token         = "TOKEN FROM OAUTH"
      c.contactually_url  = "URL"
    end
```

#### How to use the gem

```ruby
    contactually = Contactually::API.new
    contacts = contactually.contacts.index
    # => [#<Contactually::Contact id=1234, ...>, #<Contactually::Contact id=1235, ...>, ...]
    notes = contactually.notes.index
    # => [#<Contactually::Note id=2345, ...>, #<Contactually::Note id=2346, ...>, ...]
    groupings = contactually.groupings.index
    # => [#<Contactually::Grouping id=3456, ...>, #<Contactually::Grouping id=3457, ...>, ...]

    contact = { contact: { first_name: 'Jane', last_name: 'Doe', ... } }
    contactually.contacts.create(contact)
    # => #<Contactually::Contact id=9876, first_name='Jane', last_name='Doe', ...>
```

Implemented endpoints are:

* Accounts
* Buckets
* Contact Groupings
* Contacts
* Contents
* Groupings
* Notes
* Tasks

The API is documented here: [Contactually API Docs](http://developers.contactually.com/docs/)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
