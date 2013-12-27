require 'rubygems'
require 'RMagick'
include Magick

set :public_folder, 'public'
enable :logging, :dump_errors, :raise_errors

get '/' do
  "Sinatra Heroku Cedar Template - The bare minimum for a sinatra app on cedar, running rack, and using bundler."
end

get '/jpg' do 
  send_file('public/images/exif.jpg', :disposition => "inline")
end

get '/png' do

  jpg = 'public/images/exif.jpg'
  png = 'public/images/exif.png'

  `convert #{jpg} -auto-orient -background transparent -resize 100x133 -extent 270.7999999523163x70.79999995231628+-79+79! -auto-orient -resize "270x70^" +repage #{png}`
  content_type 'image/png'
  # img = Magick::Image.read(png)[0]
  # img.format = 'png'
  # img.to_blob

  send_file(png, :disposition => "inline")
end