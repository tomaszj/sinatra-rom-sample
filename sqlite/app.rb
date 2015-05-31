require 'sinatra'
require 'rom'

ROM.setup :sql, 'sqlite::memory'

require './uber_item'

rom = ROM.finalize.env

db = rom.repositories[:default].connection

db.create_table :uber_items do
  primary_key :id
  String :name
end


rom.command(:uber_items).create.call(id: 1, name: "First item!")
rom.command(:uber_items).create.call(id: 2, name: "Second item!")
rom.command(:uber_items).create.call(id: 3, name: "Third item!")

get '/' do
  "Hi there!"
end

get '/uber-items' do
  @all_items = rom.relation(:uber_items)
    .as(:entity)
    .to_a

  "Items: #{@all_items.map(&:name).join(", ")}"
end

get '/uber-items/:id' do |item_id|
  begin
    @item = rom
      .relation(:uber_items)
      .by_id(item_id.to_i)
      .as(:entity)
      .one!
  rescue
    return "404"
  end

  "Item: id: #{@item.id}, name: #{@item.name}"
end

