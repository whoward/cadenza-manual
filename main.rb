require 'sinatra'
require 'yajl'
require 'cadenza'
require 'cgi'

view_directory = File.expand_path("src", File.dirname(__FILE__))

not_found_page = File.join(view_directory, "404.cadenza")

# temporary until we get cadenza integration with sinatra
def render_view(filename)
   content = File.read(filename)

   ast = Cadenza::Parser.new.parse(content)

   context = Cadenza::BaseContext.clone
   context.instance_eval(File.read("page_context.rb"))

   Cadenza::TextRenderer.render(ast, context)
end

get '/' do
   redirect "/index.html"
end

get /^(.+).html$/ do |page|
   filename = File.join(view_directory, "#{page}.cadenza")

   if File.exists?(filename)
      [200, render_view(filename)]
   else
      [404, render_view(not_found_page)]
   end
end

post '/render' do
   context = Yajl::Parser.new(:symbolize_keys => true).parse(params[:context]) rescue nil

   template = params[:template]

   if not context or not context.is_a?(Hash)
      [400, "Invalid JSON string"]
   elsif not template
      [400, "Invalid template"]
   else
      begin
         Cadenza.render(template, context)
      rescue Exception => e
         [400, "#{e.class.name}: #{CGI::escapeHTML(e.message)}"]
      end
   end
end