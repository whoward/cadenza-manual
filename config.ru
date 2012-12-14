require 'bundler'
Bundler.require

require 'sprockets'
require './app'

 # don't have coffeescript wrap everything in a closure
Tilt::CoffeeScriptTemplate.default_bare = true

map '/assets' do
   environment = Sprockets::Environment.new
   environment.append_path 'app/javascripts'
   environment.append_path 'app/stylesheets'

   run environment
end

map '/' do
   run CadenzaManual
end
