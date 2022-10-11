class SedexDez < ApplicationRecord
  has_many :first_delivery_time_distances
  has_many :first_price_distances
  has_many :first_price_weights
  has_many :vehicles
  before_validation :validate_flat_fee
  validates :flat_fee, numericality: { only_integer: true }, :allow_nil => true
  belongs_to :work_orders, optional:true
  enum status: { ativo: 1, inativo: 0 }

  private
  def set_defaults
    self.name ||= 'sedex_dez'
  end
  def validate_flat_fee
    if (!flat_fee.nil? && flat_fee <= 0)
      errors.add(:flat_fee, "deve ser maior que 0")
    end
  end
end