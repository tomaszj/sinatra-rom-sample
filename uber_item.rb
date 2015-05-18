class UberItem
  attr_reader :id, :name

  def initialize(attrs)
    @id, @name = attrs.values_at(:id, :name)
  end
end

class UberItems < ROM::Relation[:memory]
  def by_id(id)
    restrict(id: id)
  end
end

class UberItemMapper < ROM::Mapper
  relation :uber_items
  register_as :entity

  model UberItem

  attribute :id
  attribute :name
end

class CreateUberItem < ROM::Commands::Create[:memory]
  register_as :create
  relation :uber_items
  result :one
end

