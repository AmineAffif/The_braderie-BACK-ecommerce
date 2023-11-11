class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :inventory, :created_at, :updated_at

  belongs_to :category
  belongs_to :brand

  class CategorySerializer < ActiveModel::Serializer
    attributes :name
  end

  class BrandSerializer < ActiveModel::Serializer
    attributes :name
  end
end
