class Order < ApplicationRecord
  belongs_to :customer
  has_many :shipping_methods
  has_one :address
end
