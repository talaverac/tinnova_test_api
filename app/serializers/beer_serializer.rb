include ActiveModel::Serialization
class BeerSerializer < ActiveModel::Serializer
  attributes :id, :beer_id, :name, :description, :abv, :seen_at, :favorite
end
