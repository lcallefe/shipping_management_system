class ShippingMethod < ApplicationRecord
  has_many :delivery_time_distances
  has_many :price_distances
  has_many :price_weights
  has_many :vehicles
  before_validation :validate_flat_fee
  belongs_to :work_orders, optional:true
  validates :flat_fee, numericality: { only_integer: true }, :allow_nil => true
  enum status: { active: 1, disabled: 0 }
  private
  def validate_flat_fee
    if (!flat_fee.nil? && flat_fee <= 0)
      errors.add(:flat_fee, "deve ser maior que 0")
    end
  end
end
