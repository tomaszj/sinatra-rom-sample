class UberItem
  attr_reader :id, :name

  def initialize(attrs)
    @id, @name = attrs.values_at(:id, :name) 
  end
end

