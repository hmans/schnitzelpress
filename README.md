# SchnitzelPress

Homepage: http://schnitzelpress.org

A lean, mean blogging machine for hackers and fools.

[![Build Status](https://secure.travis-ci.org/teamschnitzel/schnitzelpress.png?branch=master)](http://travis-ci.org/teamschnitzel/schnitzelpress)

# Quick Start

This guide makes the following assumptions:

- **You're using a non-Windows system equipped with Ruby 1.9.2 or newer and git.** If you're on Windows, the following instructions probably won't work; however, we're working on making setting up a SchnitzelPress blog on Windows easier. Check back soon for a Windows-specific guide.

- **You're going to be hosting your SchnitzelPress blog on Heroku.** Of course, you can also host your SchnitzelPress blog on your own servers instead, in which case we will assume for now that you know what you're doing; simply skip the Heroku related steps below.

## Prepare your system

    `gem install bundler`

    `gem install schnitzelpress`

## Create a new SchnitzelPress blog

Create and initialize a SchnitzelPress project:
  
    `schnitzelpress create myblog`

Navigate to the blog's root directory

    `cd myblog`

And then run `bundle` to satisfy gem dependencies.

Now take a look at `app.rb` and configure your new blog to your liking:

    `$EDITOR app.rb`

Specifically, you'll want the `:administrator` variable to include your **own** email address.

Finally, initialize a git repository and commit your project and commit all your files:

    `git init`

    `git commit -am 'Initial commit'`

## Prepare Heroku

Create a new Heroku app based on the Caledon Cedar stack:

  `heroku apps:create myblog -s cedar`

Now add one of the two available MongoDB addons; both offer free plans. You can use either MongoLab or MongoHQ. Pick one:

`heroku addons:add mongolab:starter`

or

`heroku addons:add mongohq:free`

## Map your domain (optional)

`heroku addons:add custom_domains`

`heroku domains:add www.myblog.com`

`heroku domains:add myblog.com`

Now follow the steps detailed [here](http://devcenter.heroku.com/articles/custom-domains#dns_setup) to ensure that your DNS points to Heroku.

## Push your project to Heroku

`git push heroku master`

And you're done!

## License

See LICENSE.