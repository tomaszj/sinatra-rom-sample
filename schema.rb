require 'rom'
require 'axiom-memory-adapter'
require './uber_item'

ROM_ENV = ROM::Environment.setup(memory: 'memory://test') do
  schema do
    base_relation :uber_items do
      repository :memory

      attribute :id, Integer
      attribute :name, String

      key :id
    end
  end

  mapping do
    relation(:uber_items) do
      map :id, :name
      model UberItem
    end
  end
end

