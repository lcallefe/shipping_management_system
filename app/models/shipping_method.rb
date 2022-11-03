class ShippingMethod < ApplicationRecord
  has_many :delivery_time_distances, autosave: true
  has_many :price_distances, autosave: true
  has_many :price_weights, autosave: true
  has_many :vehicles, autosave: true
  belongs_to :work_orders, optional:true, autosave: true
  validates :max_weight, comparison: { greater_than: :min_weight}
  validates :max_distance, comparison: { greater_than: :min_distance}
  validates :max_delivery_time, comparison: { greater_than: :min_delivery_time}
  validates :max_price, comparison: { greater_than: :min_price}
  validates :min_distance, :max_distance, :min_price, :max_price,
            :min_delivery_time, :max_delivery_time, :flat_fee,
            :min_weight, :max_weight, :name, :presence => true
  validates :flat_fee, numericality: { greater_than: 0, only_integer: true }, 
            :allow_nil => true
  validates :min_distance, :max_distance, :min_weight, :max_weight, :min_price,
            :max_price, :min_delivery_time, :max_delivery_time,
            numericality: { greater_than: 0, only_integer: true }

  enum status: { active: 1, disabled: 0 }

  
  
end
