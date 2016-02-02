require 'faker'
require 'nokogiri'
require 'open-uri'

require 'sinatra'
#require 'sinatra/reloader'

techs = Nokogiri::HTML.parse(open("https://www.ruby-toolbox.com/categories/by_name", 'User-Agent' => 'firefox').read)
techs = techs.css(".group_items .link").map(&:children).map(&:first).map(&:to_s).map(&:strip)

get '/:id' do
  "Thou shalt work with : " +
  "<ul>"+
  techs.sample(params[:id].to_i).map { |e| "<li> <a href='https://www.ruby-toolbox.com/categories/#{e.gsub(' ','_')}'>#{e}</a></li>"}.join('')+
  "</ul>"
  #   @technos = techs.sample(params[:id].to_i)
  # erb :technologies
end

get '/' do
  @maxnumber = techs.size
  erb :index
  # "Use : /[number-of-technologies]"
end

post '/' do
  redirect "/#{params[:technumber]}"
end
