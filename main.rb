require 'sinatra'
require 'yajl'
require 'cadenza'
require 'cgi'

get '/' do
   File.read(File.join('public', 'index.html'))
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