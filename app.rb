require 'sinatra/base'
require File.join(File.dirname(__FILE__), 'posterizer', 'posterizer.rb')

class App < Sinatra::Base
  set :root, File.dirname(__FILE__)

  get '/' do
    index_html = File.read(File.join('public', 'index.html'))
    Posterizer.parse(index_html)
  end
end
