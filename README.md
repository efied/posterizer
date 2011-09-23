# Posterizer: Tools For Theming Posterous

Posterous is a great tool for hosting your blog. However, it suffers
from the same drawback most hosted blog solutions suffer from: theming
and previewing changes to the theme must be done through their browser.

Posterizer lets you develop and preview your Posterous blog in an 
offline fashion with a rich set of tools.  It supports the following
features:
* Posterous template tags
  * See __List of Supported Posterous Tags__
* Preview different pages within Posterous
  * Home page
  * Post with editable content
  * Page with editable content
  * Archive

# Usage

    ruby posterizer.rb

* Make changes to index.html
* Visit http://localhost:9292 in your browser to preview those changes

# Installing Your Theme At Posterous

* You have to host your own images somewhere
* Log in to your Posterous account
* Copy the contents of index.html into your blog style editor section

# Posterous Template Tags

See the full list of Posterous Tags here: http://posterous.com/theming/reference

## Supported Tags

* etc

## Unsupported Tags

* etc

## Unsupportable Tags

* etc

# Editing Post and Page Content

Edit the file in post.html or page.html.

# Features Coming Soon

* Separation of css from html
* More Posterous tag support
* Haml support
* Sass/Scss support
* Push to heroku in order to serve images
* Easily switch between themes

# Acknowledgments

Stuff.

## Similar Projects:

* Thimblr - Tumblr theme development tool (https://github.com/jphastings/thimblr)
* Fumblr - Tumblr theme development tool (https://github.com/pengwynn/fumblr)
