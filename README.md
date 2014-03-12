cinch-news
==========
[![Gem Version](https://badge.fury.io/rb/cinch-news.png)](http://badge.fury.io/rb/cinch-news)

A news gem/plugin for the Cinch IRC bot framework.

## Features ##

 - **Retrieves the top three stories on USA Today:** Using the !news command your bot will deliver the title, description, and shortened link to three articles.
 - **Features a category search:** If you use the !news <category> command it will fetch the top three articles in that category.
 - **Tag Search:** Using the !s-news <terms> command will deliver the top three articles matching your terms.

## Usage ##

You need to set your key for the [USA Today API][1] in your bot.rb file

    c.plugins.options[Cinch::Plugins::News] = { key: 'apikey' }

## Installation ##

You can install your gem as follows:

    gem install cinch-news

  [1]: http://developer.usatoday.com/
  
  
To see this gem in action visit #Lobby on irc://rawr.sinsira.net