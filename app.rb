require 'sinatra'
require './schema'
require './uber_item'

ROM_ENV.session do |session|
  items = [
    session[:uber_items].new(id: 1, name: "First item!"),
    session[:uber_items].new(id: 2, name: "Second item!"),
    session[:uber_items].new(id: 3, name: "Third item!")
  ]
  items.each { |item| session[:uber_items].save(item) }
  session.flush 
end

get '/' do
  "Hi there!"
end

get '/uber-items' do
  @all_items = ROM_ENV[:uber_items].to_a 

  "Items: #{@all_items.map(&:name).join(", ")}"
end

get '/uber-items/:id' do |item_id|
  begin
    @item = ROM_ENV[:uber_items].restrict(id: item_id.to_i).one 
  rescue
    return "404" 
  end

  "Item: id: #{@item.id}, name: #{@item.name}"
end

